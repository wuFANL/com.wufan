//
//  SecurityUtil.h
//  Smile
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import "SecurityUtil.h"
#import "GTMBase64.h"
#import "NSData+AES.h"
#import <sys/utsname.h>
#define Iv          @"number1Mochouhua" //偏移量,可自行修改
#define KEY         @"mochouhuaNumber1" //key，可自行修改

@implementation SecurityUtil

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString * )input { 
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    data = [GTMBase64 encodeData:data]; 
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
    
}

+ (NSString*)decodeBase64String:(NSString * )input { 
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
    data = [GTMBase64 decodeData:data]; 
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
} 

+ (NSString*)encodeBase64Data:(NSData *)data {
	data = [GTMBase64 encodeData:data]; 
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data {
	data = [GTMBase64 decodeData:data]; 
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

#pragma mark - AES加密
//将string转成带密码的data
+(NSString*)encryptAESData:(NSString*)string
{
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES128EncryptWithKey:KEY gIv:Iv];
    //返回进行base64进行转码的加密字符串
    return [self encodeBase64Data:encryptedData];
}

#pragma mark - AES解密
//将带密码的data转成string
+(NSString*)decryptAESData:(NSString *)string
{
    //base64解密
    NSData *decodeBase64Data=[GTMBase64 decodeString:string];
    //使用密码对data进行解密
    NSData *decryData = [decodeBase64Data AES128DecryptWithKey:KEY gIv:Iv];
    //将解了密码的nsdata转化为nsstring
    NSString *str = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return str;
}

///字典转JSON
+ (NSString*)dictionaryToJson:(NSMutableDictionary *)dic {
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

///JSON转字段
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
    
}

+ (NSString*)iphoneType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];

    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";

    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";

    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";

    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";

    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";

    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";

    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";

    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";

    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";

    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";

    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";

    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";

    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";

    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";

    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";

    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";

    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";

    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";

    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";

    if([platform isEqualToString:@"iPhone9,3"])  return@"iPhone 7";

    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";

    if([platform isEqualToString:@"iPhone9,4"])  return@"iPhone 7 Plus";

    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";

    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";

    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";

    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";

    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";

    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";

    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";

    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";

    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";

    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";

    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";

    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";

    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";

    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";

    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";

    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";

    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";

    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";

    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";

    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";

    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";

    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";

    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";

    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";

    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";

    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";

    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";

    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";

    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";

    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";

    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";

    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";

    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";

    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";

    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";

    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";

    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";

    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";

    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";

    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";

    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";

    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";

    if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";

    if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";

    return platform;

}

@end
