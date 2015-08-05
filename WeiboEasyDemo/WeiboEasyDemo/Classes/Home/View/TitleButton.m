//
//  TitleButton.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/27.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "TitleButton.h"

#define kMargin 5
@implementation TitleButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
//        
//        self.titleLabel.backgroundColor = [UIColor redColor];
//        self.backgroundColor = [UIColor yellowColor];
//        self.imageView.backgroundColor = [UIColor blueColor];
    }
    return self;
}


///**
// *  设置内部图片控件位置
// *
// *  @param contentRect button的bounds
// *
// *  @return
// */
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    return;
//}
//
///**
// *  设置内部lable控件位置
// *
// *  @param contentRect button的bounds
// *
// *  @return
// */
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    //  获取lable 的宽度
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSFontAttributeName] = self.titleLabel.font;
//    CGFloat titleW = [self.currentTitle sizeWithAttributes:attr].width;
//    return;
//}

//  想在系统计算和设置完按钮尺寸之后,再修改尺寸

/**
 *  重写setFrame:拦截设置按钮尺寸的过程
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.width += kMargin;
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //  如果仅仅改变titleLable和imageview的位置, 直接设置layoutSubviews;
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + kMargin;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
