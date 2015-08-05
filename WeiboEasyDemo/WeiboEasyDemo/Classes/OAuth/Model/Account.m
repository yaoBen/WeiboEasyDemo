//
//  Account.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/24.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "Account.h"

@implementation Account

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    Account *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    //  获取access_token的时间
    account.created_time = [NSDate date];
    return account;
}

/**
 *  当一个对象要归档进沙盒的时候调用,
 *  在这个方法里面说明对象的那些属性要存储进沙盒
 *
 *  @param encoder encoder 编码
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.created_time forKey:@"created_time"];
    [encoder encodeObject:self.name forKey:@"name"];
}
/**
 *  当从沙盒中解档一个对象时候调用
 *  在这个方法里面说明那些属性是可以取出来的
 *  @param decoder
 *
 *  @return return value description
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.created_time = [decoder decodeObjectForKey:@"created_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end

