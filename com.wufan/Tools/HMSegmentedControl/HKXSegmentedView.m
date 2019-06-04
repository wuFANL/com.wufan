//
//  HKXSegmentedView.m
//  YiFengDongli
//
//  Created by weiboqy on 2018/10/25.
//  Copyright © 2018年 史益平. All rights reserved.
//

#import "HKXSegmentedView.h"

@interface HKXSegmentedView () <UIScrollViewDelegate> {
    NSInteger _segmentCount; // 可选择项数量
    NSMutableArray *_arraySegmentTitle; // 可选择项标题
    NSMutableArray *_arraySegmentScrollView; // 可选择项对应滚动视图
}

#pragma mark - privated attributes

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic) BOOL bolFirst;
@property (nonatomic) BOOL isSearch;

@property (nonatomic) NSInteger seletedIndex;

#pragma mark - privated methods

- (void)setUpContentViewWithType:(BOOL)type isScrollEnabled:(BOOL)isScrollEnabled;
- (void)setUpContentViewConstraints;
- (void)setUpSegmentsData; // 设置可选择项数据

@end

#pragma mark - view

@implementation HKXSegmentedView

#pragma mark - life cycle

- (void)dealloc {
    if (_arraySegmentTitle) {
        [_arraySegmentTitle removeAllObjects];
        _arraySegmentTitle = nil;
    }
    
    if (_arraySegmentScrollView) {
        [_arraySegmentScrollView removeAllObjects];
        _arraySegmentScrollView = nil;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpContentViewWithType:NO isScrollEnabled:YES];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame type:(BOOL)type isScrollEnabled:(BOOL)isScrollEnabled{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpContentViewWithType:YES isScrollEnabled:isScrollEnabled];
    }
    return self;
}

- (instancetype)initWithFrameWithSearch:(CGRect)frame type:(BOOL)type {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setUpContentViewWithSearchWithType:type];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.bolFirst == NO) {
        self.bolFirst = YES;
        if (self.isSearch) {
            [self setUpContentViewConstraintsWithSearch];
        }else {
            [self setUpContentViewConstraints];
        }
        [self setUpSegmentsData];
        
        if (self.dataSource) {
            if ([self.dataSource respondsToSelector:@selector(segmentedViewWithCompletedLoad:)]) {
                
                __weak typeof(self) weakSelf = self;
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC));
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    
                    [strongSelf.dataSource segmentedViewWithCompletedLoad:strongSelf];
                });
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(segmentedView:didSelectViewAtIndex:)]) {
            [self.delegate segmentedView:self didSelectViewAtIndex:page];
        }
    }
}

#pragma mark - public methods
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated {
    [self.segmentedControl setSelectedSegmentIndex:index animated:animated];
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.bounds) * index, 0)
                             animated:animated];
}

- (UIView *)selectedViewWithIndex:(NSUInteger)index {
    __block UIView *view = nil;
    
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index == idx) {
            view = obj;
        }
    }];
    
    return view;
}

- (NSUInteger)selectedSegmentIndex {
    return self.seletedIndex;
}

#pragma mark - privated methods

- (void)setUpContentViewWithType:(BOOL)type isScrollEnabled:(BOOL)isScrollEnabled{
    self.segmentedControl = [[HMSegmentedControl alloc] init];
    
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
            if (IS_IPHONE_6_PLUS) {
                self.segmentedControl.backgroundColor = [[UIColor colorWithPatternImage:[self scaleToSize:[UIImage imageWithData:dic[@"pictImage"]] size:CGSizeMake(414, 79)]] colorWithAlphaComponent:1];
            }else if (IsiPhoneX) {
                self.segmentedControl.backgroundColor = [[UIColor colorWithPatternImage:[self scaleToSize:[UIImage imageWithData:dic[@"pictImage"]] size:CGSizeMake(335, 70)]] colorWithAlphaComponent:1];
            }else if (IsiPhoneXR || IsiPhoneXSMAX) {
                self.segmentedControl.backgroundColor = [[UIColor colorWithPatternImage:[self scaleToSize:[UIImage imageWithData:dic[@"pictImage"]] size:CGSizeMake(414, 70)]] colorWithAlphaComponent:1];
            }else {
                self.segmentedControl.backgroundColor = [[UIColor colorWithPatternImage:[self scaleToSize:[UIImage imageWithData:dic[@"pictImage"]] size:CGSizeMake(335, 70)]] colorWithAlphaComponent:1];
            }
            
            self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName:RGB_HEX(0xffffff),
                                                          NSFontAttributeName:kFontWith15};
            self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:RGB_HEX(0xfffc00),
                                                                  NSFontAttributeName:kFontBoldWith15};
            self.segmentedControl.selectionIndicatorColor = RGB_HEX(0xfffc00);
        }else {
            self.segmentedControl.backgroundColor = [UIColor whiteColor];
            
            self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName:RGB_HEX(0x333333),
                                                          NSFontAttributeName:kFontWith15};
            self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:RGB_HEX(0xfd5b67),
                                                                  NSFontAttributeName:kFontBoldWith16};
            self.segmentedControl.selectionIndicatorColor = RGB_HEX(0xfd5b67);
        }
    }else {
        self.segmentedControl.backgroundColor = [UIColor whiteColor];
        
        self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName:RGB_HEX(0x333333),
                                                      NSFontAttributeName:kFontWith15};
        self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:RGB_HEX(0xfd5b67),
                                                              NSFontAttributeName:kFontBoldWith16};
        self.segmentedControl.selectionIndicatorColor = RGB_HEX(0xfd5b67);
    }
    
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorHeight = 2.0f;
    self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f);
    self.segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0.0f, 13.0f, 0.0f, 26.0f);
    
    
    if (type) {
        self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
        self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    }
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        weakSelf.seletedIndex = index;
        [weakSelf.scrollView setContentOffset:CGPointMake(CGRectGetWidth(weakSelf.scrollView.bounds) * index, 0)
                                     animated:YES];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.delegate) {
            if ([strongSelf.delegate respondsToSelector:@selector(segmentedView:didSelectViewAtIndex:)]) {
                [strongSelf.delegate segmentedView:strongSelf didSelectViewAtIndex:index];
            }
        }
        
        // 首页选中的标签
        [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"segmentFixSeletedIndex"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
         [[NSNotificationCenter defaultCenter] postNotificationName:@"removeSetSegmentFixView" object:nil];
    }];
    
    [self addSubview:self.segmentedControl];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = isScrollEnabled;
    [self addSubview:self.scrollView];
}

- (void)setUpContentViewWithSearchWithType:(BOOL)type{
    self.isSearch = YES;
    self.segmentedControl = [[HMSegmentedControl alloc] init];
    
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName:RGB_HEX(0x333333),
                                                  NSFontAttributeName:kFontWith14};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:RGB_HEX(0xff3b42),
                                                          NSFontAttributeName:kFontBoldWith14};
    self.segmentedControl.selectionIndicatorColor = RGB_HEX(0xff3b42);
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorHeight = 2.0f;
    if (type) {
        self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
        self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    }else {
        self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
        self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    }
    self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0.0f, 20.0f, 0.0f, 20.0f);
    self.segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0.0f, 13.0f, 0.0f, 26.0f);
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        weakSelf.seletedIndex = index;
        [weakSelf.scrollView setContentOffset:CGPointMake(CGRectGetWidth(weakSelf.scrollView.bounds) * index, 0)
                                     animated:YES];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.delegate) {
            if ([strongSelf.delegate respondsToSelector:@selector(segmentedView:didSelectViewAtIndex:)]) {
                [strongSelf.delegate segmentedView:strongSelf didSelectViewAtIndex:index];
            }
        }
    }];
    
    [self addSubview:self.segmentedControl];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = RGB_HEX(0xffffff);
    [self addSubview:self.scrollView];
}

- (void)setUpContentViewConstraints {
    __weak typeof(self) weakSelf = self;
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(weakSelf.bounds) - 40, 30.0f));
        make.top.equalTo(weakSelf);
//        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(30.0f, 0.0f, 0.0f, 0.0f));
    }];
}

- (void)setUpContentViewConstraintsWithSearch {
    __weak typeof(self) weakSelf = self;
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(weakSelf.bounds), 30.0f));
        make.top.equalTo(weakSelf);
        //        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(30.0f, 0.0f, 0.0f, 0.0f));
    }];
}

- (void)setUpSegmentsData {
    if (self.dataSource) {
        
        if (_arraySegmentTitle) {
            [_arraySegmentTitle removeAllObjects];
        } else {
            _arraySegmentTitle = [[NSMutableArray alloc] init];
        }
        
        if (_arraySegmentScrollView) {
            [_arraySegmentScrollView removeAllObjects];
        } else {
            _arraySegmentScrollView = [[NSMutableArray alloc] init];
        }
        
        _segmentCount = [self.dataSource numberOfSegmentsInSegmentedView:self];
        
        if (_segmentCount > 0) {
            // TODO 待优化 是否需要将数据暂存在_arraySegmentTitle，_arraySegmentScrollView中
            
            for (NSInteger i=0; i<_segmentCount; i++) {
                NSString *title = [self.dataSource segmentedView:self titleInSegment:i];
                if (title == nil) {
                    [_arraySegmentTitle addObject:@""];
                } else {
                    [_arraySegmentTitle addObject:title];
                }
            }
            
            for (NSInteger i=0; i<_segmentCount; i++) {
                UIView *view = [self.dataSource segmentedView:self viewForScrollViewInSegment:i];
                if (view == nil) {
                    [_arraySegmentScrollView addObject:[UIView new]];
                } else {
                    [_arraySegmentScrollView addObject:view];
                }
            }
            
            self.segmentedControl.sectionTitles = _arraySegmentTitle;
            
            UIView *viewTemp = nil;
            __weak typeof(self) weakSelf = self;
            for (NSInteger i=0; i<_arraySegmentScrollView.count; i++) {
                UIView *view = _arraySegmentScrollView[i];
                [self.scrollView addSubview:view];
                
                if (i == 0) {//First
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.size.equalTo(weakSelf.scrollView);
                        make.top.equalTo(weakSelf.scrollView);
                        make.left.equalTo(weakSelf.scrollView);
                    }];
                } else if (i == _arraySegmentScrollView.count-1) {//End
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.size.equalTo(weakSelf.scrollView);
                        make.top.equalTo(weakSelf.scrollView);
                        make.left.equalTo(viewTemp.mas_right);
                        make.right.equalTo(weakSelf.scrollView);
                    }];
                } else {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.size.equalTo(weakSelf.scrollView);
                        make.top.equalTo(weakSelf.scrollView);
                        make.left.equalTo(viewTemp.mas_right);
                    }];
                }
                
                viewTemp = view;
            }
            viewTemp = nil;
            
            //            if (self.dataSource) {
            //                if ([self.dataSource respondsToSelector:@selector(segmentedViewWithCompletedLoad:)]) {
            //                    [self.dataSource segmentedViewWithCompletedLoad:self];
            //                }
            //            }
        }
    }
    
}

// 改变图片尺寸，不变像素
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


@end
