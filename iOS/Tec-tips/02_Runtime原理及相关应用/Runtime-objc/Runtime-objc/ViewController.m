//
//  ViewController.m
//  Runtime-objc
//
//  Created by jinjin on 2020/3/2.
//  Copyright © 2020 jinjin. All rights reserved.
//

#import "ViewController.h"
#import "Runtimekit.h"
#import "TestClass.h"
#import "TestClass+SwapMethod.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
//    //1
//     NSString *className = [RuntimeKit fetchClassName:TestClass.class];
//    NSLog(@"%@", className);
    
//    // 2
//    // 下方的_var1是NSInteger类型，动态获取到的是q字母，其实是NSInteger的符号。而i就表示int类型，c表示Bool类型，d表示double类型，f则就表示float类型。
//    NSArray *ivarList = [RuntimeKit fetchIvarList:TestClass.class];
//    NSLog(@"%@", ivarList);
    
//    //3
//    NSArray *propertyList = [RuntimeKit fetchPropertyList:TestClass.class];
//    NSLog(@"%@", propertyList);
    
//    //4
//    NSArray *methodList = [RuntimeKit fetchMethodList:TestClass.class];
//    NSLog(@"%@", methodList);
    
//    //5
//    NSArray *protocolList = [RuntimeKit fetchProtocolList:TestClass.class];
//    NSLog(@"%@", protocolList);
    
    
//    //6 方法交换
//    TestClass *t = [[TestClass alloc] init];
//    [t method1];
//    [t swapMethod];
//    [t method1];
    
    //7
    TestClass *t = [[TestClass alloc] init];
    [t methodNoImp];
}

@end
