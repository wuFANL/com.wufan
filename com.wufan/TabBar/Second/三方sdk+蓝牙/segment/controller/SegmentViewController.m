//
//  SegmentViewController.m
//  com.wufan
//
//  Created by appleadmin on 2019/4/10.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "SegmentViewController.h"
#import "BCHttpRequest.h"
#import "HKXSegmentedView.h"
#import "MJViewController.h"
#import "HomeProdeutModel.h"
#import "ProductViewController.h"
@interface SegmentViewController ()<HKXSegmentedViewDelegate,HKXSegmentedViewDataSource>
@property (nonatomic,strong) NSMutableArray *listarr;


@property (nonatomic, strong) HKXSegmentedView *segmentView;
@property (nonatomic, strong) NSMutableArray *arrayCategory;
@property (nonatomic, strong) UIView *segmentFixContainerView;
@property (nonatomic, strong) UIView *segmentFixView;
@property (nonatomic, strong) NSArray *segmentFixIcon;

@end

@implementation SegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"segmentview"];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initDate];
    // Do any additional setup after loading the view.
}
#pragma mark->获取zzx首页数据
-(void)initDate{
    
    BCHttpRequest *request=[[BCHttpRequest alloc]init];
    [request postWithURLString:@"" parameters:nil success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"result"] isKindOfClass:[NSArray class]]) {
                          self.listarr=[[NSMutableArray alloc]initWithCapacity:0];
                        for (NSDictionary *dic in responseObject[@"result"]) {
                            HomeProdeutModel *model=[[HomeProdeutModel alloc]init];
                            model.cat=dic[@"cat"];
                            model.listArr=dic[@"leaf"];
                            [self.listarr addObject:model];
                            
                        }
            [self setUpContentView];
            [self setUpContentViewConstraints];
                    }
    } failure:^(NSError * _Nonnull error) {
        
    } baseurl:@"http://123.206.176.248/appcat/search.do"];
    
}

- (void)setUpContentViewConstraints {
    __weak typeof(self) weakSelf = self;
    
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(weakSelf.view);
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(60, 0, 0, 0));
    }];
}
- (void)setUpContentView {
    self.segmentView = [[HKXSegmentedView alloc] init];
    self.segmentView.dataSource = self;
    [self.view addSubview:self.segmentView];
    
    UIView *segmentRightView = [[UIView alloc] init];
    [self.view addSubview:segmentRightView];
    
    UIImageView *segmentRightImageView = [[UIImageView alloc] init];
    [segmentRightView addSubview:segmentRightImageView];
    
    UIButton *segmentRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [segmentRightButton addTarget:self action:@selector(segmentRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [segmentRightView addSubview:segmentRightButton];
    
    [segmentRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    [segmentRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(segmentRightView);
    }];
    
    [segmentRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(segmentRightView);
    }];
    
    NSUserDefaults *defaluts = [NSUserDefaults standardUserDefaults];
    NSArray *array = [defaluts valueForKey:@"appAdvPict"];
    if (array.count > 0) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        for (NSDictionary *tempDic in array) {
            NSArray *keyArray = [tempDic allKeys];
            NSString *key = keyArray[0];
            if ([key isEqualToString:@"syflbjt"]) {
                dic = [[NSMutableDictionary alloc] initWithDictionary:tempDic[@"syflbjt"]];
            }
        }
        
        if ([[NSString stringWithFormat:@"%@", dic[@"pictState"]] isEqualToString:@"1"]) {
            segmentRightImageView.image = [UIImage imageWithData:dic[@"pictImage"]];
            //            [segmentRightButton setBackgroundImage:[UIImage imageWithData:dic[@"pictImage"]] forState:UIControlStateNormal];
            [segmentRightButton setImage:[UIImage imageNamed:@"icon_segmentRight"] forState:UIControlStateNormal];
        }else {
            [segmentRightButton setImage:[UIImage imageNamed:@"icon_more_classify2_gary"] forState:UIControlStateNormal];
        }
    }else {
        [segmentRightButton setImage:[UIImage imageNamed:@"icon_more_classify2_gary"] forState:UIControlStateNormal];
    }
    
    
    self.segmentFixContainerView = [[UIView alloc] init];
    self.segmentFixContainerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.segmentFixContainerView.hidden = YES;
    [self.view addSubview:self.segmentFixContainerView];
    
    [self.segmentFixContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30.0f);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    self.segmentFixContainerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.segmentFixContainerView addGestureRecognizer:tap];
}
-(void)setSegmentFixView {
    if (self.segmentFixIcon.count > 0) {
        self.segmentFixContainerView.hidden = NO;
        
        self.segmentFixView = [[UIView alloc] init];
        self.segmentFixView.backgroundColor = [UIColor whiteColor];
        [self.segmentFixContainerView addSubview:self.segmentFixView];
        
        [self.segmentFixView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.segmentFixContainerView);
            make.height.mas_equalTo(320);
        }];
        
        UILabel *labelMore = [[UILabel alloc] init];
        labelMore.text = @"更多频道";
        labelMore.textColor = RGB_HEX(0x333333);
        labelMore.font = kFontWith15;
        labelMore.textAlignment = NSTextAlignmentLeft;
        [self.segmentFixView addSubview:labelMore];
        
        [labelMore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.segmentFixView);
            make.left.equalTo(self.segmentFixView).offset(20);
            make.height.mas_equalTo(60);
        }];
        
        for (int i = 0; i < 11; i ++ ) {
            UIView *viewContainer = [[UIView alloc] init];
            viewContainer.backgroundColor = [UIColor clearColor];
            [self.segmentFixView addSubview:viewContainer];
            
            UIImageView *imageViewIcon = [[UIImageView alloc] init];
            //        imageViewIcon.image = [UIImage imageNamed:self.segmentFixIcon[i]];
            imageViewIcon.image = [self getImageFromImageInfo:self.segmentFixIcon[i]];
            [viewContainer addSubview:imageViewIcon];
            
            UILabel *labelTitle = [[UILabel alloc] init];
            labelTitle.text = self.arrayCategory[i];
            labelTitle.textAlignment = NSTextAlignmentCenter;
            [viewContainer addSubview:labelTitle];
            
            UIButton *buttonClick = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonClick.tag = i;
            [buttonClick addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [viewContainer addSubview:buttonClick];
            
            // 刷新ui
            NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:@"segmentFixSeletedIndex"];
            dispatch_async(dispatch_get_main_queue(), ^{
                labelTitle.font = index == i ? kFontWith15 : kFontWith12;
                labelTitle.textColor = index == i ? RGB_HEX(0xff3b42) : RGB_HEX(0x666666);
            });
            
//            if (index == i) {
//                [self addScaleAnimationOnView:imageViewIcon repeatCount:1];
//            }
            
            CGFloat width = KScree_Width / 4;
            CGFloat height = 80;
            if (i < 4) {
                viewContainer.frame = CGRectMake(i * width, 60, width, height);
                [imageViewIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(viewContainer);
                    make.centerY.equalTo(viewContainer).offset(-10);
                }];
                
                [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(viewContainer);
                    make.left.right.equalTo(viewContainer);
                    make.top.equalTo(imageViewIcon.mas_bottom).offset(10);
                }];
            }
            
            if (i > 3 && i < 8) {
                viewContainer.frame = CGRectMake((i - 4) * width, 60 + height, width, height);
                [imageViewIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(viewContainer);
                    make.centerY.equalTo(viewContainer).offset(-10);
                }];
                
                [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(viewContainer);
                    make.left.right.equalTo(viewContainer);
                    make.top.equalTo(imageViewIcon.mas_bottom).offset(10);
                }];
            }
            
            if (i > 7 && i < 11) {
                viewContainer.frame = CGRectMake((i - 8) * width, 60 + height * 2, width, height);
                [imageViewIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(viewContainer);
                    make.centerY.equalTo(viewContainer).offset(-10);
                }];
                
                [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(viewContainer);
                    make.left.right.equalTo(viewContainer);
                    make.top.equalTo(imageViewIcon.mas_bottom).offset(10);
                }];
            }
            
            [buttonClick mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(viewContainer);
            }];
        }
    }
}

- (UIImage *)getImageFromImageInfo:(id)imageInfo {
    UIImage *image = nil;
    if ([imageInfo isKindOfClass:[NSString class]]) {
        image = [UIImage imageNamed:imageInfo];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        image = [self scaleToSize:[UIImage imageWithData:imageInfo] size:CGSizeMake(25, 25)];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return image;
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    //    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);// 关键代码
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark->segmentDataSource 代理事件
- (NSUInteger)numberOfSegmentsInSegmentedView:(HKXSegmentedView *)segmentedView {
    return self.listarr.count;
}

- (NSString *)segmentedView:(HKXSegmentedView *)segmentedView titleInSegment:(NSUInteger)segmentIndex {
    HomeProdeutModel *model=[[HomeProdeutModel alloc]init];
    model=self.listarr[segmentIndex];
    
    return model.cat;
}

- (UIView *)segmentedView:(HKXSegmentedView *)segmentedView viewForScrollViewInSegment:(NSUInteger)segmentIndex {
    MJViewController *mvc=[[MJViewController alloc]init];
    
    
    
    [self addChildViewController:mvc];
    [mvc didMoveToParentViewController:self];
    return mvc.view;
}



@end
