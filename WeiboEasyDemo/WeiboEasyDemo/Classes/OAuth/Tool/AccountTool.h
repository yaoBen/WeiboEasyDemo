//
//  AccountTool.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/25.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountTool : NSObject
+ (void)saveAccount:(Account *)account;
+ (Account *)account;
@end
