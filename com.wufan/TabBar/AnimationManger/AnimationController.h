//
//  AnimationController.h
//  com.wufan
//
//  Created by otsoft on 2018/7/23.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@interface AnimationController : UIPercentDrivenInteractiveTransition
-(instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;

@end
