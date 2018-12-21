//
//  Nutill.m
//  com.wufan
//
//  Created by otsoft on 2018/9/10.
//  Copyright © 2018年 wufan. All rights reserved.
//

#import "Nutill.h"
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

    


