//
//  RealtimeSearch.m
//  com.wufan
//
//  Created by appleadmin on 2018/12/17.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "RealtimeSearch.h"

@interface RealtimeSearch ()

@end

@implementation RealtimeSearch

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"调用了viewdidload");
    
}
-(instancetype)init{
    if (self) {
        self.view.backgroundColor=[UIColor orangeColor];
    }
    
    
    return self;
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
