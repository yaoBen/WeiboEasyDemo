//
//  BYTabBar.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/8.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "BYTabBar.h"

@interface BYTabBar()
@property (weak, nonatomic) UIButton *plusBtn;
@end
@implementation BYTabBar
@dynamic delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //   添加+号按钮
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateNormal];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}
/**
 *  加号按钮点击
 */
- (void)plusClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}
//+ (instancetype)tabbar
//{
//    return [[self alloc] init];
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //  设置加号按钮的位置
    self.plusBtn.centerX = self.width * .5;
    self.plusBtn.centerY = self.height * 0.5;
    //  设置其他tabbarButton的位置和尺寸
    CGFloat tabbarButtonW = self.width / 5;
    int index = 0;
    for (UIView *tabbarButton in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([tabbarButton isKindOfClass:class]) {
            //  设置宽度
            tabbarButton.width = tabbarButtonW;
            //  设置x
            tabbarButton.x = index * tabbarButtonW;
            //  增加索引
            index++;
            if (index == 2) {
                index ++;
            }
        }
    }
}

@end
