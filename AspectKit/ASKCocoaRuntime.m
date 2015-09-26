//
//  ASKCocoaRuntime.m
//  AspectKit
//
//  Created by Hiromi Motodera on 9/17/15.
//  Copyright (c) 2015 Hiromi Motodera. All rights reserved.
//

#import "ASKCocoaRuntime.h"

#import <objc/message.h>
#import <objc/runtime.h>

typedef NS_OPTIONS(int, ASKBlockFlags) {
    ASKBlockFlagsHasCopyDisposeHelpers = (1 << 25),
    ASKBlockFlagsHasSignature          = (1 << 30)
};

typedef struct _ASKBlock {
    __unused Class isa;
    ASKBlockFlags flags;
    __unused int reserved;
    void (__unused *invoke)(struct _ASKBlock *block, ...);
    struct {
        unsigned long int reserved;
        unsigned long int size;
        // requires ASKBlockFlagsHasCopyDisposeHelpers
        void (*copy)(void *dst, const void *src);
        void (*dispose)(const void *);
        // requires ASKBlockFlagsHasSignature
        const char *signature;
        const char *layout;
    } *descriptor;
    // imported variables
} *ASKBlockRef;

@implementation ASKCocoaRuntime

+ (NSString *)stringFromClass:(Class)clazz
{
    return [NSString stringWithCString:object_getClassName(clazz)
                              encoding:NSUTF8StringEncoding];
}

+ (Class)classFromString:(NSString *)string
{
    return objc_getClass([string cStringUsingEncoding:NSUTF8StringEncoding]);
}

+ (NSArray<NSString *> *)allClassNames
{
    return [self allClassNamesWithFiltered:nil];
}

+ (NSArray<NSString *> *)allClassNamesWithFiltered:(BOOL (^)(NSString * _Nonnull))filtered
{
    int numClasses;
    Class *classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    
    NSMutableArray<NSString *> *classNames = [@[] mutableCopy];
    if (numClasses > 0) {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            Class clazz = objc_getClass(class_getName(classes[i]));
            NSString *className = [self stringFromClass:clazz];
            if (!filtered || filtered(className)) {
                [classNames addObject:className];
            }
        }
        free(classes);
    }
    return classNames;
}

+ (Class)superClassWithClass:(Class)clazz
{
    return class_getSuperclass(clazz);
}

+ (Class)metaClassWithClass:(Class)clazz
{
    return objc_getMetaClass(class_getName(clazz));
}

+ (BOOL)respondsClass:(Class)clazz toSelector:(SEL)selector method:(ASKMethod)method
{
    switch (method) {
        case ASKMethodClass:
            return [clazz respondsToSelector:selector];
            break;
        case ASKMethodInstance:
            return [clazz instancesRespondToSelector:selector];
            break;
    }
}

+ (BOOL)respondsClass:(Class)clazz toPropertyName:(NSString *)propertyName
{
    return class_getProperty(clazz, [propertyName cStringUsingEncoding:NSUTF8StringEncoding]) != NULL;
}

+ (NSArray<NSString *> *)propertyNamesWithClass:(Class)clazz
{
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(clazz, &propertyCount);
    NSMutableArray *propertyNames = [@[] mutableCopy];
    for(NSUInteger i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        const char *propertyCString = property_getName(property);
        if(propertyCString) {
            NSString *propertyName = [NSString stringWithCString:propertyCString
                                                        encoding:NSUTF8StringEncoding];
            [propertyNames addObject:propertyName];
        }
    }
    free(properties);
    
    return propertyNames;
}

+ (SEL)selectorWithSelector:(SEL)selector prefix:(NSString *)prefix
{
    return NSSelectorFromString([prefix stringByAppendingString:NSStringFromSelector(selector)]);
}

+ (BOOL)selector:(SEL)leftSelector isEqualToSelector:(SEL)rightSelector
{
    return sel_isEqual(leftSelector, rightSelector);
}

+ (NSString *)objcTypeEncodingWithClass:(Class)clazz selector:(SEL)selector method:(ASKMethod)method
{
    Method targetMethod;
    switch (method) {
        case ASKMethodClass:
            targetMethod = class_getClassMethod(clazz, selector);
            break;
        case ASKMethodInstance:
            targetMethod = class_getInstanceMethod(clazz, selector);
            break;
    }
    
    if (!targetMethod){
        return nil;
    }
    
    return [NSString stringWithCString:method_getTypeEncoding(targetMethod)
                              encoding:NSUTF8StringEncoding];
}

+ (Class)rootResponseClassWithClass:(Class)clazz selector:(SEL)selector method:(ASKMethod)method
{
    if (![ASKCocoaRuntime respondsClass:clazz toSelector:selector method:method]) {
        return nil;
    } else if ([ASKCocoaRuntime respondsClass:[ASKCocoaRuntime superClassWithClass:clazz]
                                   toSelector:selector
                                       method:method]) {
        return [ASKCocoaRuntime rootResponseClassWithClass:clazz selector:selector method:method];
    }
    
    return clazz;
}

+ (NSMethodSignature *)methodSignatureWithClass:(Class)clazz selector:(SEL)selector method:(ASKMethod)method
{
    switch (method) {
        case ASKMethodClass:
            return [NSMethodSignature
                    signatureWithObjCTypes:method_getTypeEncoding(class_getClassMethod(clazz, selector))];
            break;
        case ASKMethodInstance:
            return [NSMethodSignature
                    signatureWithObjCTypes:method_getTypeEncoding(class_getInstanceMethod(clazz, selector))];
            break;
    }
}

+ (void)overwriteForClass:(Class)clazz selector:(SEL)selector method:(ASKMethod)method implementationBlock:(id)block
{
    IMP blockIMP = imp_implementationWithBlock(block);
    Method targetMethod;
    switch (method) {
        case ASKMethodClass:
            targetMethod = class_getClassMethod(clazz, selector);
            break;
        case ASKMethodInstance:
            targetMethod = class_getInstanceMethod(clazz, selector) ;
            break;
    }
    method_setImplementation(targetMethod, blockIMP);
}

+ (void)overwriteMessageForwardForClass:(Class)clazz selector:(SEL)selector method:(ASKMethod)method
{
    Method targetMethod;
    switch (method) {
        case ASKMethodClass:
            targetMethod = class_getClassMethod(clazz, selector);
            break;
        case ASKMethodInstance:
            targetMethod = class_getInstanceMethod(clazz, selector);
            break;
    };
    method_setImplementation(targetMethod, [self msgForwardIMPWithMethod:targetMethod]);
}

+ (BOOL)copyMethodForClass:(Class)clazz atSelector:(SEL)selector toSelector:(SEL)copySelector method:(ASKMethod)method
{
    Method targetMethod;
    switch (method) {
        case ASKMethodClass:
            targetMethod = class_getClassMethod(clazz, selector);
            break;
        case ASKMethodInstance:
            targetMethod = class_getInstanceMethod(clazz, selector);
            break;
    }
    return class_addMethod(clazz, selector, method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod));
}

+ (void)exchangeImplementationsForClass:(Class)clazz
                           fromSelector:(SEL)fromSelector
                             toSelector:(SEL)toSelector
                                 method:(ASKMethod)method
{
    Method fromMethod;
    Method toMethod;
    switch (method) {
        case ASKMethodClass:
            fromMethod = class_getClassMethod(clazz, fromSelector);
            toMethod = class_getClassMethod(clazz, toSelector);
            break;
        case ASKMethodInstance:
            fromMethod = class_getInstanceMethod(clazz, fromSelector);
            toMethod = class_getInstanceMethod(clazz, toSelector);
            break;
    }
    method_exchangeImplementations(fromMethod, toMethod);
}

+ (BOOL)addMethodForClass:(Class)clazz selector:(SEL)selector method:(ASKMethod)method implementationBlock:(id)block
{
    if ([self respondsClass:clazz toSelector:selector method:method]) {
        return NO;
    }
    
    Class targetClazz;
    switch (method) {
        case ASKMethodClass:
            targetClazz = [self metaClassWithClass:clazz];
            break;
        case ASKMethodInstance:
            targetClazz = clazz;
            break;
    }
    return class_addMethod(targetClazz,
                           selector,
                           imp_implementationWithBlock(block),
                           [self objcTypeEncodingWithBlock:block]);
}

#pragma mark - Private

+ (const char *)objcTypeEncodingWithBlock:(id)block
{
    ASKBlockRef blockRef = (__bridge void *)block;
    if (!(blockRef->flags & ASKBlockFlagsHasSignature)) {
        return nil;
    }
    void *descriptor = blockRef->descriptor;
    descriptor += 2 * sizeof(unsigned long int);
    if (blockRef->flags & ASKBlockFlagsHasCopyDisposeHelpers) {
        descriptor += 2 * sizeof(void *);
    }
    if (!descriptor) {
        return nil;
    }
    return (*(const char **)descriptor);
}

+ (IMP)msgForwardIMPWithMethod:(Method)method
{
    IMP msgForwardIMP = _objc_msgForward;
#if !defined(__arm64__)
    const char *encoding = method_getTypeEncoding(method);
    BOOL methodReturnsStructValue = encoding[0] == _C_STRUCT_B;
    if (methodReturnsStructValue) {
        @try {
            NSUInteger valueSize = 0;
            NSGetSizeAndAlignment(encoding, &valueSize, NULL);
            
            if (valueSize == 1 || valueSize == 2 || valueSize == 4 || valueSize == 8) {
                methodReturnsStructValue = NO;
            }
        } @catch (NSException *e) {}
    }
    if (methodReturnsStructValue) {
        msgForwardIMP = (IMP)_objc_msgForward_stret;
    }
#endif
    return msgForwardIMP;
}

@end
