//
//  EmotionButton.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/31.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Emotion;
@interface EmotionButton : UIButton

@property (nonatomic, strong)  Emotion *emotion;
@end
