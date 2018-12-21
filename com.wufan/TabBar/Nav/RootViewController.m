//
//  RootViewController.m
//  com.wufan
//
//  Created by otsoft on 2018/7/20.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "RootViewController.h"
#import "ProfileViewController.h"
#import "MassageViewController.h"
#import "ColaViewController.h"
#import "UserViewController.h"
#import "MoreViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initViewController{
    ProfileViewController *profilevc=[[ProfileViewController alloc]init];
    MassageViewController *messagevc=[[MassageViewController alloc]init];
    ColaViewController *colavc=[[ColaViewController alloc]init];
    UserViewController *uservc=[[UserViewController alloc]init];
    MoreViewController *morevc=[[MoreViewController alloc]init];
    
    NSArray *vcArray=@[profilevc,messagevc,colavc,uservc,morevc];
    NSMutableArray *tabArray=[[NSMutableArray alloc]init];
    for (int i=0; i<vcArray.count; i++) {
        UINavigationController *navCtr=[[UINavigationController alloc]initWithRootViewController:vcArray[i]];
        [tabArray addObject:navCtr];
    }
    self.viewControllers=tabArray;
    
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
