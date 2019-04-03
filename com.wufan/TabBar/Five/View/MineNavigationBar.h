//
//  MineNavigationBar.h
//  com.wufan
//
//  Created by appleadmin on 2019/2/24.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineNavigationBar : UIView{
    UIButton *LeftButton;
    UIButton *RightButton;
    UILabel  *titleLabel;
}
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *leftImage;
@property(nonatomic,strong)NSString *rightImage;
@property(nonatomic,strong)UIColor *titleColor;
@end

NS_ASSUME_NONNULL_END
