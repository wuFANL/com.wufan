//
//  PBViewController.h
//  com.wufan
//
//  Created by appleadmin on 2019/1/17.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Centerview.h"
#import "PBCollectionHeadView.h"
#import "PbCollectionViewCell.h"
#import "PBCollectionFooterView.h"
NS_ASSUME_NONNULL_BEGIN

@interface PBViewController : UIViewController
@property NSArray *infoArr;
@property UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
