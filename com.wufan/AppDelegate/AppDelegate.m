//
//  AppDelegate.m
//  com.wufan
//
//  Created by otsoft on 2018/7/20.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "MainViewController.h"
#import "XGPush.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<XGPushDelegate>
@end

@implementation AppDelegate

#pragma mark - XGPushDelegate
- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(NSError *)error {
//    NSLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);
//    UIViewController *ctr = [self.window rootViewController];
//    if ([ctr isKindOfClass:[UINavigationController class]]) {
//        MainViewController *viewCtr = (MainViewController *)[(UINavigationController *)ctr topViewController];
//        [viewCtr updateNotification:[NSString stringWithFormat:@"%@%@", @"启动信鸽服务", (isSuccess?@"成功":@"失败")]];
//    }
    
    //        NSLog(@"1111%s, result %@, error %@", __FUNCTION__, error?@"NO":@"OK", error);
    //        NSLog(@"2222%s, result %@, error %@", __TIME__, error?@"NO":@"OK", error);
    //        NSLog(@"3333%s, result %@, error %@", __FILE__, error?@"NO":@"OK", error);
    //       NSLog(@"4444%d, result %@, error %@", __LINE__, error?@"NO":@"OK", error);
    
}

- (void)xgPushDidFinishStop:(BOOL)isSuccess error:(NSError *)error {
//    UIViewController *ctr = [self.window rootViewController];
//    if ([ctr isKindOfClass:[UINavigationController class]]) {
//        MainViewController *viewCtr = (MainViewController *)[(UINavigationController *)ctr topViewController];
//        [viewCtr updateNotification:[NSString stringWithFormat:@"%@%@", @"注销信鸽服务", (isSuccess?@"成功":@"失败")]];
//    }
    
}

- (void)xgPushDidRegisteredDeviceToken:(NSString *)deviceToken error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, error?@"NO":@"OK", error);
}

// iOS 10 新增 API
// iOS 10 会走新 API, iOS 10 以前会走到老 API
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// App 用户点击通知
// App 用户选择通知中的行为
// App 用户在通知中心清除消息
// 无论本地推送还是远程推送都会走这个回调
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    NSLog(@"[XGDemo] click notification");
    if ([response.actionIdentifier isEqualToString:@"xgaction001"]) {
        NSLog(@"click from Action1");
    } else if ([response.actionIdentifier isEqualToString:@"xgaction002"]) {
        NSLog(@"click from Action2");
    }
    [[XGPush defaultManager] reportXGNotificationResponse:response];
    completionHandler();
    
         [[NSNotificationCenter defaultCenter]postNotificationName:@"XGPush" object:nil userInfo:response.notification.request.content.userInfo];
    
    
    
}

// App 在前台弹通知需要调用这个接口
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
#endif
- (void)xgPushDidReceiveRemoteNotification:(id)notification withCompletionHandler:(void (^)(NSUInteger))completionHandler {
    if ([notification isKindOfClass:[NSDictionary class]]) {
        completionHandler(UIBackgroundFetchResultNewData);
    } else if (@available(iOS 10.0, *)) {
        if ([notification isKindOfClass:[UNNotification class]]) {
            completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
        }
    } else {
        // Fallback on earlier versions
    }
}

- (void)xgPushDidSetBadge:(BOOL)isSuccess error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, error?@"NO":@"OK", error);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [NSThread sleepForTimeInterval:1];
//    self.window=[[UIWindow alloc]initWithFrame:screen_bound];
//    self.window.backgroundColor=[UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"allowRotation" object:self];
    
    
    
    
    MainViewController *vc=[[MainViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    [nav setNavigationBarHidden:YES animated:YES];
    
    
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:screen_bound];
    imageview.image=[UIImage imageNamed:@"启动"];
//    imageview.contentMode=UIViewContentModeScaleAspectFill;
    nav.navigationBar.translucent=NO;
    self.allowRotation=NO;
    [self.window addSubview:imageview];
    [UIView animateWithDuration:2 animations:^{
        imageview.transform=CGAffineTransformMakeScale(2.3, 2.3);
        
    }completion:^(BOOL finished) {
        [imageview removeFromSuperview];
    }];
    
    
    [[XGPush defaultManager] setEnableDebug:YES];
    XGNotificationAction *action1 = [XGNotificationAction actionWithIdentifier:@"xgaction001" title:@"xgAction1" options:XGNotificationActionOptionNone];
    XGNotificationAction *action2 = [XGNotificationAction actionWithIdentifier:@"xgaction002" title:@"xgAction2" options:XGNotificationActionOptionDestructive];
    if (action1 && action2) {
        XGNotificationCategory *category = [XGNotificationCategory categoryWithIdentifier:@"xgCategory" actions:@[action1, action2] intentIdentifiers:@[] options:XGNotificationCategoryOptionNone];
        
        XGNotificationConfigure *configure = [XGNotificationConfigure configureNotificationWithCategories:[NSSet setWithObject:category] types:XGUserNotificationTypeAlert|XGUserNotificationTypeBadge|XGUserNotificationTypeSound];
        if (configure) {
            [[XGPush defaultManager] setNotificationConfigure:configure];
        }
    }
    
    [[XGPush defaultManager] startXGWithAppID:2200312384 appKey:@"I9T5AP92CU1Z" delegate:self];
    [[XGPush defaultManager] setXgApplicationBadgeNumber:0];
    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
    
    
    
//    [self requestAuthor];
    
    /*
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIUserNotificationTypeSound];
    }*/
    
    
//    NSSetUncaughtExceptionHandler(&u);

    return YES;
}
/// 这个函数存在的意义在于：当用户在设置中关闭了通知时，程序启动时会调用此函数，我们可以获取用户的设置
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}
/// 注册失败调用
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"远程通知注册失败：%@",error);
    NSLog(@"[XGDemo] register APNS fail.\n[XGDemo] reason : %@", error);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"registerDeviceFailed" object:nil];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"deviceToken = %@",deviceToken);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//创建本地通知
/*
- (void)requestAuthor
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 设置通知的类型可以为弹窗提示,声音提示,应用图标数字提示
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        // 授权通知
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"[XGDemo] receive slient Notification");
    NSLog(@"[XGDemo] userinfo %@", userInfo);
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
//设置这个方法将
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if(self.allowRotation){
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }else{
           return UIInterfaceOrientationMaskPortrait;
    }
    
    
    
}


@end
