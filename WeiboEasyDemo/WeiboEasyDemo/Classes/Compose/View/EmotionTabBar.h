//
//  EmotionTabBar.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/27.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    EmotionTabBarButtonTypeRecent = 0, // 最近
    EmotionTabBarButtonTypeDefault,    // 默认
    EmotionTabBarButtonTypeEmoji,      // emoji
    EmotionTabBarButtonTypeLxh,        // 浪小花
} EmotionTabBarButtonType;

@class EmotionTabBar;
@protocol EmotionTabBarDelegate <NSObject>
- (void)tabBar:(EmotionTabBar *)tabBar didSelectedButtonType:(EmotionTabBarButtonType)buttonType;
@optional

@end
@interface EmotionTabBar : UIView
@property (nonatomic, weak)  id<EmotionTabBarDelegate> delegate;
@end
