//
//  NSString+Extension.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/20.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFount:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    return  [self boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}
- (CGSize)sizeWithFount:(UIFont *)font
{
    return [self sizeWithFount:font maxW:MAXFLOAT];
}
@end
