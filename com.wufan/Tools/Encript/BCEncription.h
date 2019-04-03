//
//  BCEncription.h
//  Realty
//
//  Created by 巩奕杰 on 2017/6/20.
//  Copyright © 2017年 巩奕杰. All rights reserved.
//
//----MD5、DES、sha1数字签名加密---------
#import <Foundation/Foundation.h>

@interface BCEncription : NSObject


/**
 DES 加密

 @param plainText 加密字符串
 @param key 加密所用的key
 @return 返回加密结果
 */
+ (NSString *)desEncrypt:(NSString *)plainText withKey:(NSString *)key;

+ (NSString *)desEncrypt:(NSString *)plainText withKey:(NSString *)key type:(int)type;
/**
 DES解密

 @param encryptText 解密字符串
 @param key 加密时用的key
 @return 返回解密完成的结果
 */
+ (NSString *)desDecrypt:(NSString *)encryptText withKey:(NSString *)key;


/**
 sha1算法

 @param string 需要运算的字符串
 @return 运算结果
 */
+ (NSString *)sha1:(NSString *)string;


/**
 对网络请求的参数进行加密处理，仅仅针对该项目

 @param parameters 拼接好的参数（需要能够转换成json）
 @return 加密完的结果，可以传给服务端解析
 */
+ (NSString *)encryptParameters:(id)parameters UrlStr:(NSString *)UrlStr;


/**
 对字符串MD5加密操作

 @param string 加密对象
 @return 加密结果
 */
+ (id)MD5:(NSString *)string;

@end
