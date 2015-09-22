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

@end
