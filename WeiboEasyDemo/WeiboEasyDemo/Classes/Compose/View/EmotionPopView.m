//
//  EmotionPopView.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/31.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "EmotionPopView.h"
#import "EmotionButton.h"

@interface EmotionPopView ()
@property (weak, nonatomic) IBOutlet EmotionButton *emotionBtn;

@end
@implementation EmotionPopView


+ (instancetype)popView
{
    return [[NSBundle mainBundle] loadNibNamed:@"EmotionPopView" owner:nil options:nil].lastObject;
}

- (void)setEmotion:(Emotion *)emotion
{
    _emotion = emotion;
    self.emotionBtn.emotion = emotion;
}

- (void)showFrom:(EmotionButton *)btn
{
    if (btn == nil) return;
    self.emotionBtn.emotion = btn.emotion;
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    [window addSubview:self];
    
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    self.centerX = CGRectGetMidX(btnFrame);
    self.y = CGRectGetMidY(btnFrame) - self.height;
    

}
@end
