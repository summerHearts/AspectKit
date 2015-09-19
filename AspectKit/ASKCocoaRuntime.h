//
//  ASKCocoaRuntime.h
//  AspectKit
//
//  Created by Hiromi Motodera on 9/17/15.
//  Copyright (c) 2015 Hiromi Motodera. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ASKMethod) {
    ASKMethodClass,
    ASKMethodInstance
};

@interface ASKCocoaRuntime : NSObject

+ (nonnull NSString *)stringFromClass:(nonnull Class)clazz;

+ (nullable Class)classFromString:(nonnull NSString *)string;

+ (nonnull NSArray<NSString *> *)allClassNames;

+ (nonnull NSArray<NSString *> *)allClassNamesWithFiltered:(nullable BOOL (^)(NSString *_Nonnull))filtered;

+ (nullable Class)superClassWithClass:(nonnull Class)clazz;

+ (nonnull Class)metaClassWithClass:(nonnull Class)clazz;

+ (BOOL)respondsClass:(nonnull Class)clazz toSelector:(nonnull SEL)selector method:(ASKMethod)method;

+ (BOOL)respondsClass:(nonnull Class)clazz toPropertyName:(nonnull NSString *)propertyName;

+ (nonnull NSArray<NSString *> *)propertyNamesWithClass:(nonnull Class)clazz;

+ (nonnull SEL)selectorWithSelector:(nonnull SEL)selector prefix:(nonnull NSString *)prefix;

+ (BOOL)selector:(nonnull SEL)leftSelector isEqualToSelector:(nonnull SEL)rightSelector;

+ (nonnull NSString *)objcTypeEncodingWithClass:(nonnull Class)clazz
                                       selector:(nonnull SEL)selector
                                         method:(ASKMethod)method;

+ (nullable Class)rootResponseClassWithClass:(nonnull Class)clazz
                                    selector:(nonnull SEL)selector
                                      method:(ASKMethod)method;

+ (nullable NSMethodSignature *)methodSignatureWithClass:(nonnull Class)clazz
                                                selector:(nonnull SEL)selector
                                                  method:(ASKMethod)method;

+ (void)overwriteForClass:(nonnull Class)clazz
                 selector:(nonnull SEL)selector
                   method:(ASKMethod)method
      implementationBlock:(nonnull id)block;

+ (void)overwriteMessageForwardForClass:(nonnull Class)clazz
                               selector:(nonnull SEL)selector
                                 method:(ASKMethod)method;

+ (BOOL)copyMethodForClass:(nonnull Class)clazz
                atSelector:(nonnull SEL)selector
                toSelector:(nonnull SEL)copySelector
                    method:(ASKMethod)method;

+ (void)exchangeImplementationsForClass:(nonnull Class)clazz
                           fromSelector:(nonnull SEL)fromSelector
                             toSelector:(nonnull SEL)toSelector
                                 method:(ASKMethod)method;

+ (BOOL)addMethodForClass:(nonnull Class)clazz
                 selector:(nonnull SEL)selector
                   method:(ASKMethod)method
      implementationBlock:(nonnull id)block;

@end
