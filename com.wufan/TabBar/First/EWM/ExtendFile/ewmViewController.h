//
//  ewmViewController.h
//  com.wufan
//
//  Created by appleadmin on 2019/1/11.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ewmViewController : UIViewController
//@property (weak, nonatomic) IBOutlet UIImageView *imgVQRCode;
@property (strong, nonatomic) UIImageView *imgVQRCode;
@property(copy,nonatomic)NSMutableDictionary *info;
@end

NS_ASSUME_NONNULL_END
