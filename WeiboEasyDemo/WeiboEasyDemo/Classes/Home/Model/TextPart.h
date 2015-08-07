//
//  TextPart.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/6.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//  从微博正文 截取到得片段(表情、@、##、url链接、正文等)

#import <Foundation/Foundation.h>

@interface TextPart : NSObject
/** 片段的文字 */
@property (nonatomic, copy)  NSString *text;
/** 片段的范围 */
@property (nonatomic, assign)  NSRange range;
/** 是否为特殊文字 */
@property (nonatomic, assign, getter=isSpecial)  BOOL special;
/** 是否为表情 */
@property (nonatomic, assign, getter=isEmotion)  BOOL emotion;
@end
