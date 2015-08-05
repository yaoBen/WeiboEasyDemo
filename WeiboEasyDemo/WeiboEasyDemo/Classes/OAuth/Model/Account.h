//
//  Account.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/24.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>

/**  string  用于调用access_token,接口获取授权后的access_token。 */
@property (nonatomic, copy)  NSString *access_token;
/**  string  用于调用expires_in,接口获取授权后的expires_in。 */
@property (nonatomic, copy)  NSNumber *expires_in;
/**  string  用于调用uid,接口获取授权后的uid。 */
@property (nonatomic, copy)  NSString *uid;
/**  string 用户的昵称 */
@property (nonatomic, copy)  NSString *name;
/**  access_token创建的时间 */
@property (nonatomic, strong)  NSDate *created_time;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
