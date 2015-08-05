//
//  AccountTool.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/25.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "AccountTool.h"
#import "JLResourcePath.h"


#define kAccountPath   GetDocumentPathWithFile(@"account.archive")
@implementation AccountTool

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(Account *)account
{
    //  自定义对象的存储必须用  nskeyedArchiver  没有writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountPath];
}

+ (Account *)account
{
    //  加载模型
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountPath];
    
    /**  验证账号是否过期 **/
    //  过期秒数
    long long expires_in = [account.expires_in longLongValue];
    //  获得过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    //  获取当前时间
    NSDate *now = [NSDate date];
    
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {
        account = nil;
    }
    
    return account;
}

@end
