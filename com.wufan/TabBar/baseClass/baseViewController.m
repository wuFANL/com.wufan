//
//  baseViewController.m
//  com.wufan
//
//  Created by otsoft on 2018/7/24.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "baseViewController.h"

@interface baseViewController ()

@end

@implementation baseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backaction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)createNav:(UIViewController *)vc{

    
//    dispatch_async(dispatch_get_main_queue(), ^{
        // 隐藏系统导航栏
        vc.navigationController.navigationBar.hidden = YES;
        // 创建假的导航栏
        UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
        [vc.view addSubview:navView];
        // 创建导航栏的titleLabel
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0,44)];
        titleLabel.text = @"定位详情";
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - titleLabel.frame.size.width / 2, 0, titleLabel.frame.size.width, 44);
        [navView addSubview:titleLabel];
        // 创建导航栏右边按钮
        UIButton *right= [UIButton buttonWithType:UIButtonTypeSystem];
        [right setTitle:@"首页" forState:UIControlStateNormal];
        right.frame = CGRectMake([UIScreen mainScreen].bounds.size.width -100, 0, 100, 44);
        [right addTarget:vc action:@selector(backaction) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:right];
        // 创建导航栏左按钮
        UIButton *left= [UIButton buttonWithType:UIButtonTypeSystem];
        [left setTitle:@"返回" forState:UIControlStateNormal];
        [left addTarget:vc action:@selector(backaction) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:left];
        left.frame = CGRectMake(0, 0, 100, 44);
//    });
    
}
//MARK:重写左边导航栏按钮
-(void)changeLeftBtn{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(-5, 0, 30, 45)];
    [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    btn.contentMode=UIViewContentModeScaleAspectFit;
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIView *view=[[UIView alloc]initWithFrame:btn.frame];
    [view addSubview:btn];
    UIBarButtonItem *btnItem=[[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem=btnItem;
}


@end
