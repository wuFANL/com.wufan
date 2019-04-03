//
//  MYUISearchBar.m
//  com.wufan
//
//  Created by appleadmin on 2019/1/4.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "MYUISearchBar.h"
@implementation MYUISearchBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入查询条件";
        // 提前在Xcode上设置图片中间拉伸
//        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.backgroundColor=[UIColor grayColor];
        // 通过init初始化的控件大多都没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"select"];
        // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
        searchIcon.contentMode = UIViewContentModeCenter;
//        searchIcon.size = CGSizeMake(30, 30);
        searchIcon.frame=frame;
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype)searchBar
{
    return [[self alloc] init];
}


@end

