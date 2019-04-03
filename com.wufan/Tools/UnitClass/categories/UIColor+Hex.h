//
//  UIColor+Hex.h
//  MoChouHua
//
//  Created by 葛佳佳 on 2017/5/15.
//  Copyright © 2017年 葛佳佳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+(UIColor *)colorWithHexString:(NSString *)color;

+(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
