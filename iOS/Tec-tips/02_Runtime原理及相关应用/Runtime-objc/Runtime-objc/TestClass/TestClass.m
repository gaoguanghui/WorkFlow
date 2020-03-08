//
//  TestClass.m
//  Runtime-objc
//
//  Created by jinjin on 2020/3/2.
//  Copyright © 2020 jinjin. All rights reserved.
//

#import "TestClass.h"
#import "RuntimeKit.h"

@interface SecondClass : NSObject
- (void)noThisMethod:(NSString *)value;
@end

@implementation SecondClass
- (void)noThisMethod:(NSString *)value {
    NSLog(@"SecondClass中的方法实现%@", value);
}
@end

@interface TestClass() {
    NSInteger _var1;
    int _var2;
    BOOL _var3;
    double _var4;
    float _var5;
}

@property (nonatomic, strong)NSMutableArray *privateProperty1;
@property (nonatomic, strong)NSNumber *privateProperty2;
@property (nonatomic, strong)NSDictionary *privateProperty3;

@end

@implementation TestClass

+ (void)classMethod:(NSString *)value {
    NSLog(@"%s", __func__);
}

- (void)publicTestMethod1:(NSString *)value1 Second:(NSString *)value2 {
    NSLog(@"%s", __func__);
}
- (void)publicTestMethod2 {
    NSLog(@"%s", __func__);
}

- (void)method1 {
    NSLog(@"%s", __func__);
}

- (void)privateTestMethod1 {
    NSLog(@"%s", __func__);
}

- (void)privateTestMethod2 {
    NSLog(@"%s", __func__);
}

#pragma mark - 代理
- (void)test1:(NSString *)str {
    NSLog(@"%s", __func__);
}

#pragma mark - 运行时方法拦截 即 动态添加方法
- (void)dynamicAddMethod:(NSString *)value {
    NSLog(@"OC 动态替换的方法：%@", value);
}


/*
 当你调用一个类的方法时，先在本类中的方法缓存列表中进行查询，如果在缓存列表中找到了该方法的实现，就执行，如果找不到就在本类中的方列表中进行查找。在本类方列表中查找到相应的方法实现后就进行调用，如果没找到，就去父类中进行查找。如果在父类中的方法列表中找到了相应方法的实现，那么就执行，否则就执行下方的几步。
 */


/**没有找到SEL的IML实现时会执行下方的方法

@param sel 当前对象调用并且找不到IML的SEL
@return 找到其他的执行方法，并返回yes
*/
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%s", __func__);
    return NO; //NO默认情况 会接着执行forwordingTargetForSelector:方法，
    
//    [RuntimeKit addMethod:[self class] method:sel methodSelImp:@selector(dynamicAddMethod:)];
//    return YES;
}

/**
 将当前对象不存在的SEL传给其他存在该SEL的对象
 
 @param aSelector 当前类中不存在的SEL
 @return 存在该SEL的对象
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"%s", __func__);
    return self; //默认情况直接返回self 则执行常规转发
//    return [SecondClass new];   //消息转发 让SecondClass中相应的SEL去执行该方法
}

/*
 常规转发
 如果不将消息转发给其他类的对象，那么就只能自己进行处理了。如果上述方法返回self的话，会执行-methodSignatureForSelector:方法来获取方法的参数以及返回数据类型，也就是说该方法获取的是方法的签名并返回。如果上述方法返回nil的话，那么消息转发就结束，程序崩溃，报出找不到相应的方法实现的崩溃信息。
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSLog(@"%s", __func__);
    //查找父类的方法签名
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if(signature == nil) {
        signature = [NSMethodSignature signatureWithObjCTypes:"@@:"];
        
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSLog(@"%s", __func__);
    SecondClass * forwardClass = [SecondClass new];
    SEL sel = invocation.selector;
    if ([forwardClass respondsToSelector:sel]) {
        [invocation invokeWithTarget:forwardClass];
    } else {
        [self doesNotRecognizeSelector:sel];
    }
}


+ (id)sharedManager {
    static TestClass *c;
    NSLog(@"1c== %@", c);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        c = [[TestClass alloc] init];
        NSLog(@"once in >> %@", c);
    });
    NSLog(@"2c== %@", c);
    return c;
}

@end
