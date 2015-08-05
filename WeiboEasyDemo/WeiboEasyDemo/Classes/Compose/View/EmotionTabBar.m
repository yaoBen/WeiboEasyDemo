//
//  EmotionTabBar.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/27.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "EmotionTabBar.h"
#import "EmotionTabBarButton.h"

@interface EmotionTabBar ()
@property (nonatomic, weak)  EmotionTabBarButton *selectedButton;
@end
@implementation EmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addButtonTitle:@"最近" buttonType:EmotionTabBarButtonTypeRecent];
        [self addButtonTitle:@"默认" buttonType:EmotionTabBarButtonTypeDefault];
        [self addButtonTitle:@"Emoji" buttonType:EmotionTabBarButtonTypeEmoji];
        [self addButtonTitle:@"浪小花" buttonType:EmotionTabBarButtonTypeLxh];
    }
    return self;
}

- (void)addButtonTitle:(NSString *)title buttonType:(EmotionTabBarButtonType)btnType
{
    EmotionTabBarButton *btn = [[EmotionTabBarButton alloc] init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = btnType;
    [self addSubview:btn];
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectedImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectedImage = @"compose_emotion_table_left_selected";
    }else if(self.subviews.count == 4){
        image = @"compose_emotion_table_right_normal";
        selectedImage = @"compose_emotion_table_right_selected";
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateDisabled];
}

- (void)setDelegate:(id<EmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    [self btnClick:(EmotionTabBarButton *)[self viewWithTag:EmotionTabBarButtonTypeDefault]];
    
}
- (void)btnClick:(EmotionTabBarButton *)btn
{
    self.selectedButton.enabled = YES;
    btn.enabled = NO;
    self.selectedButton = btn;
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonType:)]) {
        EmotionTabBarButtonType btnType = (EmotionTabBarButtonType)btn.tag;
        [self.delegate tabBar:self didSelectedButtonType:btnType];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = self.width/self.subviews.count;
    CGFloat btnH = self.height;
    for (int i = 0; i < self.subviews.count ; i ++) {
        EmotionTabBarButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.width = btnW;
        btn.y = 0;
        btn.height = btnH;
    }
}

@end
