//
//  EmotionButton.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/31.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "EmotionButton.h"
#import "Emotion.h"
@implementation EmotionButton

/**
 *  当控件不是从xib，storyboard中创建出来的会调用这个方法
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 *  当控件是从xib，storyboard中创建出来的会调用这个方法
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
/**
 *  initWithCoder执行完之后调用
 */
- (void)awakeFromNib
{
    
}
/**
 *  初始化操作
 */
- (void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.adjustsImageWhenHighlighted = NO;
}

- (void)setEmotion:(Emotion *)emotion
{
    _emotion = emotion;
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }else if (emotion.code){
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        
    }
}
@end
