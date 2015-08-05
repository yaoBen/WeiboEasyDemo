//
//  EmotionTabBarButton.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/29.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "EmotionTabBarButton.h"

@implementation EmotionTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
