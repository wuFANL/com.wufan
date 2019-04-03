//
//  Nutill.h
//  com.wufan
//
//  Created by otsoft on 2018/9/10.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AppEm;
@interface AppEm : NSObject
-(void)alert1:(NSTimer *)time;
@end

#define IMAGED(name)        [UIImage imageNamed:(name)]

#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 绘制导航栏右边按钮

 @param control 控制器
 @param funName 给按钮添加方法
 @param title   标题
 @param image   按钮图片
 */
void drawTheRightBarBtn(UIViewController *control , SEL funName,NSString *title,UIImage* image);

/**
 绘制back button的左箭头
 @param controller 视图控制器
 @param funName    方法
 */
void drawBackBarBtnItem(UIViewController * controller,SEL funName);

/**
 绘制按钮图片及title
 */
void drawBackBarBtnItemAndImage(UIViewController *controller,SEL funName ,NSString *title, UIImage* image);
//绘制模态视图的导航栏取消按钮
void drawCancelBarBtnItem(UIViewController *controller ,SEL funName);

//draw image by parent view and rect
void drawImageByParentAndRect(UIViewController* controller, CGRect rect ,SEL functionName ,NSString* imgName);
//检查是否是手机号
BOOL checkPhoneNO(NSString* input);
//弹出一个消息框
void alert(NSString* msg);
//延迟弹框
void delayAlert(NSString *msg,UIViewController *vc);

NSString* getString(id obj ,NSString* key);

void dumpRequest(id obj);

//颜色创建图片
UIImage * createImageWithColor(UIColor *color);

void createNavigationButton(UIViewController * viewController,BOOL isLeft,CGRect buttonRect,SEL buttonAction,NSString * buttonTitle ,UIFont *titleFont,UIImage *normalImage,UIImage *selectImage);
NSString* base64ToString(NSString *str);

/**
 移除通知
 @param sel 当前页面的对象
 */
void removeNotification(id sel);

/**
 生成随机颜色
 @return color
 */
UIColor * randomColor(void);
