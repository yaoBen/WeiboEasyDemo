//
//  HttpTool.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/5.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

@implementation HttpTool

+ (void)get:(NSString *)url parameters:(id)parameters success:(void(^)(id json))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc] init];
    
    [mgr GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)post:(NSString *)url parameters:(id)parameters success:(void(^)(id json))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc] init];
    
    [mgr POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)post:(NSString *)url parameters:(id)parameters constructingBodyWithBlock:(NSData *(^)())block success:(void(^)(id json))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc] init];
    
    [mgr POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (block) {
            [formData appendPartWithFileData:block() name:@"pic" fileName:@"text.jpg" mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
