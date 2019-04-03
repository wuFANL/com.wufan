//
//  Nutill.m
//  com.wufan
//
//  Created by otsoft on 2018/9/10.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "Nutill.h"
#import "UIButton+time.h"

@implementation AppEm

-(void)alert1:(NSTimer *)timer{
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@""
                          message:[[timer userInfo]objectForKey:@"msg"]
                          delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"确定",nil];
    
    [alert show];
}

@end


static const CGRect NAV_BAR_BTN_FRAME = {0, 0, 50, 30};
static const CGFloat TEXT_GAP = 20.0;

NSString* base64ToString(NSString *str){
    
    NSLog(@"调用了base64ToString方法");
    return @"123";
}
//MARK:移除通知中心的方法--在dealloc或者页面移除的时候调用
//添加通知就要移除通知
void removeNotification(id sel){
    [[NSNotificationCenter defaultCenter]removeObserver:sel];
}
    // 导航栏右边按钮方法
UIColor * randomColor(){
    CGFloat r=arc4random_uniform(256);
    CGFloat g=arc4random_uniform(256);
    CGFloat b=arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}
void drawTheRightBarBtn(UIViewController *control , SEL funName,NSString *title,UIImage* image){
    
    
    UIButton * rightItemBtn = [[UIButton alloc] initWithFrame:NAV_BAR_BTN_FRAME];
    [rightItemBtn addTarget:control action:funName forControlEvents:UIControlEventTouchUpInside];
    [rightItemBtn.titleLabel setFont:HEL_14];
    [rightItemBtn setTitle:title forState:UIControlStateNormal];
    [rightItemBtn sizeToFit];
    [rightItemBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    UIBarButtonItem * rightEditBtn = [[UIBarButtonItem alloc] initWithCustomView:rightItemBtn];
    rightEditBtn.style = UIBarButtonItemStyleBordered;
    control.navigationItem.rightBarButtonItem = rightEditBtn;
    
    if (image != nil) {
        [rightItemBtn setBackgroundImage:image forState:UIControlStateNormal];
        rightItemBtn.frame = CGRectMake(0, 0, 12, 12);
    }
    
    
}

/**
 绘制back button的左箭头
 @param controller 视图控制器
 @param funName    方法
 */
void drawBackBarBtnItem(UIViewController * controller,SEL funName){
    UIButton * backBtn = [[UIButton alloc] initWithFrame:NAV_BAR_BTN_FRAME];
    
    backBtn.titleLabel.font = HEL_12;
    backBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // [backBtn setImage:IMG_COMMON_BACK_DEFAULT forState:UIControlStateNormal];
    // [backBtn setImage:IMG_COMMON_BACK_FOUCS forState:UIControlStateHighlighted];
    
//    backBtn.mm_acceptEventInterval = 1.5;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"ic_backImg"] forState:UIControlStateNormal];
    CGSize size = [backBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:HEL_12}];
    CGRect frame = backBtn.frame;
    frame.size.width = size.width + TEXT_GAP;
    [backBtn sizeToFit];
    [backBtn addTarget:controller action:funName forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    controller.navigationItem.leftBarButtonItem = backBtnItem;
    
    //ios7 左滑返回
    if ([controller navigationController].viewControllers.count == 1) {
        [[controller navigationController].interactivePopGestureRecognizer setEnabled:NO];
    } else {
        [[controller navigationController].interactivePopGestureRecognizer setEnabled:YES];
    }
    [controller navigationController].interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)controller;
    
    [backBtn setBackgroundImage:IMAGED(@"ic_backImg") forState:UIControlStateNormal];
    [backBtn setBackgroundImage:IMAGED(@"ic_backImg") forState:UIControlStateHighlighted];
    [backBtn setBackgroundImage:IMAGED(@"ic_backImg") forState:UIControlStateSelected];
}

/**
 绘制按钮图片及title
 */
void drawBackBarBtnItemAndImage(UIViewController *controller,SEL funName ,NSString *title, UIImage* image){
    UIButton * backBtn = [[UIButton alloc] initWithFrame:NAV_BAR_BTN_FRAME];
    backBtn.titleLabel.font = HEL_12;
    backBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    backBtn.titleLabel.textColor = [UIColor blackColor];
    [backBtn setBackgroundImage:[image stretchableImageWithLeftCapWidth:25 topCapHeight:20] forState:UIControlStateNormal];
    [backBtn setTitle:title forState:UIControlStateNormal];
    
    CGSize size = [backBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:HEL_12}];
    CGRect frame = backBtn.frame;
    frame.size.width = size.width + 10;
    backBtn.frame = frame;
    [backBtn addTarget:controller action:funName forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    controller.navigationItem.leftBarButtonItem = backBtnItem;
}
//绘制模态视图的导航栏取消按钮
void drawCancelBarBtnItem(UIViewController *controller ,SEL funName){
    UIButton * backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 30)];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    backBtn.titleLabel.font = HEL_16;
    backBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    backBtn.titleLabel.textColor = [UIColor whiteColor];
    CGSize size = [backBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:HEL_12}];
    CGRect frame = backBtn.frame;
    frame.size.width = size.width + TEXT_GAP;
    backBtn.frame = frame;
    [backBtn addTarget:controller action:funName forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    controller.navigationItem.leftBarButtonItem = backBtnItem;
}

//draw image by parent view and rect
void drawImageByParentAndRect(UIViewController* controller, CGRect rect ,SEL functionName ,NSString* imgName){
    
    UIImage *img = [UIImage imageNamed:imgName];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:rect];
    imgView.image = img;
    [controller.view addSubview:imgView];
}
//检查是否是手机号
BOOL checkPhoneNO(NSString* input){
    NSRange range = [input rangeOfString:@"^\\d{11}$" options:NSRegularExpressionSearch];
    
    return range.location != NSNotFound;
}
//弹出一个消息框
void alert(NSString* msg){
    
}
//延迟弹框
void delayAlert(NSString *msg,UIViewController *vc)
{
    NSDictionary *param=[[NSDictionary alloc]initWithObjectsAndKeys:msg,@"msg", nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:vc selector:@selector(alert1:) userInfo:param repeats:NO];
}


NSString* getString(id obj ,NSString* key){
    if ([obj isKindOfClass:[NSNull class]] || [obj[key] isKindOfClass:[NSNull class]]) {
        return @"";
    }
    else if([obj[key] isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%d",[obj[key] intValue]];
    }
    return obj[key];
}



void dumpRequest(id obj){
    
}

//颜色创建图片
UIImage * createImageWithColor(UIColor *color){
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
void createNavigationButton(UIViewController * viewController,BOOL isLeft,CGRect buttonRect,SEL buttonAction,NSString * buttonTitle ,UIFont *titleFont,UIImage *normalImage,UIImage *selectImage){
    
    UIButton *navigationButton = [[UIButton alloc] initWithFrame:buttonRect];
    if (buttonTitle && ![buttonTitle isEqualToString:@""]) {
        [navigationButton setTitle:buttonTitle forState:UIControlStateNormal];
        [navigationButton.titleLabel setFont:titleFont];
    }
    if (normalImage) {
        [navigationButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    }
    if (selectImage) {
        [navigationButton setBackgroundImage:selectImage forState:UIControlStateHighlighted];
        [navigationButton setBackgroundImage:selectImage forState:UIControlStateSelected];
    }
    [navigationButton addTarget:viewController action:buttonAction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:navigationButton];
    btnItem.style = UIBarButtonItemStylePlain;
    if (isLeft) {
        viewController.navigationItem.leftBarButtonItem = btnItem;
    }else{
        viewController.navigationItem.rightBarButtonItem = btnItem;
    }
}


