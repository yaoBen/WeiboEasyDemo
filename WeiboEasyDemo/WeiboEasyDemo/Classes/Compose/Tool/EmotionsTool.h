//
//  EmotionsTool.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/4.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Emotion;
@interface EmotionsTool : NSObject

+ (void)saveRecentEmotion:(Emotion *)emotion;
+ (NSArray *)recentEmotions;
@end
