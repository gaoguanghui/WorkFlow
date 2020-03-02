//
//  TestClass+SwapMethod.m
//  Runtime-objc
//
//  Created by jinjin on 2020/3/2.
//  Copyright © 2020 jinjin. All rights reserved.
//

#import "TestClass+SwapMethod.h"
#import "RuntimeKit.h"

@implementation TestClass (SwapMethod)

- (void)swapMethod {
    [RuntimeKit methodSwap:[self class]
               firstMethod:@selector(method1)
              secondMethod:@selector(method2)];
}

- (void)method2 {
    [self method2];
    NSLog(@"%s", __func__);
}

@end
