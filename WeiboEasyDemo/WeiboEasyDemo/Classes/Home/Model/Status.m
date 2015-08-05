//
//  Status.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/29.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "Status.h"

@implementation Status


- (NSString *)created_at
{
    NSDateFormatter *dateFm = [[NSDateFormatter alloc] init];
    dateFm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    dateFm.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createdDate = [dateFm dateFromString:_created_at];
    BWLog(@"created date :%@",createdDate);

    NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:unit fromDate:createdDate toDate:[NSDate date] options:0];
    if ([createdDate isThisYear]) {
        if ([createdDate isToday]){
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            }else{
                if (cmps.minute >= 1) {
                    return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
                }else{
                    return @"刚刚";
                }
            }
        }else if ([createdDate isYesterday]){
            dateFm.dateFormat = @"HH:mm";
            return [NSString stringWithFormat:@"昨天%@",[dateFm stringFromDate:createdDate]];
        }else{
            dateFm.dateFormat = @"MM-dd HH:mm";
            return [NSString stringWithFormat:@"%@",[dateFm stringFromDate:createdDate]];
        }
    }else{
        dateFm.dateFormat = @"yyyy-MM-dd HH:mm";
        return [NSString stringWithFormat:@"%@",[dateFm stringFromDate:createdDate]];
    }
}

// <a href="http://app.weibo.com/t/feed/9ksdit" rel="nofollow">iPhone客户端</a>
- (NSString *)source
{
    if (_source.length) {
        NSRange range;
        range.location = [_source rangeOfString:@">"].location + 1;
        range.length = [_source rangeOfString:@"</"].location - range.location;
        return [NSString stringWithFormat:@"来自%@",[_source substringWithRange:range]];
    }else{
        return _source;
    }
    
}
@end
