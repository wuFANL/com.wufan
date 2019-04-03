//
//  MBNavgationController.m
//  com.wufan
//
//  Created by appleadmin on 2019/2/14.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "MBNavgationController.h"

@interface MBNavgationController ()

@end

@implementation MBNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//重新UINagationController的好处-push会隐藏底部tabar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    return [super pushViewController:viewController animated:animated];
}
@end
