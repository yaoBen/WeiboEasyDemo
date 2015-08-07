//
//  Status.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/29.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "Status.h"
#import "RegexKitLite.h"
#import "User.h"
#import "TextPart.h"
#import "EmotionsTool.h"
#import "Emotion.h"
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
/**
 *  普通文字 -----》 属性文字
 *
 *  @param text 普通文字
 *
 *  @return 属性文字
 */
- (NSAttributedString *)attributedStringWith:(NSString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5_-]+";
    // 话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@",emotionPattern,atPattern,topicPattern,urlPattern];
    
    NSMutableArray *parts = [NSMutableArray array];
    /** 截取特殊文字 */
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return ;
        TextPart *part = [[TextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        part.special = YES;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        [parts addObject:part];
    }];
    /** 截取非特殊文字片段 */
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        TextPart *part = [[TextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    
    [parts sortUsingComparator:^NSComparisonResult(TextPart *part1, TextPart *part2) {
        return part1.range.location > part2.range.location ? NSOrderedDescending : NSOrderedAscending;
    }];
    
    BWLog(@"parts:%@",parts);
    UIFont *font = [UIFont systemFontOfSize:15];
    NSAttributedString *subStr = nil;
    for (TextPart *part in parts) {
        if (part.isEmotion) {
            NSString *name = [EmotionsTool emotionWithChs:part.text].png;
            if (name) {
                NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                attach.image = [UIImage imageNamed:name];
                attach.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                subStr = [NSAttributedString attributedStringWithAttachment:attach];
            }else{
                subStr = [[NSAttributedString alloc] initWithString:part.text];
            }
        } else if(part.isSpecial) {
            subStr = [[NSAttributedString alloc] initWithString:part.text attributes:@{NSForegroundColorAttributeName:[UIColor blueColor]}];
        }else{
            subStr = [[NSAttributedString alloc] initWithString:part.text];
        }
        [attributedText appendAttributedString:subStr];
    }
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    return attributedText;

}
- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    self.attributedText = [self attributedStringWith:text];
}
- (void)setRetweeted_status:(Status *)retweeted_status
{
    _retweeted_status = retweeted_status;
    self.retweetedAttributedText = [self attributedStringWith:[NSString stringWithFormat:@"@%@ : %@",_retweeted_status.user.name,_retweeted_status.text]];
}

@end
