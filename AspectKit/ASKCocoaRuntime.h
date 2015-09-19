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

+ (nullable NSString *)stringFromClass:(nonnull Class)clazz;

+ (nullable Class)classFromString:(nonnull NSString *)string;

+ (nonnull NSArray<NSString *> *)allClassNames;

+ (nonnull NSArray<NSString *> *)allClassNamesWithFiltered:(nullable BOOL (^)(NSString *_Nonnull))filtered;

+ (nonnull Class)metaClassWithClass:(nonnull Class)clazz;

+ (BOOL)respondsClass:(nonnull Class)clazz toSelector:(nonnull SEL)selector method:(ASKMethod)method;

@end
