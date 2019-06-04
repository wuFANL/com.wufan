//
//  HKXSegmentedView.h
//  YiFengDongli
//
//  Created by weiboqy on 2018/10/25.
//  Copyright © 2018年 史益平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@class HKXSegmentedView;

@protocol HKXSegmentedViewDataSource <NSObject>

@required

// 可选择项数量
- (NSUInteger)numberOfSegmentsInSegmentedView:(HKXSegmentedView *)segmentedView;

// 可选择项标题
- (NSString *)segmentedView:(HKXSegmentedView *)segmentedView titleInSegment:(NSUInteger)segmentIndex;

// 可选择项对应滚动视图
- (UIView *)segmentedView:(HKXSegmentedView *)segmentedView viewForScrollViewInSegment:(NSUInteger)segmentIndex;

@optional
// 视图完成加载
- (void)segmentedViewWithCompletedLoad:(HKXSegmentedView *)segmentedView;

@end

@protocol HKXSegmentedViewDelegate <NSObject>

@optional
// 当前主屏中显示的视图
- (void)segmentedView:(HKXSegmentedView *)segmentedView didSelectViewAtIndex:(NSUInteger)segmentIndex;

@end

@interface HKXSegmentedView : UIView

@property (nonatomic, weak) id<HKXSegmentedViewDataSource> dataSource;
@property (nonatomic, weak) id<HKXSegmentedViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame type:(BOOL)type isScrollEnabled:(BOOL)isScrollEnabled;
- (instancetype)initWithFrameWithSearch:(CGRect)frame type:(BOOL)type;

/**
 *
 * 设置选中的视图
 *
 */
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;

/**
 *
 * 返回索引的视图
 *
 */
- (UIView *)selectedViewWithIndex:(NSUInteger)index;

// 返回选择的位置
- (NSUInteger)selectedSegmentIndex;

@end
