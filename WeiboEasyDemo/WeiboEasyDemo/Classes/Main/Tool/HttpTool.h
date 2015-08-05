//
//  HttpTool.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/5.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

+ (void)get:(NSString *)url parameters:(id)parameters success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
+ (void)post:(NSString *)url parameters:(id)parameters success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
+ (void)post:(NSString *)url parameters:(id)parameters constructingBodyWithBlock:(NSData *(^)())block success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
@end
