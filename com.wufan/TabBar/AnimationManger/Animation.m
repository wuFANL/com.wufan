//
//  Animation.m
//  com.wufan
//
//  Created by otsoft on 2018/7/23.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "Animation.h"

@implementation Animation
-(instancetype)initWithTargetEdge:(UIRectEdge)targetEdge{
    self=[self init];
    if (self) {
        _targetEdge=targetEdge;
        
    }
    return  self;
}
//平推

- (void)animateTransition: (id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromViewController=[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
    UIView *toView=[transitionContext viewForKey:UITransitionContextToViewKey];
    
      UIView *fromView=[transitionContext viewForKey:UITransitionContextFromViewKey];
    CGRect fromFrame=[transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame=[transitionContext finalFrameForViewController:toViewController];
    CGVector offset;
    if (self.targetEdge==UIRectEdgeLeft) {
        offset=CGVectorMake(-1.f, 0.f);
        NSLog(@"右滑");
    }else if (self.targetEdge==UIRectEdgeRight){
        
         offset=CGVectorMake(1.f, 0.f);
        NSLog(@"左滑");
    }else{
        NSAssert(NO, @"既不是左滑又不是右滑");
        NSLog(@"既不是左滑又不是右滑");
        
    }
    fromView.frame=fromFrame;
    toView.frame=CGRectOffset(toFrame, toFrame.size.width*offset.dx*-1, toFrame.size.height*offset.dy*-1);
    [transitionContext.containerView addSubview:toView];
    NSTimeInterval transitionDuration=[self transitionDuration:transitionContext];
    [UIView animateWithDuration:transitionDuration animations:^{
        fromView.frame=CGRectOffset(fromFrame, fromFrame.size.width*offset.dx, fromFrame.size.height*offset.dy);
        toView.frame=toFrame;
    }completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        
    }];
    
    
    
}
/*
//消失
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    UIView * fromView = fromVC.view;
    UIView * toView = toVC.view;
    NSLog(@"startAnimation! fromView = %@", fromView);
    NSLog(@"startAnimation! toView = %@", toView);
    for(UIView * view in containerView.subviews){
        NSLog(@"startAnimation! list container subviews: %@", view);
    }
    
    [containerView addSubview:toView];
    
    [[transitionContext containerView] bringSubviewToFront:fromView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromView.alpha = 0.0;
        fromView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformMakeScale(1, 1);
        [transitionContext completeTransition:YES];
        for(UIView * view in containerView.subviews){
            NSLog(@"endAnimation! list container subviews: %@", view);
        }
    }];
}
 */

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.2;
}

@end
