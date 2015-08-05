//
//  NSDate+Extension.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/20.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 *  判断时间是不是今年
 */
- (BOOL)isThisYear;
/**
 *  判断时间是不是今天
 */
- (BOOL)isToday;

/**
 *  判断时间是不是昨天
 */
- (BOOL)isYesterday;
@end
