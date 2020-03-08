//
//  TestClass.h
//  Runtime-objc
//
//  Created by jinjin on 2020/3/2.
//  Copyright © 2020 jinjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TestClassProtocol <NSObject>

- (void)test1:(NSString *)str;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TestClass : NSObject<TestClassProtocol>

@property (nonatomic, strong)NSArray *publicProperty1;
@property (nonatomic, strong)NSString *publicProperty2;

@property (nonatomic, weak)id<TestClassProtocol> delegate;


+ (void)classMethod:(NSString *)value;
- (void)publicTestMethod1:(NSString *)value1 Second:(NSString *)value2;
- (void)publicTestMethod2;

- (void)method1;


/**
 消息处理和消息转发
 一个方法 没有方法实现 直接调用 会直接崩溃
 
 */
- (void)methodNoImp;


/**
 单例

 @return 
 */
+ (id)sharedManager;


@end

NS_ASSUME_NONNULL_END
