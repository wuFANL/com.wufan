//
//  Centerview.h
//  com.wufan
//
//  Created by appleadmin on 2019/1/17.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBCollectionHeadView.h"
#import "PBCollectionFooterView.h"
#import "PbCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface Centerview : UIView
-(instancetype)initWithTitle:(NSArray *)arr view:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
