//
//  EmotionsTool.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/4.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "EmotionsTool.h"
#import "JLResourcePath.h"


#define kEmotionsPath   GetDocumentPathWithFile(@"emotions.archive")

static NSMutableArray *_recentEmotions;

@implementation EmotionsTool

+ (void)initialize
{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:kEmotionsPath];
    if (_recentEmotions ==  nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

/**
 *  保存表情到最近表情
 */
+ (void)saveRecentEmotion:(Emotion *)emotion
{
    [_recentEmotions removeObject:emotion];
    [_recentEmotions insertObject:emotion atIndex:0];
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:kEmotionsPath];

}
/**
 *  获取最近表情
 */
+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}

@end
