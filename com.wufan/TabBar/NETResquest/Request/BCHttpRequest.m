//
//  BCHttpRequest.m
//  com.wufan
//
//  Created by appleadmin on 2019/2/19.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "BCHttpRequest.h"
#import "BCEncription.h"
#define BCRequestErrorDomain @"com.360.request.error"
@interface BCHttpRequest()
@property (nonatomic,strong)AFHTTPSessionManager *manager;
@end

@implementation BCHttpRequest
+(BCHttpRequest *)httpRequest{
    static BCHttpRequest *request=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request=[[BCHttpRequest alloc]init];
    });
    return request;
}
-(instancetype)init{
    if (self=[super init]) {

        self.manager=[AFHTTPSessionManager manager];   self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];
self.manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
        AFHTTPRequestSerializer *requestSerialize=[AFHTTPRequestSerializer serializer];
        [requestSerialize setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
            return parameters;
        }];
 self.manager.requestSerializer=requestSerialize;

//        self.manager = [AFHTTPSessionManager manager];
//        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
//        self.manager.operationQueue.maxConcurrentOperationCount = 5;
//        self.manager.requestSerializer.timeoutInterval=30.f;
//        self.manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
//        [self.manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    }
    return self;
}

-(void)getWithURLString:(NSString *)URLString
             parameters:(nullable id)parameters
                success:(void (^)(id responseObject))success
                failure:(void(^)(NSError *error))failure{
    [self.manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(success){
            failure(error);
        }
    }];
}
-(void)postWithURLString:(NSString *)URLString parameters:(nullable id)paramters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure baseurl:(NSString *)base_url{
    if (base_url==nil) {
        base_url=BASE_URL;
    }
    
    
    NSString *urlStr=[base_url stringByAppendingString:URLString];

    //获取版本号
//    NSString *version=[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
//    [dicNew setObject:version forKey:@"version"];
//    [dicNew setObject:@"1" forKey:@"appType"];
//    NSString *parameter=[BCEncription encryptParameters:dicNew UrlStr:URLString];
//
    
    [self.manager POST:urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"~~~~进度条%@",uploadProgress);
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (!responseObject) {
            NSError *error=[[NSError alloc]initWithDomain:BCRequestErrorDomain code:0 userInfo:@{@"msg":@"返回的数据为空"}];
            if (failure) {
                failure(error);
            }
            return ;
        }
        NSError *error=nil;
        NSDictionary *data=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            if (failure) {
                failure(error);
            }
              return;
        }
        BOOL isSuccess=[data[@"success"]boolValue];
        if (isSuccess) {
            if (success) {
                success(data);
            }
        }else{
            success(data);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        failure(error);
    }];
    
}
-(void)requestWithURLString:(NSString *)URLString parameters:(id)paramters type:(BCHttpRequestType)type success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    switch (type) {
        case BCHttpRequestTypeGet:{
            [self.manager GET:URLString parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
            
        }
            break;
        case BCHttpRequestTypePost:
        {
            [self.manager POST:URLString parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
            NSLog(@"post请求");
        }
            break;
    }
    
}
-(void)uploadWithURLString:(NSString *)URLString parameters:(id)paramters uploadParam:(BCUploadParam *)uploadParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    [self.manager POST:URLString parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
}
@end
