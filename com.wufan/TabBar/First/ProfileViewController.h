//
//  ProfileViewController.h
//  com.wufan
//
//  Created by otsoft on 2018/7/20.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"
#import "MYUISearchBar.h"
#import "ScanViewController.h"
#import "ewmViewController.h"
@interface ProfileViewController : baseViewController
@property (weak, nonatomic) IBOutlet UILabel *test1;
@property (weak, nonatomic) IBOutlet UILabel *test2;
@property (weak, nonatomic) IBOutlet UILabel *test3;
@property (weak, nonatomic) IBOutlet UILabel *test4;
@property (weak, nonatomic) IBOutlet UILabel *test5;
@property (weak, nonatomic) IBOutlet UILabel *test6;
@property (weak, nonatomic) IBOutlet UITextField *year;
@property (weak, nonatomic) IBOutlet UITextField *liXi;
@property (weak, nonatomic) IBOutlet UITextField *result;
@property (weak, nonatomic) IBOutlet UITextField *zijin;
@property (weak, nonatomic) IBOutlet UITextField *dqck;


//
//@property (copy,nonatomic)NSMutableDictionary *info;//接受外部变量传的值

@end
