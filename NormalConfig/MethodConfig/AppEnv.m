//
//  AppEnv.m
//  OtSoftTools
//
//  Created by 李 绿华 on 12-12-27.
//  Copyright (c) 2012年 WilliamLee. All rights reserved.
//

#import "AppEnv.h"
#import "NSString+MD5.h"
static NSString *OSVersion;
static NSString *DeviceName;
static NSString *USID;
static NSString *GUID;
static BOOL isiPhone5Add;
static BOOL isDebug;
static BOOL isLoginOK;
static NSString *UID;
// guozhenwei add start
static int Platform;
static int PlatformIsTest;
// guozhenwei add end
@implementation AppEnv

-(id)init
{
    self = [super init];    
    GUID = @"";
    isLoginOK = NO;
    
    return self;
}

+(BOOL)getisiPhone5Add
{
    return isiPhone5Add;
}

+(void)setisiPhone5Add:(BOOL)isiPhone5
{
    isiPhone5Add = isiPhone5;
}

+(BOOL)getisDebug
{
    return isDebug;
}

+(void)setisDebug:(BOOL)debug
{
    isDebug = debug;
}

//iPhone4    iPhone4s ...
+(NSString *)getSystemDeviceName
{
    return DeviceName;
}

//iOS 6.0.1
+(NSString *)getSystemOSVersion
{
    return OSVersion;
}

+(void)setSystemDeviceName:(NSString *)devName
{
    DeviceName = devName;
}

+(void)setSystemOSVersion:(NSString *)iosVersion
{
    OSVersion = iosVersion;
}

+(NSString *)getSystemUSID
{
    
    
   
    
    return USID;
}

+(void)setSystemUSID:(NSString *)usid
{
    //end for 邬凡 2017 8 9 MD5加密
    usid=[NSString md5To32bit:usid];
    USID = usid;
    
    
    
}

+(NSString *)getSystemGUID
{
    //return @"7fa3dd6e521f11e191980000c9ac6caa";
    return GUID;
}

+(void)setSystemIsLoginOK:(BOOL)loginOK
{
    isLoginOK = loginOK;
}

+(BOOL)getSystemIsLoginOK
{
    if (isLoginOK && GUID) {
        return YES;
    }
    
    return NO;
}

+(void)setSystemGUID:(NSString *)guid
{
    GUID = guid;
}

+(NSString *)getSystemUID
{
    return UID;
}

+(void)setSystemUID:(NSString *)uid
{
    UID = uid;
}
// guozhenwei add start
+(void)setPlatform:(int)platform
{
    Platform = platform;
}
+(int)getPlatform
{
    return Platform;
}
+(void)setPlatformIsTest:(int)platformIsTest
{
    PlatformIsTest = platformIsTest;
}
+(int)getPlatformIsTest
{
    return PlatformIsTest;
}
// guozhenwei add end
@end
