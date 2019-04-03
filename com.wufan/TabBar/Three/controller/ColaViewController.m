//
//  ColaViewController.m
//  com.wufan
//
//  Created by otsoft on 2018/7/20.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "ColaViewController.h"
#import "SDCyclemodel.h"
//cateGory分类
@interface ColaViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)SDCycleScrollView *bannerView;
@property (nonatomic,strong) NSMutableArray *imageUrlArr;
@property (nonatomic,strong) NSMutableArray *imageModeArr;
@property (nonatomic,strong)  UIView * headview;
@end

@implementation ColaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBanview];
    
    
//     self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view.
    
   
}
-(void)viewWillAppear:(BOOL)animated{
   
    
 
    
     [self loadSdcycleView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createBanview{
    self.headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0,KScree_Width , KScree_Hight/4)];
    [self.view addSubview:self.headview];
    self.headview.backgroundColor=[UIColor whiteColor];
    [self.headview addSubview:self.bannerView];
}
-(SDCycleScrollView *)bannerView{
    if (!_bannerView) {
        _bannerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(20, 5, KScree_Width-40, KScree_Hight/4-10)delegate:self placeholderImage:[UIImage imageNamed:@"启动"]];
   _bannerView.pageControlAliment=SDCycleScrollViewPageContolAlimentCenter;
        _bannerView.backgroundColor=[UIColor whiteColor];
        _bannerView.autoScrollTimeInterval=3;
        CGSize size=CGSizeMake(5, 6);
        _bannerView.pageControlDotSize=size;
        _bannerView.currentPageDotColor=[UIColor redColor];
        _bannerView.pageDotColor=[UIColor blackColor];
        _bannerView.clipsToBounds=YES;
    _bannerView.contentMode=UIViewContentModeScaleAspectFill;
    }
        _bannerView.imageURLStringsGroup=self.imageUrlArr;
    return _bannerView;
}
-(void)loadSdcycleView{
    BCHttpRequest *request=[[BCHttpRequest alloc]init];
    [request postWithURLString:@"/news/api/getRotation" parameters:nil success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"success"] integerValue]) {
            NSArray *arr=responseObject[@"data"];
            self.imageUrlArr=[NSMutableArray arrayWithCapacity:0];
            self.imageModeArr=[NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *dic in arr) {
                SDCyclemodel *model=[[SDCyclemodel alloc]init];
                model.title=dic[@"title"];
                model.imageUrl=dic[@"imageUrl"];
                model.adLink=dic[@"adLink"];
                model.viewCount=dic[@"viewCount"];
                model.remark=dic[@"remark"];
                [self.imageModeArr addObject:model];
                [self.imageUrlArr addObject:[self checkStr:dic[@"imageUrl"]]];
                
                if (self.imageUrlArr.count<=1) {
                    for (int i=0; i<5; i++) {
                        [self.imageUrlArr addObject:self.imageUrlArr[0]];
                    }
                }                self.bannerView.imageURLStringsGroup=self.imageUrlArr;
            }
//            [self createBanview];
        }else{
            alert(responseObject[@"msg"]);
        }
    } failure:^(NSError * _Nonnull error) {
        alert(@"加载失败，请稍后重试");
        NSLog(@"请求失败");
    }baseurl:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSString*)checkStr:(id)sender {
    if ([sender isKindOfClass:[NSNull class]]) {
        return @"";
    }
    else {
        return sender;
    }
}
@end
