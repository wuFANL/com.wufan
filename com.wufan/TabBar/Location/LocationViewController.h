//
//  LocationViewController.h
//  com.wufan
//
//  Created by otsoft on 2018/10/10.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface LocationViewController : baseViewController
@property (weak, nonatomic) IBOutlet UITextField *LocatTf;

@property (weak, nonatomic) IBOutlet UILabel *dweiLabel;
@property(nonatomic,strong)NSString *addr;

@property(nonatomic,strong)NSString *dataaddr;
@property (weak, nonatomic) IBOutlet UIView *Locationview;

@end

NS_ASSUME_NONNULL_END
