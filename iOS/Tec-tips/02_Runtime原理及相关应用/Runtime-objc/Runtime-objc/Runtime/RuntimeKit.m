//
//  RuntimeKit.m
//  Runtime-objc
//
//  Created by jinjin on 2020/3/2.
//  Copyright © 2020 jinjin. All rights reserved.
//

#import "RuntimeKit.h"

@implementation RuntimeKit


+ (NSString *)fetchClassName:(Class)class{
    const char *className = class_getName(class);
    return [NSString stringWithUTF8String:className];
}


/**
 获取成员变量
 
 @param class 成员变量所在的类
 @return 返回成员变量字符串所在的数组
 */
+ (NSArray *)fetchIvarList:(Class)class {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(class, &count);
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dic[@"type"] = [NSString stringWithUTF8String:ivarType];
        dic[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        [mutableList addObject:dic];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取类的属性列表，包括私有和公有属性，既定义在延展中的属性
 
 @param class Class
 @return 属性类表数组
 */
+ (NSArray *)fetchPropertyList:(Class)class {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(class, &count);
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutableArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableArray];
}


/**
 获取对象的方法列表：getter setter 对象方法等，但不能获取类方法
 
 @param class 方法所在的类
 @return 该类的方法列表
 */
+ (NSArray *)fetchMethodList:(Class)class {
    unsigned int cout = 0;
    Method *methodList = class_copyMethodList(class, &cout);
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:cout];
    for (unsigned int i = 0; i < cout; i++) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableArray addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableArray];
}


/**
 获取协议列表
 
 @param class 实现协议的该类
 @return 返回该类实现的协议列表
 */
+ (NSArray *)fetchProtocolList:(Class)class {
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &count);
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutableArray addObject:[NSString stringWithUTF8String:protocolName]];
    }
    return [NSArray arrayWithArray:mutableArray];
}

/**
 添加新的实例方法
 
 @param class 被添加的类
 @param methodSel SEL
 @param methodSelImp 提供IMP的SEL
 */
+ (void)addMethod:(Class)class method:(SEL)methodSel methodSelImp:(SEL)methodSelImp {
    Method method = class_getInstanceMethod(class, methodSelImp);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(class, methodSel, methodIMP, types);
}

/**
 方法交换

 @param class 交换方法所在的类
 @param method1 方法1
 @param method2 方法2
 */
+ (void)methodSwap:(Class)class firstMethod:(SEL)method1 secondMethod:(SEL)method2 {
    Method firstMethod = class_getInstanceMethod(class, method1);
    Method secondMethod = class_getInstanceMethod(class, method2);
    method_exchangeImplementations(firstMethod, secondMethod);
}

@end
