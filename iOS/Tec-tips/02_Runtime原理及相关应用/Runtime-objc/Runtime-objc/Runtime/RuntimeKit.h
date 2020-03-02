//
//  RuntimeKit.h
//  Runtime-objc
//
//  Created by jinjin on 2020/3/2.
//  Copyright © 2020 jinjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeKit : NSObject


/**
 获取类名

 @param class 相应类
 @return 类名
 */
+ (NSString *)fetchClassName:(Class)class;


/**
 获取成员变量

 @param class 成员变量所在的类
 @return 返回成员变量字符串所在的数组
 */
+ (NSArray *)fetchIvarList:(Class)class;


/**
 获取类的属性列表，包括私有和公有属性，既定义在延展中的属性

 @param class Class
 @return 属性类表数组
 */
+ (NSArray *)fetchPropertyList:(Class)class;


/**
 获取对象的方法列表：getter setter 对象方法等，但不能获取类方法

 @param class 方法所在的类
 @return 该类的方法列表
 */
+ (NSArray *)fetchMethodList:(Class)class;


/**
 获取协议列表

 @param class 实现协议的该类
 @return 返回该类实现的协议列表
 */
+ (NSArray *)fetchProtocolList:(Class)class;


/**
 添加新的实例方法

 @param class 被添加的类
 @param methodSel SEL
 @param methodSelImp 提供IMP的SEL
 */
+ (void)addMethod:(Class)class method:(SEL)methodSel methodSelImp:(SEL)methodSelImp;

/**
 方法交换
 
 @param class 交换方法所在的类
 @param method1 方法1
 @param method2 方法2
 */
+ (void)methodSwap:(Class)class firstMethod:(SEL)method1 secondMethod:(SEL)method2;
@end

NS_ASSUME_NONNULL_END
