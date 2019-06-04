//
//  leaseback.h
//  Leaseback
//
//  Created by zifu on 2018/5/29.
//  Copyright © 2018年 葛佳佳. All rights reserved.
//

#ifndef leaseback_h
#define leaseback_h
//设备屏幕frame
#define kMainScreenFrameRect                          [[UIScreen mainScreen] bounds]
//状态栏高度
#define kMainScreenStatusBarFrameRect                 [[UIApplication sharedApplication] statusBarFrame]
#define kMainScreenHeight                             kMainScreenFrameRect.size.height
#define kMainScreenWidth                              kMainScreenFrameRect.size.width

//F4B144
#define KMainNaviColor      @"FFAF1A"

//有盾商户Key
#define KUDKey              @"a9889bff-ddd6-4a6a-a3ce-e26e0d2688e5"
//众鼎小草莓的微信
#define WX_AppSecret @"92f0b88d1d9037d0928b7c4e9a20016d"
#define WX_OPEN_ID @"wx01920e1cec6462cf"



/*****************************************/

//生产
#define KCompanyId          @"6"
#define KProtocalUrl        @"http://47.110.143.165:7011/protocol"
#define BASE_URL            @"http://47.110.143.165:7011"
#define gkey @"b8uVPOkH"
#define kMd5Key @"ZSF1a5AQ6ypJZiXIyTUOu5"
#define theApiKey @"dda5b36714b64363945d9aa7799078d5"
/*****************************************/

//服务器地址 测试环境
//#define BASE_URL            @"http://47.99.210.86:7061"
//#define KCompanyId          @"8"
//#define KProtocalUrl        @"http://47.99.210.86:7061/protocol"
//#define gkey                @".w(qD09;"
//#define kMd5Key             @"O,lI1hP6m;CJW_,=TKY0."
//#define theApiKey @"df3583431ed7497d994189b1d274390b"
/*****************************************/


#define MAXFLOAT    0x1.fffffep+127f

#define HEL_8               [UIFont fontWithName:@"Helvetica" size:8]
#define HEL_10              [UIFont fontWithName:@"Helvetica" size:10]
#define HEL_11              [UIFont fontWithName:@"Helvetica" size:11]
#define HEL_12              [UIFont fontWithName:@"Helvetica" size:12]
#define HEL_13              [UIFont fontWithName:@"Helvetica" size:13]
#define HEL_14              [UIFont fontWithName:@"Helvetica" size:14]
#define HEL_15              [UIFont fontWithName:@"Helvetica" size:15]
#define HEL_16              [UIFont fontWithName:@"Helvetica" size:16]
#define HEL_17              [UIFont fontWithName:@"Helvetica" size:17]
#define HEL_18              [UIFont fontWithName:@"Helvetica" size:18]
#define HEL_19              [UIFont fontWithName:@"Helvetica" size:19]
#define HEL_20              [UIFont fontWithName:@"Helvetica" size:20]
#define HEL_22              [UIFont fontWithName:@"Helvetica" size:22]
#define HEL_24              [UIFont fontWithName:@"Helvetica" size:24]

#define RGBA(r,g,b,a)       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define W_Ratio(w)          kMainScreenWidth/375*w

#define H_Ratio(w)          kMainScreenHeight/667*w

#define IMAGED(name)        [UIImage imageNamed:(name)]

//减去状态栏和导航栏的高度
#define kScreenHeightNoStatusAndNoNaviBarHeight       (kMainScreenFrameRect.size.height - kMainScreenStatusBarFrameRect.size.height-44.0f)

//减去状态栏和底部菜单栏高度
#define kScreenHeightNoStatusAndNoTabBarHeight       (kMainScreenFrameRect.size.height - kMainScreenStatusBarFrameRect.size.height-49.0f)

//减去状态栏和底部菜单栏以及导航栏高度
#define kScreenHeightNoStatusAndNoTabBarNoNavBarHeight       (kMainScreenFrameRect.size.height - kMainScreenStatusBarFrameRect.size.height-49.0f - 44.0f)

//iphone X 首页除去导航栏和底部菜单栏高度
#define KScreenHeightWithXAndNoTabBarNoNav (kMainScreenHeight - 64 - 48-34-24)
#define KScreenHeightWithXAndNoNav (kMainScreenHeight - 64 - 34-24)
//iphone除去导航栏 底部菜单栏高度
#define KScreenHeightWithNoBarNoNav ( kMainScreenHeight == 812.0 ? KScreenHeightWithXAndNoTabBarNoNav : (kMainScreenHeight - 64- 48))
#define KScreenHeightWithNoNav ( kMainScreenHeight == 812.0 ? KScreenHeightWithXAndNoNav : (kMainScreenHeight - 64))

#define CHECK_BOX_IMG_PREFIX @"check_box"

#endif /* leaseback_h aaaaaaaa */
