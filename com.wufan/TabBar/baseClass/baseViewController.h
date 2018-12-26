//
//  baseViewController.h
//  com.wufan
//
//  Created by otsoft on 2018/7/24.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppEnv.h"
@interface baseViewController : UIViewController
@property (strong,nonatomic)UIView *selectBtn;
-(void) createNav:(UIViewController *)vc;

//MARK:重写左边导航栏按钮
-(void)changeLeftBtn;
-(void)selectBtnView;
@end
