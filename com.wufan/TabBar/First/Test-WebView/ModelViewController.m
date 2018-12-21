//
//  ModelViewController.m
//  com.wufan
//
//  Created by otsoft on 2018/7/20.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "ModelViewController.h"
#import "AppDelegate.h"
@interface ModelViewController ()

@end

@implementation ModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
//     self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
}
-(void)returnBlock2:(setblock2)block2{
    self.block2 = block2;
}


- (IBAction)getwebview:(id)sender {
    [self getDispatch];
//    [self getOpertion];
  
}
-(void)getDispatch{
    
    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time=[date timeIntervalSince1970]/1000;
    
    NSString *timestr=[NSString stringWithFormat:@"1%f",time];
    NSString *str=[NSString stringWithFormat:@"%@%@",self.tfText.text,timestr];
    NSURL *url=[NSURL URLWithString:str];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self clearCacheAndCookie];
        dispatch_group_leave(group);
    });
    dispatch_notify(group, dispatch_get_main_queue(), ^{
        
        

        [self.Test_Webview loadRequest:request];
    });


}
//创建队列 涉及到视图和主线程的会报错
-(void)getOpertion{
    NSBlockOperation *operation1=[NSBlockOperation blockOperationWithBlock:^{
        [self clearCacheAndCookie];
        NSLog(@"清除缓存成功");
    }];
    NSBlockOperation *operation2=[NSBlockOperation blockOperationWithBlock:^{
        NSURL *url=[NSURL URLWithString:self.tfText.text];
        
        
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        [self.Test_Webview loadRequest:request];
        NSLog(@"页面加载成功");
    }];
    [operation2 addDependency:operation1];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    [queue addOperations:@[operation2,operation1] waitUntilFinished:10];
}

//MARK:清除缓存
-(void)clearCacheAndCookie{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage=[NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    
    [[NSURLCache sharedURLCache]removeAllCachedResponses];
    NSURLCache *cache=[NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self changeLeftBtn];
    
    
}
-(void)back:(id)sender{
    
    //AppDelegate传值
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    app.string=@"appDelegate传值";
    app.color=[UIColor orangeColor];
    //代理传值
    if ([self.delegate respondsToSelector:@selector(deletgateTest:color:)]) {
        [self.delegate deletgateTest:@"代理传值" color:[UIColor greenColor]];
    }
    if (self.setblock) {
        self.setblock(@"block传值1",[UIColor blueColor]);
    }
    
    if (self.block2) {
        self.block2(@"第二种block传值", [UIColor lightGrayColor]);
    }
    
    if (self.block3) {
        self.block3(@"第三种传值", [UIColor cyanColor]);
    }
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:3];
    [dic setObject:@"通知中心c" forKey:@"string"];
    [dic setObject:[UIColor orangeColor] forKey:@"color"];
    
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tzcz" object:nil userInfo:dic];
    [self.navigationController popViewControllerAnimated:YES];
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

@end
