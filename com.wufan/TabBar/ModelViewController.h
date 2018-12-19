//
//  ModelViewController.h
//  com.wufan
//
//  Created by otsoft on 2018/7/20.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"
typedef void (^setblock2)(NSString *string,UIColor *color);
typedef void  (^setblock3)(NSString *string,UIColor *color);
@protocol ModeViewDelegate<NSObject>

@optional
-(void)deletgateTest:(NSString *)string  color:(UIColor *)color;
@end
@interface ModelViewController : baseViewController
@property (weak, nonatomic) IBOutlet UIWebView *Test_Webview;
@property (weak, nonatomic) IBOutlet UITextField *tfText;
@property(nonatomic,weak)id<ModeViewDelegate >delegate;
@property(nonatomic,copy)void(^setblock)(NSString *string,UIColor *color);
@property(copy,nonatomic) setblock2 block2;
-(void)returnBlock2:(setblock2 )block2;

@property(copy,nonatomic)setblock3 block3;

@end
