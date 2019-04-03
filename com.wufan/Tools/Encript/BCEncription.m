//
//  BCEncription.m
//  Realty
//
//  Created by 巩奕杰 on 2017/6/20.
//  Copyright © 2017年 巩奕杰. All rights reserved.
//

#import "BCEncription.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"
#import "leaseback.h"



// 前端与后台商量KEY
//zifu.des.key = .w(qD09;
//zifu.md5.key = O,lI1hP6m;CJW_,=TKY0.

//测试
//#define gkey @".w(qD09;"
//static NSString *const kMd5Key = @"O,lI1hP6m;CJW_,=TKY0.";

//生产
//zifu.des.key = *sXw7Y)B
//zifu.md5.key = Yf5]I=7=@EWq"#T#D#9c;

//#define gkey @"*sXw7Y)B"
//static NSString *const kMd5Key = @"Yf5]I=7=@EWq\"#T#D#9c;";

#define kSecrectKeyLength 24

@implementation BCEncription

+ (NSString *)desEncrypt:(NSString *)plainText withKey:(NSString *)key
{

    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    unsigned long dataLength = strlen(textBytes);

    unsigned char buffer[1024*50];
    memset(buffer, 0, sizeof(char));
    const void *iv = (const void *)[key UTF8String];
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
    
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024*50,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }
    else {
        NSLog(@"加密失败！");
    }
    return ciphertext;
}
+ (NSString *)desEncrypt:(NSString *)plainText withKey:(NSString *)key type:(int)type {
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    unsigned long dataLength = strlen(textBytes);
    
    unsigned char buffer[1024*700];
    memset(buffer, 0, sizeof(char));
    const void *iv = (const void *)[key UTF8String];
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024*700,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }
    else {
        NSLog(@"加密失败！");
    }
    return ciphertext;
}

+ (NSString *)desDecrypt:(NSString *)encryptText withKey:(NSString *)key
{
    NSString *plaintext = nil;
    NSData *cipherdata = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    unsigned char buffer[4096];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                                kCCOptionPKCS7Padding,
                                                [key UTF8String], kCCKeySizeDES,
                                                key.UTF8String,
                                                [cipherdata bytes], [cipherdata length],
                                                buffer, 4096,
                                                &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    
    return plaintext;
}

+ (NSString *)sha1:(NSString *)string
{
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (NSString *)encryptParameters:(id)parameters UrlStr:(NSString *)UrlStr
{
    if (!parameters) {
        
        return nil;
    }
    
    NSError *error = nil;
   
    
    NSData *jsonData =  [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];

    if (error) {
        NSLog(@"to json error: %@", error);
        return nil;
    }
    
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

//    jsonStr = [jsonStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    jsonStr = [self encodeString:jsonStr];
    NSString *desResult;
    if ([UrlStr isEqualToString:@"/customer/api/saveMailList"]) {
        desResult = [BCEncription desEncrypt:jsonStr withKey:gkey type:1];
    }
    else {
        //对称加密
//        desResult = [BCEncription desEncrypt:jsonStr withKey:gkey];
    }
  
    id md5Result = [BCEncription MD5:[NSString stringWithFormat:@"%@%@", desResult, kMd5Key]];
    NSString *result = [NSString stringWithFormat:@"%@-%@", desResult, md5Result];
//    return result;
    return jsonStr;
}

+ (id)MD5:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    unsigned int x=(int)strlen(cStr) ;
    CC_MD5( cStr, x, digest );
    // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return  output;
}
+(NSString*)encodeString:(NSString*)unencodedString{
    // CharactersToBeEscaped = @":/?&;=;aliyunzixun@xxx.com#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&;=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

@end
