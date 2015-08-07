//
//  EmotionsTool.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/4.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "EmotionsTool.h"
#import "JLResourcePath.h"
#import "MJExtension.h"
#import "Emotion.h"


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

static NSArray *_defaultEmotions, *_emojiEmotions, *_lxhEmotions;
/**
 *  加载默认表情
 */
+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info" ofType:@"plist"];
        _defaultEmotions =  [Emotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultEmotions;
}
/**
 *  加载emoji表情
 */
+ (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info" ofType:@"plist"];
        _emojiEmotions =  [Emotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiEmotions;
}
/**
 *  加载lxh表情
 */
+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info" ofType:@"plist"];
        _lxhEmotions =  [Emotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhEmotions;
}
/**
 *  获取最近表情
 */
+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}
/**
 *  通过chs获取表情模型
 *
 *  @param chs 表情的chs
 *
 *  @return 表情模型
 */
+ (Emotion *)emotionWithChs:(NSString *)chs
{
    NSArray *defaults = [self defaultEmotions];
    for (Emotion *emotion in defaults) {
        if ([emotion.chs isEqualToString:chs]) {
            return emotion;
        }
    }
    NSArray *lxhs = [self lxhEmotions];
    for (Emotion *emotion in lxhs) {
        if ([emotion.chs isEqualToString:chs]) {
            return emotion;
        }
    }
    return nil;
}

@end
