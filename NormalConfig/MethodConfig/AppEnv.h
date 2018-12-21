//
//  AppEnv.h
//  OtSoftTools
//
//  Created by 李 绿华 on 12-12-27.
//  Copyright (c) 2012年 WilliamLee. All rights reserved.
//
//开局设置一次 全局都会获取到

#import <Foundation/Foundation.h>

@interface AppEnv : NSObject

-(id)init;

+(BOOL)getisiPhone5Add;
+(void)setisiPhone5Add:(BOOL)isiPhone5;

+(BOOL)getisDebug;
+(void)setisDebug:(BOOL)debug;

+(NSString *)getSystemDeviceName;
+(NSString *)getSystemOSVersion;
+(NSString *)getSystemUSID;
+(NSString *)getSystemGUID;
+(BOOL)getSystemIsLoginOK;

+(void)setSystemDeviceName:(NSString *)devName;
+(void)setSystemOSVersion:(NSString *)iosVersion;
+(void)setSystemUSID:(NSString *)usid;
+(void)setSystemGUID:(NSString *)guid;
+(void)setSystemIsLoginOK:(BOOL)loginOK;
+(NSString *)getSystemUID;
+(void)setSystemUID:(NSString *)uid;
// guozhenwei add start
+(void)setPlatform:(int)platform;
+(int)getPlatform;
+(void)setPlatformIsTest:(int)platformIsTest;
+(int)getPlatformIsTest;
// guozhenwei add end
@end
