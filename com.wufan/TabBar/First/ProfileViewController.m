//
//  ProfileViewController.m
//  com.wufan
//
//  Created by otsoft on 2018/7/20.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "ProfileViewController.h"
#import "ModelViewController.h"
#import "AppDelegate.h"
#import "RealtimeSearch.h"

//#import "Mason"


@interface ProfileViewController ()<ModeViewDelegate>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBarView];
    self.navigationController.navigationBar.hidden=YES;
    
//     self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
}
-(void)createBarView{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, 44)];
    view.backgroundColor=[UIColor orangeColor];
    
   
    
    
//     [self.navigationController.view addSubview:view];
    [self.navigationController.navigationBar addSubview:view];
    
    
//    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(2); make.centerY.mas_equalTo(self.navigationController.navigationBar.center.y);
//        make.size.mas_equalTo(CGSizeMake(150, 40));
//    }];
}
- (IBAction)afnetTest:(id)sender {
    
    RealtimeSearch *svc=[[RealtimeSearch alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    NSDictionary *params = @{
//                             @"action":@"GetCustomColor",
//                             @"GUID":@"testaccount",
//                             @"mc_type":@"0",
//                             @"SignCS":@"8fe563ed00ca64c0e6bdc4a5d8055b35",
//                             @"mod":@"apple",
//                             };
//    NSURLSessionDataTask *task = [manager POST:@"http://iwww.steelhome.cn/data/v1.5/dcsearch.php" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"进度更新");
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"返回数据：%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"返回错误：%@",error);
//    }];
//    [task resume];
//    base64ToString(dateurl);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)updateFile:(id)sender {
    
    
    
   
    
    
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)goto:(id)sender {
    ModelViewController *mvc=[[ModelViewController alloc]init];
    mvc.delegate=self;
    [mvc setSetblock:^(NSString *string, UIColor *color) {
        self.test3.text=string;
        [self.test3 setBackgroundColor:color];
    }];
  
    [mvc setBlock2:^(NSString *string, UIColor *color) {
        self.test4.text=string;
        [self.test4 setBackgroundColor:color];
    }];
    
    [mvc setBlock3:^(NSString *string, UIColor *color) {
        self.test5.text=string;
        [self.test5 setBackgroundColor:color];
    }];
    
    
    
    [self.navigationController pushViewController:mvc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.string) {
        self.test1.text=app.string;
        [self.test1 setBackgroundColor:app.color];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tzcz:) name:@"tzcz" object:nil];

}
-(void)tzcz:(NSNotification*)notif{
    self.test6.text=[notif.userInfo objectForKey:@"string"];
    [self.test6 setBackgroundColor:[notif.userInfo objectForKey:@"color"]];
}
-(void)deletgateTest:(NSString *)string color:(UIColor *)color{
    self.test2.text=string;
    [self.test2 setBackgroundColor:color];
}

@end
