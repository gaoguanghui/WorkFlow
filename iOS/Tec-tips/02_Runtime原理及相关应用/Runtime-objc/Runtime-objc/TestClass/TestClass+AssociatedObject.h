//
//  TestClass+AssociatedObject.h
//  Runtime-objc
//
//  Created by jinjin on 2020/3/2.
//  Copyright © 2020 jinjin. All rights reserved.
//

#import "TestClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestClass (AssociatedObject)
@property (nonatomic, strong)NSString *dynamicAddProperty;
@end

NS_ASSUME_NONNULL_END
