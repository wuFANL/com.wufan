//
//  PbCollectionViewCell.h
//  com.wufan
//
//  Created by appleadmin on 2019/1/18.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PbCollectionViewCell : UICollectionViewCell
@property(strong,nonatomic)UILabel *textLabel;
+(NSString *)cellIdentifier;
+(instancetype)cellWithCollection:(UICollectionView *)collectionview forIndexPath:(NSIndexPath *)indexPath;
-(void)addImageInContentView1;
-(void)addImageInContentView2;
-(void)addImageInContentView3;

@end

NS_ASSUME_NONNULL_END
