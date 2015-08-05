//
//  EmotionKeyboard.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/27.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "EmotionKeyboard.h"
#import "EmotionListView.h"
#import "EmotionTabBar.h"
#import "Emotion.h"
#import "MJExtension.h"
#import "EmotionsTool.h"

@interface EmotionKeyboard ()<EmotionTabBarDelegate>
//@property (nonatomic, weak)  EmotionListView *showingListView;

@property (nonatomic, strong)  EmotionListView *recentListView;
@property (nonatomic, strong)  EmotionListView *defaultListView;
@property (nonatomic, strong)  EmotionListView *emojiListView;
@property (nonatomic, strong)  EmotionListView *lxhListView;
@property (nonatomic, weak)  EmotionTabBar *eTabbar;
@property (nonatomic, weak)  UIView *contentview;

@end
@implementation EmotionKeyboard

- (EmotionListView *)recentListView
{
    if (!_recentListView){
        self.recentListView = [[EmotionListView alloc] init];
        self.recentListView.emotions = [EmotionsTool recentEmotions];
    }
    return _recentListView;
}
- (EmotionListView *)defaultListView
{
    if (!_defaultListView){
        self.defaultListView = [[EmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info" ofType:@"plist"];
        self.defaultListView.emotions =  [Emotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        
    }
    return _defaultListView;
}
- (EmotionListView *)emojiListView
{
    if (!_emojiListView){
        self.emojiListView = [[EmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info" ofType:@"plist"];
        self.emojiListView.emotions =  [Emotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}
- (EmotionListView *)lxhListView
{
    if (!_lxhListView){
        self.lxhListView = [[EmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info" ofType:@"plist"];
        self.lxhListView.emotions =  [Emotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        EmotionListView *eListView = [[EmotionListView alloc] init];
//        eListView.backgroundColor = BWRandomColor;
//        [self addSubview:eListView];
//        self.eListView = eListView;
        UIView *contentview = [[UIView alloc] init];
        [self addSubview:contentview];
        self.contentview = contentview;

        
        EmotionTabBar *eTabbar = [[EmotionTabBar alloc] init];
        eTabbar.delegate = self;
        [self addSubview:eTabbar];
        self.eTabbar = eTabbar;
        
        [kNotificationCenter addObserver:self selector:@selector(emotionButtonDidClick) name:kEmotionDidSelectedNotification object:nil];
    }
    return self;
}
- (void)emotionButtonDidClick
{
    self.recentListView.emotions = [EmotionsTool recentEmotions];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 1，设置tabbar
    self.eTabbar.x = 0;
    self.eTabbar.height = 37;
    self.eTabbar.y = self.height - self.eTabbar.height;
    self.eTabbar.width = self.width;
    
    // 2,设置contentview
    self.contentview.x = self.contentview.y = 0;
    self.contentview.width = self.width;
    self.contentview.height = self.eTabbar.y;

//    self.showingListView.x = self.showingListView.y = 0;
//    self.showingListView.width = self.width;
//    self.showingListView.height = self.eTabbar.y;

    // 3,设置contentview的子控件
    EmotionListView *listview = self.contentview.subviews.firstObject;
    listview.frame = self.contentview.bounds;
}

#pragma mark - EmotionTabBarDelegate
- (void)tabBar:(EmotionTabBar *)tabBar didSelectedButtonType:(EmotionTabBarButtonType)buttonType
{
    // 移除原来的子控件
    [self.contentview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
//    [self.showingListView removeFromSuperview];
    switch (buttonType) {
        case EmotionTabBarButtonTypeRecent:
//            [self addSubview:self.recentListView];
            
            [self.contentview addSubview:self.recentListView];
            BWLog(@"---------->最近");
            break;
        case EmotionTabBarButtonTypeDefault:
            [self.contentview addSubview:self.defaultListView];
            
//            [self addSubview:self.defaultListView];
            BWLog(@"---------->默认");
            break;
        case EmotionTabBarButtonTypeEmoji:
            BWLog(@"---------->emoji");
//            [self addSubview:self.emojiListView];
            [self.contentview addSubview:self.emojiListView];
            break;
        case EmotionTabBarButtonTypeLxh:
            BWLog(@"---------->浪小花");
//            [self addSubview:self.lxhListView];
            [self.contentview addSubview:self.lxhListView];
            break;
    }
//    self.showingListView = self.subviews.lastObject;
    // 告诉系统重新排布子控件的位置(会重新调用layoutSubviews)
    [self setNeedsLayout];
}

@end
