//
//  MainViewController.h
//  com.wufan
//
//  Created by otsoft on 2018/7/20.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController{
    UINavigationController *PRNav;//主页
    UINavigationController *MENav;//
    UINavigationController *CONav;//主页
    UINavigationController *USNav;//
    UINavigationController *MONav;//主页
    
    
    
}
-(void) updateNotification:(NSString *) str;
@end
