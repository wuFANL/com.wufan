//
//  NSString+MD5.h
//  NJSteel
//
//  Created by wf on 2017/8/8.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSString (MD5)
+ (NSString *)md5To32bit:(NSString *)str;
@end
