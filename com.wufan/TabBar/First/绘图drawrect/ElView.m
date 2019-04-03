//
//  ElView.m
//  com.wufan
//
//  Created by appleadmin on 2019/3/28.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "ElView.h"

@implementation ElView
#define K_H    100.0
#define K_PDD  10.0
//绘图方法
-(void)drawRect:(CGRect )rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //背景颜色设置
    [[UIColor whiteColor] set];
    CGContextFillRect(context, rect);
    
    //实线椭圆
    CGRect rectRing = CGRectMake(K_PDD, K_PDD, (rect.size.width - K_PDD * 2), K_H);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddEllipseInRect(context, rectRing);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextFillPath(context);
//    CGContextStrokePath(con);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
