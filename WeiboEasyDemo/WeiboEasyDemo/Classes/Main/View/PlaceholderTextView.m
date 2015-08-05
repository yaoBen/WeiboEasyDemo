//
//  PlaceholderTextView.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/23.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "PlaceholderTextView.h"

@implementation PlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
- (void)textDidChange
{
    // 重绘 (重新调用drawRect:)
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    if (self.hasText) return;
    // 文字的属性
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = self.font;
    attr[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    CGRect placeholderRect = CGRectMake(5, 8, self.width - 10, self.height - 16);
    // 画文字
    [self.placeholder drawInRect:placeholderRect withAttributes:attr];
}

@end
