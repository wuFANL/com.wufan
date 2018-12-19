//
//  AnimationController.m
//  com.wufan
//
//  Created by otsoft on 2018/7/23.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "AnimationController.h"
@interface AnimationController()
@property(nonatomic,weak)id<UIViewControllerContextTransitioning>transitionContext;
@property(nonatomic,strong,readonly)UIPanGestureRecognizer *gestureRecognizer;
@property(nonatomic,readwrite)CGPoint initoalLocationContainerView;
@property(nonatomic,readwrite)CGPoint initialTranslationInContainerView;

@end
@implementation AnimationController
-(instancetype)initWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    self=[super init];
    if (self) {
        _gestureRecognizer=gestureRecognizer;
        [gestureRecognizer addTarget:self action:@selector(gestureRecognizerDidUpdate:)];
    }
    return self;
}
-(instancetype)init{
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"初始化 手势错误" userInfo:nil];
    
}
-(void)dealloc{
    [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizerDidUpdate:)];
    
}
-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext
    =transitionContext;
    self.initoalLocationContainerView=[self.gestureRecognizer locationInView:transitionContext.containerView];
    self.initialTranslationInContainerView=[self.gestureRecognizer translationInView:transitionContext.containerView];
    [super startInteractiveTransition:transitionContext];
    
    
}
-(CGFloat)percentForGesture:(UIPanGestureRecognizer *)gesture{
    UIView *transitionContainerView=self.transitionContext.containerView;
    CGPoint translation=[gesture translationInView:gesture.view.superview];
    if ((translation.x>0.f&&self.initialTranslationInContainerView.x<0.f)||(translation.x<0.f&&self.initialTranslationInContainerView.x>0.f)) {
        return -1.f;
    }
    return fabs(translation.x)/CGRectGetWidth(transitionContainerView.bounds);
    
}
-(void)gestureRecognizerDidUpdate:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer{
    switch (gestureRecognizer.state) {
               case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            
            if ([self percentForGesture:gestureRecognizer]<0.f) {
                [self cancelInteractiveTransition];
                [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizerDidUpdate:)];
            }else{
                [self updateInteractiveTransition:[self percentForGesture:gestureRecognizer]];
            }
            break;
             case UIGestureRecognizerStateEnded:
            if ([self percentForGesture:gestureRecognizer]>=0.4f) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
                 break;
        default:
             [self cancelInteractiveTransition];
            break;
    }
}

@end
