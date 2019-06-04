//
//  BCHttpRequest.h
//  com.wufan
//
//  Created by appleadmin on 2019/2/19.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN
@class BCUploadParam;
typedef NS_ENUM(NSUInteger,BCHttpRequestType) {
    BCHttpRequestTypeGet=0,//get请求
    BCHttpRequestTypePost//post请求
};
@interface BCUploadParam : NSObject

/**
 图片的二进制数据
 */
@property (nonatomic,strong)NSData *data;

/**
 服务器的参数名称
 */
@property (nonatomic,copy)  NSString *name;

/**
 上传到服务器，服务器保存的名称
 */
@property (nonatomic,copy)  NSString *fileName;

/**
 文件mime类型 （image/png,image/jpg）
 */
@property (nonatomic,copy)  NSString *mimeType;
@end



@interface BCHttpRequest : NSObject
+(BCHttpRequest *)httpRequest;

/**
 get请求

 @param URLString  请求的地址
 @param parameters 请求的参数
 @param success    请求成功的回调
 @param failure    请求失败的回调
 */
-(void)getWithURLString:(NSString *)URLString
             parameters:(nullable id)parameters
             success:(void (^)(id responseObject))success
             failure:(void(^)(NSError *error))failure;

/**
 post请求

 @param URLString 请求地址
 @param paramters 请求参数
 @param success   成功返回的回调
 @param failure   失败返回的回调
 */
-(void)postWithURLString:(NSString *)URLString parameters:(nullable id)paramters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure baseurl:(NSString *)base_url;

/**
 发送网络请求

 @param URLString 请求的网址地址
 @param paramters 请求的参数
 @param type      请求的类型
 @param success   成功的回调参数
 @param failure   失败的回调参数
 */
-(void)requestWithURLString:(NSString *)URLString parameters:(id)paramters type:(BCHttpRequestType)type success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 上传图片

 @param URLString   上传图片的地址
 @param paramters   上传图片的参数
 @param uploadParam 上传图片的信息
 @param success     上传图片成功的回调
 @param failure     上传图片失败的回调
 */
-(void)uploadWithURLString:(NSString *)URLString parameters:(id)paramters uploadParam:(BCUploadParam *)uploadParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
