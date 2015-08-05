//
//  BYTabBar.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/8.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BYTabBar;

#warning BYTabBar继承自UITabBar,要实现BYTabBarDelegate得先实现UITabBarDelegate
@protocol BYTabBarDelegate <UITabBarDelegate>
@optional

- (void)tabBarDidClickPlusButton:(BYTabBar *)tabBar;

@end

@interface BYTabBar : UITabBar

@property (nonatomic, assign) id<BYTabBarDelegate> delegate;
//+ (instancetype)tabbar;
@end
