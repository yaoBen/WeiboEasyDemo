//
//  NSDate+Extension.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/20.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  判断时间是不是今年
 */
- (BOOL)isThisYear
{
    NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
    dateF.dateFormat = @"yyyy";
    NSString *createdStr = [dateF stringFromDate:self];
    NSDate *createdDate = [dateF dateFromString:createdStr];
    NSString *nowStr = [dateF stringFromDate:[NSDate date]];
    NSDate *nowDate = [dateF dateFromString:nowStr];
    return [createdDate isEqualToDate:nowDate];
}
/**
 *  判断时间是不是今天
 */
- (BOOL)isToday
{
//    NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
//    dateF.dateFormat = @"yyyy MM dd";
//    NSString *createdStr = [dateF stringFromDate:self];
//    NSDate *createdDate = [dateF dateFromString:createdStr];
//    NSString *nowStr = [dateF stringFromDate:[NSDate date]];
//    NSDate *nowDate = [dateF dateFromString:nowStr];
    NSCalendar *calendar = [[NSCalendar alloc] init];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return cmps.year == nowCmps.year;
}

/**
 *  判断时间是不是昨天
 */
- (BOOL)isYesterday
{
    NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
    dateF.dateFormat = @"yyyy MM dd";
    NSString *createdStr = [dateF stringFromDate:self];
    NSDate *createdDate = [dateF dateFromString:createdStr];
    NSString *nowStr = [dateF stringFromDate:[NSDate date]];
    NSDate *nowDate = [dateF dateFromString:nowStr];
    
    NSCalendarUnit unit = NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cps = [calendar components:unit fromDate:createdDate toDate:nowDate options:0];
    return cps.year == 0 && cps.month == 0 & cps.day == 1;
}

@end
