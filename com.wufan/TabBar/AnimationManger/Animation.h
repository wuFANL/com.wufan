//
//  Animation.h
//  com.wufan
//
//  Created by otsoft on 2018/7/23.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Animation : NSObject<UIViewControllerAnimatedTransitioning>
-(instancetype)initWithTargetEdge:(UIRectEdge)targetEdge;
@property(nonatomic,readonly)UIRectEdge targetEdge;
@end
