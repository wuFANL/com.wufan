//
//  PBCollectionFooterView.h
//  com.wufan
//
//  Created by appleadmin on 2019/1/18.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PBCollectionFooterView : UICollectionReusableView
@property(strong,nonatomic)UILabel *textLabel;
+(NSString *)footerViewIdentifier;
+(instancetype)footerViewWithCollectionView:(UICollectionView *)collectionview forIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
