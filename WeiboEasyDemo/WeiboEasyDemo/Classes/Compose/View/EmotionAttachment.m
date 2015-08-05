//
//  EmotionAttachment.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/3.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "EmotionAttachment.h"
#import "Emotion.h"
@implementation EmotionAttachment

- (void)setEmotion:(Emotion *)emotion
{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}
@end
