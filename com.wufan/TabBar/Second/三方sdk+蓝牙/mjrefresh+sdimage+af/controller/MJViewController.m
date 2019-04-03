//
//  MJViewController.m
//  com.wufan
//
//  Created by appleadmin on 2019/3/29.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "MJViewController.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.m"
#import "Mjmodel.h"
#import "BCHttpRequest.h"
#import "SVProgressHUD.h"
#import "mjCell.h"

@interface MJViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,strong)NSMutableArray *imageUrlList;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,assign)int p;




@end

@implementation MJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    [SVProgressHUD setBackgroundColor:[UIColor orangeColor]];
    [SVProgressHUD dismissWithDelay:2];
    [self addMjrefresh];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:@"mj刷新，sdimage，af"];
    [self reloadDate];
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 66, kMainScreenWidth, kMainScreenHeight-64) style:UITableViewStylePlain];
        _tableview.dataSource=self;
        _tableview.delegate=self;
        _tableview.backgroundColor=[UIColor whiteColor];
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
       
//        _tableview.rowHeight=15;
    }
    return _tableview;
}
-(void)addMjrefresh{
    MJRefreshNormalHeader *head=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self reloadDate];
        [self.tableview.mj_header endRefreshing];
    }];
    [head setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [head setTitle:@"松开刷新" forState:MJRefreshStatePulling];
     [head setTitle:@"正在刷新中" forState:MJRefreshStateRefreshing];
//    MJRefreshStateIdle
     [head setTitle:@"刷新完成" forState:MJRefreshStateIdle];
    [head setLastUpdatedTimeText:^NSString *(NSDate *lastUpdatedTime) {
//        lastUpdatedTime=[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
      
        [formatter setDateFormat:@"YYYY-MM-dd HH-mm-ss"];
        NSString *currentTimeString = [formatter stringFromDate:lastUpdatedTime];
        return currentTimeString;
    }];
//      [head setTitle:@"普通闲置状态" forState:MJRefreshStateIdle];
    self.tableview.mj_header=head;
    
    MJRefreshBackNormalFooter *footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self downloadDate];
        [self.tableview.mj_footer endRefreshing];
    }];
   [footer setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在刷新中" forState:MJRefreshStateWillRefresh];
     [footer setTitle:@"即将刷新的状态" forState:MJRefreshStateRefreshing];
    self.tableview.mj_footer=footer;
    
}
//http://box.dwstatic.com/apiAlbum.php?OSType=iOS8.2&action=l&albumsTag=beautifulWoman&v=77&versionName=2.1.10&p=4
// 当前请求：http://box.dwstatic.com/apiAlbum.php?OSType=iOS8.2&action=l&albumsTag=beautifulWoman&v=77&versionName=2.1.10&p=4
//http://box.dwstatic.com/apiAlbum.php?OSType=iOS8.2&action=l&albumsTag=beautifulWoman&v=77&versionName=2.1.10&p=4

-(void)reloadDate{
//    [NSThread sleepForTimeInterval:3];
    BCHttpRequest *request=[[BCHttpRequest alloc]init];
    self.p=1;
    [ request postWithURLString:@"" parameters:@"" success:^(id  _Nonnull responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
        
        self.imageUrlList=[NSMutableArray array];
        NSArray *data=dic[@"data"];
        if (data.count!=0) {
            [SVProgressHUD showSuccessWithStatus:@"请求成功"];
            for (int i=0; i<data.count; i++) {
                Mjmodel *mode=[[Mjmodel alloc]init];
                mode.coverUrl=data[i][@"coverUrl"];
                mode.title=data[i][@"title"];
                mode.manager_id=data[i][@"manager_id"];
                mode.coverHeight=data[i][@"coverHeight"];
                
                [self.imageUrlList addObject:mode];
                
            }
            [self.tableview reloadData];
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
        }
        
         NSLog(@"%@",data[0][@"coverUrl"]);
        NSLog(@"请求成功");
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"请求失败");
    } baseurl:@"http://box.dwstatic.com/apiAlbum.php?OSType=iOS8.2&action=l&albumsTag=beautifulWoman&v=77&versionName=2.1.10&p=1"];
    
    
    
//    if (!_arr) {
//        _arr=[NSMutableArray array];
//
//    }else{
//        [_arr removeAllObjects];
//    }
//    for (int i=0; i<10; i++) {
//        NSString *str=[NSString stringWithFormat:@"序号是%d",i+1];
//        [_arr addObject:str];
//    }
   
}
-(void)downloadDate{
    
    NSString *request=@"http://box.dwstatic.com/apiAlbum.php?OSType=iOS8.2&action=l&albumsTag=beautifulWoman&v=77&versionName=2.1.10";
    self.p++;
    NSString *url=[NSString stringWithFormat:@"%@&p=%d",request,self.p];
    
    BCHttpRequest *requests=[[BCHttpRequest alloc]init];
    [ requests postWithURLString:@"" parameters:@"" success:^(id  _Nonnull responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
        
//        self.imageUrlList=[NSMutableArray array];
        NSArray *data=dic[@"data"];
        if (data.count!=0) {
            [SVProgressHUD showSuccessWithStatus:@"请求成功"];
            for (int i=0; i<data.count; i++) {
                Mjmodel *mode=[[Mjmodel alloc]init];
                mode.coverUrl=data[i][@"coverUrl"];
                mode.title=data[i][@"title"];
                mode.manager_id=data[i][@"manager_id"];
                mode.coverHeight=data[i][@"coverHeight"];
                
                [self.imageUrlList addObject:mode];
                
            }
            [self.tableview reloadData];
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
        }
        
        NSLog(@"%@",data[0][@"coverUrl"]);
        NSLog(@"请求成功");
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"请求失败");
    } baseurl:url];
    
    
//    [NSThread sleepForTimeInterval:3];
//    for (int i=0; i<10; i++) {
//        NSString *str=[NSString stringWithFormat:@"序号是%lu",_arr.count+1];
//        [_arr addObject:str];
//    }
  
}

#pragma mark  -> tableview datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    int a=[self.imageUrlList[indexPath.row][@"coverHeight"] intValue];
    Mjmodel *mode=[[Mjmodel alloc]init];
    mode=self.imageUrlList[indexPath.row];
    
    CGFloat a= [mode.coverHeight floatValue]+30;
  
    return a;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.imageUrlList.count;
}
#pragma mark  -> tableview delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString * ID=@"mjCell";
    mjCell *cell=[self.tableview dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[mjCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
//    cell.textLabel.text=self.imageUrlList[indexPath.row];

    Mjmodel *mode=[[Mjmodel alloc]init];
    mode=self.imageUrlList[indexPath.row];
    cell.title.text=mode.title;
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:mode.coverUrl]];
    NSLog(@"~~~~~~~~~~~>%@,%ld,翻页是%d",mode.title,self.imageUrlList.count,self.p);
//    [self.tableview deselectRowAtIndexPath:indexPath animated:NO];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}



@end
