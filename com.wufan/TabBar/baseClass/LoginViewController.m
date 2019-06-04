//
//  LoginViewController.m
//  com.wufan
//
//  Created by appleadmin on 2019/4/11.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "LoginViewController.h"
#import "WXApi.h"
#import "SVProgressHUD.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *btn=[[UIButton alloc]init];
    [btn setTitle:@"微信登陆" forState:UIControlStateNormal];
    btn.titleLabel.font=kFontWith9;
    [btn setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(gotoWX:) forControlEvents:UIControlEventTouchUpInside];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(80, 50));
    }];
    
    // Do any additional setup after loading the view.
}
#pragma mark->action
-(void)gotoWX:(id)sender{
    
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req=[[SendAuthReq alloc]init];
        req.scope=@"snsapi_userinfo";
        req.state = @"youhoo";
        [WXApi sendReq:req];
    }else{
        
//      [SVProgressHUD showSuccessWithStatus:@"请求成功"];
        [SVProgressHUD showInfoWithStatus:@"登陆失败"];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
