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
#import "MYUISearchBar.h"
#import "HWButton.h"
#import "MainViewController.h"
#import "AniViewController.h"
#import "ElView.h"
@interface ProfileViewController ()<ModeViewDelegate,UISearchBarDelegate,UITextFieldDelegate,MainViewDelegate,NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate>
@property(nonatomic,strong)ElView *elview;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.elview];
    
    //这个也很重要，不然view会被导航栏遮住的
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;  
    HWButton *btn=[[HWButton alloc]init];
    self.year.delegate=self;
    self.liXi.delegate=self;
    self.result.delegate=self;
    self.dqck.delegate=self;
    self.zijin.delegate=self;  
//    btn.titleLabel.adjustsFontSizeToFitWidth=YES;
    
    btn.backgroundColor=[UIColor grayColor];
    [btn setTitle:@"我的二维" forState:UIControlStateNormal];
    
    btn.titleLabel.font=[UIFont fontWithName:@"uxIconFont" size:27];
//    btn.titleLabel.font=[UIFont systemFontOfSize:15.f];
    btn.tag=100;
    [btn addTarget:self action:@selector(commitImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view).offset(20);
//        make.width.lessThanOrEqualTo(50);
    }];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//     [self.navigationItem.titleView sizeToFit];
//
//      self.navigationItem.titleView=[[MYUISearchBar alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    
//     self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
    
//    [self delegateNet];
    [self blockSessionNet];
}
-(ElView *)elview{
    if (!_elview) {
        _elview=[[ElView alloc]initWithFrame:CGRectMake(200, 50, 70, 70)];
        _elview.backgroundColor=[UIColor grayColor];
    }
    return _elview;
}
#pragma 网络请求练习
//网络请求NSURLSession block形式 不注重过程
-(void)blockSessionNet{
    NSString *url=[NSString stringWithFormat:@"%@%@",AFTEST_URL,@"?version_id=1&system_type=1"];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionTask *task=[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //session 产生的task是挂起的
        //响应
       NSDictionary *infoDict= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"shuji、、、、%@",infoDict);
        
    }];
      [task resume];
}
//网络请求 delegate 注重过程，显示进度条必须是代理模式
-(void)delegateNet{
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:AFTEST_URL]];
    NSString *bodyStr=@"version_id=1&system_type=1";
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
   //配置请求的缓存
    /*
     cachePolicy是否去缓存中拿数据，如果缓存没有数据就从服务器拿
     defaultSessionConfiguration 网络下载的数据是否进行缓存
     
     */
    request.cachePolicy=NSURLRequestUseProtocolCachePolicy;
    /*
     defaultSessionConfiguration 存到磁盘
     ephemeralSessionConfiguration 数据存磁盘
     backgroundSessionConfigurationWithIdentifier 后台模式
     
     */
    //发送
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    NSURLSessionTask *task=[session dataTaskWithRequest:request];
    [task resume];
}
//1、请求数据
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    completionHandler(NSURLSessionResponseAllow);
    NSLog(@"开始了");
}
//2、接受数据
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    NSDictionary *infoDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",infoDict);
}
//3、请求完成
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"finish--");
    
}
//二维码或者图片合成页面
- (IBAction)commitImage:(id)sender {

//    NSString *shareText = @"我是title";
//    //图片应是加载完成后的image或本地的image，否则可能会出错
//    UIImage *shareImage = [UIImage imageNamed:@"kn-2"];
//    NSURL *shareUrl = [NSURL URLWithString:@"https://www.jianshu.com/u/15d37d620d5b"];
//    NSArray *activityItems = @[shareText,shareImage,shareUrl];
//
//    
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
//    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeSaveToCameraRoll];
//    [self presentViewController:activityVC animated:TRUE completion:nil];
    /*
     
     if([WXApi isWXAppInstalled]){//判断当前设备是否安装微信客户端
     [[NetworkManager shareInstance]HomeBannerSuccess:^(NSArray * _Nonnull bannerArray) {
     WXMediaMessage *message = [WXMediaMessage message];
     WXImageObject *imageobj=[WXImageObject object];
     HomeBannerModel *model=bannerArray[0];
     imageobj.imageData= [NSData dataWithContentsOfURL:[NSURL URLWithString:model.img]];
     message.mediaObject=imageobj;
     SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
     sendReq.bText = NO;//不使用文本信息
     sendReq.message = message;
     sendReq.scene = WXSceneTimeline;//分享到好友会话
     
     [WXApi sendReq:sendReq];//发送对象实例
     } failure:^(NSString * _Nonnull failureMessage) {
     [self showHint:failureMessage];
     }];
     }else{
     [self showHint:@"请先安装微信"];
     }
     
    
     */
    
    
    ewmViewController *vc=[[ewmViewController alloc]init];
    UIButton *button=(UIButton *)sender;
    //    判断是哪个按钮点过来的
    if (button.tag==100) {
        [vc.info setValue:@"ewm" forKey:@"view"];
    }else{
        [vc.info setValue:@"TP" forKey:@"view"];
    }
    //    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    //    self.hidesBottomBarWhenPushed = NO;
    
}
- (IBAction)afnetTest:(id)sender {
    
    RealtimeSearch *svc=[[RealtimeSearch alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
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
-(void)setSearchBar{
    
    UIView *sview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 255, 30)];
    sview.backgroundColor=RGBHex(0Xf5f5f5);
    sview.clipsToBounds=NO;
    [sview addSubview:self.search];
    UIButton *addbutton=[[UIButton alloc]initWithFrame:CGRectMake(230, 0, 25, 30)];
    [addbutton setImage:[UIImage imageNamed:@"erweima"] forState:UIControlStateNormal]; addbutton.imageView.contentMode=UIViewContentModeScaleToFill;
    [addbutton addTarget:self action:@selector(ewm) forControlEvents:UIControlEventTouchUpInside];
    addbutton.backgroundColor=RGBHex(0Xf5f5f5);
    
    [sview addSubview:addbutton];
    
//    [addbutton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(sview).offset(0);
//    }];
    

    self.navigationItem.titleView=sview;
    self.navigationItem.titleView.frame=CGRectMake(0, 0, 255, 30);
    for(UIView *subView in self.search.subviews.firstObject.subviews){
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField *searchField=(UITextField *)subView;
            //            searchField.backgroundColor=RGBHex(0Xf5f5f5);
            searchField.backgroundColor=RGBHex(0Xf5f5f5);
//            [searchField.rightView addSubview:addbutton];
//           searchField.rightViewMode=UITextFieldViewModeAlways;
            searchField.clearButtonMode = UITextFieldViewModeNever;
            searchField.layer.borderWidth=0.f;
            
        }
    }
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
      [self  setNavgationBar];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
//    UIBarButtonItem *barItem=[[UIBarButtonItem alloc]initWithCustomView:self.search];
//    self.navigationItem.rightBarButtonItem=barItem;
//    view.backgroundColor=[UIColor redColor];
    [self setSearchBar];
    self.view.backgroundColor=[UIColor whiteColor];
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.string) {
        self.test1.text=app.string;
        [self.test1 setBackgroundColor:app.color];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tzcz:) name:@"tzcz" object:nil];
}
-(void)ewm{
    NSLog(@"调用成功");
    ScanViewController *vc=[[ScanViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//重写UIbutton等的模糊行高
- (CGSize)intrinsicContentSize
{
    return CGSizeMake(400, 44);
}


-(void)tzcz:(NSNotification*)notif{
    self.test6.text=[notif.userInfo objectForKey:@"string"];
    [self.test6 setBackgroundColor:[notif.userInfo objectForKey:@"color"]];
}
-(void)deletgateTest:(NSString *)string color:(UIColor *)color{
    self.test2.text=string;
    [self.test2 setBackgroundColor:color];
}
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
//    self.navigationController.navigationBar.backgroundColor

}
-(void)setNavigationBarBackgroundColor:(UIColor *)color{
     UIView *navigationBar = [[[UIApplication sharedApplication] valueForKey:@"navigationBarWindow"] valueForKey:@"navigationBar"];
    if ([navigationBar respondsToSelector:@selector(setBackgroundColor:)]) {
        navigationBar.backgroundColor = color;
    }
}

//调整图片大小
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
-(void)setNavgationBar{
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    // 导航栏（navigationbar）
    CGRect rectNav = self.navigationController.navigationBar.frame;
    UIImage *title_bg = [UIImage imageNamed:@"sye_bg"];//获取图片
    CGSize titleSize = CGSizeMake(self.navigationController.navigationBar.frame.size.width, rectNav.size.height+rectStatus.size.height);  //获取Navigation Bar的位置和大小
    title_bg = [self scaleToSize:title_bg size:titleSize];//设置图片的大小与Navigation Bar相同
    [self.navigationController.navigationBar
     setBackgroundImage:title_bg
     forBarMetrics:UIBarMetricsDefault];  //设置背景
/**
 计算理财产品的收益
 @param IBAction <#IBAction description#>
 @return
 */
}
#pragma mark - MainDelegate
//点击中间按钮的代理方法
-(void)tabBarCenterClick:(MainView *)centerbtn{
    ScanViewController *vc=[[ScanViewController alloc]init];
    vc.view.backgroundColor=randomColor();
    CATransition *anim=[CATransition animation];
    anim.type=@"cube";
    [self.view.layer addAnimation:anim forKey:@"animationForKey"];
    
    [self presentViewController:vc animated:YES completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (IBAction)gotoAni:(id)sender {
    AniViewController *anvc=[[AniViewController alloc]init];
    [self.navigationController pushViewController:anvc animated:NO];
    
    
}

- (IBAction)TheEqual:(id)sender {
    CGFloat day=[self.year.text floatValue];
    CGFloat lixi=[self.liXi.text floatValue];
    CGFloat ziJin=[self.zijin.text floatValue]*10000;
      CGFloat dqck=[self.dqck.text floatValue]*10000;
    
    CGFloat num=0;
    for (int i=0; i<day; i++) {
        num=ziJin*(lixi/100);
        if (i==0){ziJin+=num;}else{
            ziJin+=num+dqck;}
        NSLog(@"第%d年利息为: %lf 总额为：%f,定期存款为%f",i+1,num,ziJin,dqck);
    }
    self.result.text=[NSString stringWithFormat:@"%f",ziJin];
}
-(void)injected{
    NSLog(@"我是injection%@",self);
    [self viewDidLoad];

}
@end
