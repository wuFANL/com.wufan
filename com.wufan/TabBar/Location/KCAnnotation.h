//
//  KCAnnotation.h
//  com.wufan
//
//  Created by otsoft on 2018/10/12.
//  Copyright © 2018年 wufan. All rights reserved.
//




#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface KCAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
#pragma mark 自定义一个图片属性在创建大头针视图时使用
@property (nonatomic,strong) UIImage *image;
@end
NS_ASSUME_NONNULL_END
