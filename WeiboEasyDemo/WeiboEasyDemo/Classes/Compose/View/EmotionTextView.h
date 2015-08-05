//
//  EmotionTextView.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/1.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "PlaceholderTextView.h"

@class Emotion;
@interface EmotionTextView : PlaceholderTextView

- (void)insertEmotion:(Emotion *)emotion;
- (NSString *)fullText;
@end
