//
//  baseViewController.h
//  com.wufan
//
//  Created by otsoft on 2018/7/24.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface baseViewController : UIViewController
-(void) createNav:(UIViewController *)vc;

//MARK:重写左边导航栏按钮
-(void)changeLeftBtn;
@end