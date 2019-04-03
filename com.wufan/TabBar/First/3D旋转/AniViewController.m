//
//  AniViewController.m
//  com.wufan
//
//  Created by appleadmin on 2019/3/4.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "AniViewController.h"

@interface AniViewController ()
@property(nonatomic,strong)UIView *view1;
@property(nonatomic,strong)UIView *view2;
@property(nonatomic,strong)UIView *view3;
@property(nonatomic,strong)UIView *view4;
@property(nonatomic,strong)UIView *view5;
@property(nonatomic,strong)UIView *view6;
@property(nonatomic,strong)UIImageView *imageView;

@end
//@dynamic title;
@implementation AniViewController
@dynamic view1;
@dynamic view2;
@dynamic view3;
@dynamic view4;
@dynamic view5;
@dynamic view6;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
//    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//
//     _imageView.backgroundColor=[UIColor redColor];
    
  
    [self.view addSubview:self.imageView];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view);
        make.size.lessThanOrEqualTo(CGSizeMake(150, 150));
    }];
    
    UIButton *btn=[[UIButton alloc]init];
    [btn setTitle:@"变换下" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:btn];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.imageView);
    }];
    
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]init];
        _imageView.backgroundColor=[UIColor redColor];
          _imageView.image=[UIImage imageNamed:@"启动"];
    }
    return _imageView;
}
#pragma Event-Action
-(void)changeAction:(id)sender{
    
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
