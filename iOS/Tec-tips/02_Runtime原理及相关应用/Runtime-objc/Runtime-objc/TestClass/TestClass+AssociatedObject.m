//
//  TestClass+AssociatedObject.m
//  Runtime-objc
//
//  Created by jinjin on 2020/3/2.
//  Copyright © 2020 jinjin. All rights reserved.
//

#import "TestClass+AssociatedObject.h"
#import "RuntimeKit.h"

#pragma mark - 动态属性关联
static char kDynamicAddProperty;

@implementation TestClass (AssociatedObject)


/**
 getter方法

 @return 返回关联属性的值
 */
- (NSString *)dynamicAddProperty {
    return objc_getAssociatedObject(self, &kDynamicAddProperty);
}

- (void)setDynamicAddProperty:(NSString *)dynamicAddProperty {
    objc_setAssociatedObject(self, &kDynamicAddProperty, dynamicAddProperty, OBJC_ASSOCIATION_RETAIN);
}

@end
