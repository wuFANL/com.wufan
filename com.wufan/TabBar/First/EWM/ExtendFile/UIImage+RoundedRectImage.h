//
//  UIImage+RoundedRectImage.h
//  com.wufan
//
//  Created by appleadmin on 2019/1/10.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (RoundedRectImage)
+(UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius;
@end

NS_ASSUME_NONNULL_END
