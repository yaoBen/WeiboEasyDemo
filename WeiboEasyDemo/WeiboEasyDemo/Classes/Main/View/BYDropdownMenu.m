//
//  BYDropdownMenu.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/6.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "BYDropdownMenu.h"

@interface BYDropdownMenu ()
/**
 *  将来用来显示具体内容的容器
 */
@property (nonatomic, weak) UIImageView *containerView;
@end
@implementation BYDropdownMenu

- (UIImageView *)containerView
{
    if (!_containerView) {
        //  添加一个灰色图片控件
        UIImageView *containerView = [[UIImageView alloc] init];
        //  如果图片某个方向不规则(如突起或凹进去),那该方向就不能拉伸
        containerView.image = [UIImage imageNamed:@"popover_background"];
      //  containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  清除颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
+ (instancetype)menu
{
    return [[self alloc] init];
}

- (void)setContent:(UIView *)content
{
    _content = content;
    //  调整内容的位置
    content.x = 10;
    content.y = 15;

    //  调整内容的宽度
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    //  设置灰色的尺寸
    self.containerView.height = CGRectGetMaxY(content.frame) + 11;
    
    //  添加灰色图片到内容中
    [self.containerView addSubview:content];
}

- (void)setContentViewController:(UIViewController *)contentViewController
{
    _contentViewController = contentViewController;
    self.content = contentViewController.view;
}
/**
 *  显示
 */
- (void)showFrom:(UIView *)from
{
    //  获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //  添加自己到窗口上
    [window addSubview:self];
    
    //  设置尺寸
    self.frame = window.bounds;
    
    //  调整灰色图片的位置
    //  默认情况下 frame的坐标是已父控件左上角为坐标原点
    //  转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}

/**
 *  销毁
 */
- (void)dismiss
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}


@end
