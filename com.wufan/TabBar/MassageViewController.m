//
//  MassageViewController.m
//  com.wufan
//
//  Created by otsoft on 2018/7/20.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "MassageViewController.h"
#import "LocationViewController.h"
#import "Nutill.h"
@interface MassageViewController ()

@end

@implementation MassageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)gotodw:(id)sender {
    LocationViewController *lvc=[[LocationViewController alloc]init];
    [self.navigationController pushViewController:lvc animated:YES]; 
}

@end
