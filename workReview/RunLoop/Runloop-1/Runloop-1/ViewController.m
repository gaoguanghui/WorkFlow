//
//  ViewController.m
//  Runloop-1
//
//  Created by Sansi Mac on 2020/2/27.
//  Copyright © 2020 MAC. All rights reserved.
//

#import "ViewController.h"
#import "HLThread.h"
#import "HLString.h"

@interface ViewController ()


@end

__weak HLString * aStr = nil;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self threadTest];
}

- (void)threadTest {
    HLThread *subThread = [[HLThread alloc] initWithTarget:self selector:@selector(subThreadOpetion) object:nil];
    [subThread setName:@"H1"];
    [subThread start];
    
    //线程  NSRunLoop  autoreleasepool 关系 应用
    
    //线程和运行循环、自动释放池是一一对应的
    //主线程的运行循环是自动开启的
    //子线程创建并启用后 运行循环默认是不启用的，需要手动开启
    //开启方式
    /*
     NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
     [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
     [runLoop run];
     */
    //子线程中调度的任务执行完后，线程就会被销毁，若想不被销毁，需要开启运行循环
}

- (void)subThreadOpetion{
    NSLog(@"currentThread=%@", [NSThread currentThread]);
//    @autoreleasepool {
    NSLog(@"%@----currentRunLoop, currentMode= %@", [NSRunLoop currentRunLoop], [NSRunLoop currentRunLoop].currentMode);
        NSLog(@"%@---子线程任务开始", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:3.0];
        NSLog(@"%@---子线程任务结束", [NSThread currentThread]);
//    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self touch];
}

- (void)touch {
    NSLog(@"%@-- currentThread=%@", aStr, [NSThread currentThread]);
    @autoreleasepool {
        HLString * str = @"asdf";//[[HLString alloc] initWithString:@"asdf"];
        NSLog(@"%@", aStr);
        aStr = str;
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"key"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"sleep 2s later");
    
    
        
        
    }
    NSLog(@"%@", aStr);

}


@end
