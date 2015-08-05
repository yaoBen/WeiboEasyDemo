//
//  EmotionAttachment.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/3.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Emotion;
@interface EmotionAttachment : NSTextAttachment

@property (nonatomic, strong)  Emotion *emotion;
@end
