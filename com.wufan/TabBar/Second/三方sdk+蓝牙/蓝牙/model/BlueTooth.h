//
//  BlueTooth.h
//  com.wufan
//
//  Created by appleadmin on 2019/4/1.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
NS_ASSUME_NONNULL_BEGIN

@interface BlueTooth : NSObject
@property(nonatomic,strong)CBCentralManager *centralManager;

@end

NS_ASSUME_NONNULL_END
