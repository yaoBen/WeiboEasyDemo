//
//  EmotionTextView.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/1.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "EmotionTextView.h"
#import "Emotion.h"
#import "EmotionAttachment.h"

@implementation EmotionTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

/**
 *  将有属性的文字转换为NSString
 *
 *  @return
 */
- (NSString *)fullText
{
    NSMutableString *fullStr = [NSMutableString string];
    NSAttributedString *attr = self.attributedText;
    [attr enumerateAttributesInRange:NSMakeRange(0, attr.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        BWLog(@"attrs:%@\nrange:%@",attrs,NSStringFromRange(range));
        EmotionAttachment *attch = attrs[@"NSAttachment"];
        if (attch) {
            [fullStr appendString:attch.emotion.chs];
        }else{
            NSAttributedString *str = [attr attributedSubstringFromRange:range];
            [fullStr appendString:str.string];
        }
    }];
    return fullStr;
}
/**
 *  添加表情到textview
 *
 *  @param emotion
 */
- (void)insertEmotion:(Emotion *)emotion
{
    if (emotion.code) {// emoji表情
        [self insertText:emotion.code.emoji];
    }else{// 非emoji表情
        EmotionAttachment *attch = [[EmotionAttachment alloc] init];
        attch.emotion = emotion;
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);
        NSAttributedString *attr = [NSAttributedString attributedStringWithAttachment:attch];

        [self insertAttributedText:attr settingBlock:^(NSMutableAttributedString *attributedText) {
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
        
    }
    
}

@end
