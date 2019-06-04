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
#import "MJViewController.h"
#import "BlueViewController.h"
#import "FMTagsView.h"
#import "SegmentViewController.h"
#import "LoginViewController.h"
#import "VideoPhotoViewController.h"
@interface MassageViewController ()<FMTagsViewDelegate>
@property(nonatomic,strong)FMTagsView *fmTagView;
@property(nonatomic,strong)NSMutableArray *dataarr;
@end

@implementation MassageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.fmTagView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:@"FMTagsView制作"];
    
}
-(FMTagsView *)fmTagView{
    if (!_fmTagView) {
        
        _fmTagView = [[FMTagsView alloc] initWithFrame:CGRectMake(0,0, kMainScreenWidth, kMainScreenHeight-100)];
        _fmTagView.contentInsets = UIEdgeInsetsZero;
        _fmTagView.tagInsets = UIEdgeInsetsMake(5, 15, 5, 15);
        _fmTagView.tagBorderWidth = 1;
        _fmTagView.tagcornerRadius = 2;
        _fmTagView.tagBorderColor = [UIColor lightGrayColor];
        _fmTagView.tagSelectedBorderColor = [UIColor lightGrayColor];
        _fmTagView.tagBackgroundColor = [UIColor whiteColor];
        _fmTagView.lineSpacing = 10;
        _fmTagView.interitemSpacing = 10;
        _fmTagView.tagFont = [UIFont systemFontOfSize:14];
        _fmTagView.tagTextColor = [UIColor grayColor];
        _fmTagView.delegate = self;
        [self.view addSubview:_fmTagView];
        _dataarr=[NSMutableArray arrayWithObjects:@"定位",@"蓝牙",@"SDWebImage，AFNetworking，MJRefresh",@"segment",@"微信登陆测试",@"拍照测试",nil];
        
        //        _dataArray = @[@"定位", @"SDWebImage，AFNetworking，MJRefresh", @"亲子装"];
        //设置数据源
        _fmTagView.tagsArray = _dataarr;
    }
    return _fmTagView;
}
#pragma mark --->fmtagviewDelegate
- (void)tagsView:(FMTagsView *)tagsView didSelectTagAtIndex:(NSUInteger)index {
//    NSString *selectedKey = self.dataarr[index];
//    UIViewController *controller = [[UIViewController alloc] init];
//    controller.view.backgroundColor = [UIColor whiteColor];
//    controller.title = selectedKey;
    switch (index) {
        case 0:
            [self gotodw];
            break;
        case 1:
            [self gotoBlueVC];
            break;
        case 2:
             [self gotoMjview];
            break;
        case 3:
            [self gotoSegment];
            break;
        case 4:
            [self gotoWX];
            break;
        case 5:
            [self gotoVideo];
            break;
        default:
            break;
    }
}

#pragma mark --->action
-(void)gotoSegment{
    SegmentViewController *segvc=[[SegmentViewController alloc]init];
    [self.navigationController pushViewController:segvc animated:YES];
}

-(void)gotoMjview{
    [self performSelector:@selector(gotonext) withObject:@"test1" afterDelay:0.1];
    
}
-(void)gotonext{
    MJViewController *mjvc=[[MJViewController alloc]init];
    [self.navigationController pushViewController:mjvc animated:YES];
}
-(void)gotoBlueVC{
    BlueViewController *blvc=[[BlueViewController alloc]init];
    [self.navigationController pushViewController:blvc animated:YES];
}
- (void)gotodw{
    LocationViewController *lvc=[[LocationViewController alloc]init];
    [self.navigationController pushViewController:lvc animated:YES]; 
}
-(void)gotoWX{
    LoginViewController *lvc=[[LoginViewController alloc]init];
    [self.navigationController pushViewController:lvc animated:YES];
}
-(void)gotoVideo{
    VideoPhotoViewController *lvc=[[VideoPhotoViewController alloc]init];
    lvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:lvc animated:YES];
}


@end
