//
//  BlueTooth.m
//  com.wufan
//
//  Created by appleadmin on 2019/4/1.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "BlueTooth.h"

@implementation BlueTooth
-(CBCentralManager *)centralManager{
    if (!_centralManager) {
        //        __weak __typeof(&*self)weakself=self;
        _centralManager=[[CBCentralManager alloc]initWithDelegate:self queue:nil];
    }
    return _centralManager;
}
@end
