//
//  PBCollectionHeadView.h
//  com.wufan
//
//  Created by appleadmin on 2019/1/18.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBCollectionHeadView : UICollectionReusableView
+(NSString *)headerViewIdentifier;
+(instancetype)headerWithCollectionView:(UICollectionView *)collectionview forIndexPath:(NSIndexPath *)indexpath;
@property(strong ,nonatomic)UILabel *textLabel;
@end

NS_ASSUME_NONNULL_END
