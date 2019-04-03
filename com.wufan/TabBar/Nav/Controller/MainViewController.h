//
//  MainViewController.h
//  com.wufan
//
//  Created by otsoft on 2018/7/20.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBNavgationController.h"
@class MainView;
@protocol MainViewDelegate <NSObject>
@optional
-(void)tabBarCenterClick:(MainView *)centerbtn;
@end

@interface MainViewController : UITabBarController{
    MBNavgationController *PRNav;//主页
    MBNavgationController *MENav;//
    MBNavgationController *CONav;//主页
    MBNavgationController *USNav;//
    MBNavgationController *MONav;//主页
}
-(void) updateNotification:(NSString *) str;

@property (weak,nonatomic)id<MainViewDelegate>mainDelegate;

@end
