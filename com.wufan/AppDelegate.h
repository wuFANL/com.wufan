//
//  AppDelegate.h
//  com.wufan
//
//  Created by otsoft on 2018/7/20.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XGPush.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,XGPushDelegate,XGPushTokenManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property NSException *uncaughtExceptionHandler;
@property(strong ,nonatomic)NSString *string;
@property (strong,nonatomic)UIColor *color;
@end

