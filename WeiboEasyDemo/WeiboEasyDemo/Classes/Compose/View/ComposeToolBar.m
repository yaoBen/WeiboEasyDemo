//
//  ComposeToolBar.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/25.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "ComposeToolBar.h"

@interface ComposeToolBar ()

@property (nonatomic, weak)  UIButton *emoticonBtn;
@end
@implementation ComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置背景色
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        // 添加按钮
        [self setupBtnWithImage:@"compose_camerabutton_background" highedImage:@"compose_camerabutton_background_highlighted" btnType:ComposeToolBarButtonTypeCamera];
        [self setupBtnWithImage:@"compose_toolbar_picture" highedImage:@"compose_toolbar_picture_highlighted" btnType:ComposeToolBarButtonTypePicture];
        [self setupBtnWithImage:@"compose_mentionbutton_background" highedImage:@"compose_mentionbutton_background_highlighted" btnType:ComposeToolBarButtonTypeMention];
        [self setupBtnWithImage:@"compose_trendbutton_background" highedImage:@"compose_trendbutton_background_highlighted" btnType:ComposeToolBarButtonTypeTrend];
        [self setupBtnWithImage:@"compose_emoticonbutton_background" highedImage:@"compose_emoticonbutton_background_highlighted" btnType:ComposeToolBarButtonTypeEmoticon];
        
    }
    return self;
}

- (void)setupBtnWithImage:(NSString *)image highedImage:(NSString *)highImage btnType:(ComposeToolBarButtonType)type
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.tag = type;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    if (type == ComposeToolBarButtonTypeEmoticon) {
        self.emoticonBtn = btn;
    }
}

- (void)setShowEmoticonKeyboard:(BOOL)showEmoticonKeyboard
{
    _showEmoticonKeyboard = showEmoticonKeyboard;
    if (showEmoticonKeyboard) {
        [self.emoticonBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emoticonBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }else{
        [self.emoticonBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emoticonBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}


- (void)buttonClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didSelectedButton:)]) {
        ComposeToolBarButtonType type = (ComposeToolBarButtonType)btn.tag;
        [self.delegate composeToolBar:self didSelectedButton:type];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW = self.width/self.subviews.count;
    CGFloat btnH = self.height;
    for (int i = 0; i < self.subviews.count ; i ++) {
        UIButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.width = btnW;
        btn.y = 0;
        btn.height = btnH;
    }
}

@end
