//
//  EmotionPageView.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/31.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "EmotionPageView.h"
#import "Emotion.h"
#import "EmotionButton.h"
#import "EmotionPopView.h"
#import "EmotionsTool.h"

@interface EmotionPageView ()
@property (nonatomic, strong)  EmotionPopView *popview;
@property (nonatomic, weak)  UIButton *deleteBtn;
@end

@implementation EmotionPageView

- (EmotionPopView *)popview
{
    if (!_popview){
         self.popview = [EmotionPopView popView];
    }
    return _popview;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *deleteBtn = [[UIButton alloc] init];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;
        
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
        
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    NSUInteger count = emotions.count;
    for (int i = 0; i < count ; i ++) {
        EmotionButton *btn = [[EmotionButton alloc] init];
        btn.emotion = emotions[i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat inset = 10;
    CGFloat btnW = (self.width - 2 * inset)/kEmotionMaxCols;
    CGFloat btnH = (self.height - inset)/kEmotionMaxRows;
    
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count ; i ++) {
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + i%kEmotionMaxCols * btnW;
        btn.y = inset + i/kEmotionMaxCols * btnH;
    }
    self.deleteBtn.x = self.width - inset - btnW;
    self.deleteBtn.y = self.height - btnH;
    self.deleteBtn.width = btnW;
    self.deleteBtn.height = btnH;
}

- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:recognizer.view];
    EmotionButton *currBtn = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            [self.popview removeFromSuperview];
            if (currBtn) {
                [self selectEmotion:currBtn.emotion];
            }
           
            
            break;
        }
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            [self.popview showFrom:currBtn];
            break;
        default:
            break;
    }
    
}

- (EmotionButton *)emotionButtonWithLocation:(CGPoint)location
{
    for (int i = 0; i < self.emotions.count ; i ++) {
        EmotionButton *btn = self.subviews[i +1];
        if (CGRectContainsPoint(btn.frame, location)) {
            return btn;
        }
    }
    return nil;
}
/**
 *  监听删除按钮点击
 *
 *  @param btn 表情按钮
 */
- (void)deleteBtnClick:(UIButton *)deleteBtn
{
    [kNotificationCenter postNotificationName:kEmotionDeleteNotification object:nil];
}


/**
 *  监听表情按钮点击
 *
 *  @param btn 表情按钮
 */
- (void)btnClick:(EmotionButton *)btn
{
//    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
//    [window addSubview:self.popview];
//    
//    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
//    self.popview.centerX = CGRectGetMidX(btnFrame);
//    self.popview.y = CGRectGetMidY(btnFrame) - self.popview.height;
//    self.popview.emotion = btn.emotion;
    [self.popview showFrom:btn];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popview removeFromSuperview];
    });
    [self selectEmotion:btn.emotion];
}

- (void)selectEmotion:(Emotion *)emotion
{
    [EmotionsTool saveRecentEmotion:emotion];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[kEmotionDidSelectedKey] = emotion;
    [kNotificationCenter postNotificationName:kEmotionDidSelectedNotification object:nil userInfo:userInfo];
}
@end
