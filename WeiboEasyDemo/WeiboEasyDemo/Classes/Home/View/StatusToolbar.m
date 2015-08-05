//
//  StatusToolbar.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/17.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "StatusToolbar.h"
#import "Status.h"

@interface StatusToolbar ()
/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;

/**	转发按钮 */
@property (nonatomic, weak) UIButton *repostsBtn;
/**	评论按钮 */
@property (nonatomic, weak) UIButton *commentsBtn;
/**	表态按钮 */
@property (nonatomic, weak) UIButton *attitudesBtn;


@end
@implementation StatusToolbar

- (NSMutableArray *)btns
{
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}
+ (instancetype)toolbar
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame] ) {
        self.backgroundColor = [UIColor whiteColor];
        self.repostsBtn = [self setupBtnWith:@"转发" icon:@"timeline_icon_retweet"];
        self.commentsBtn = [self setupBtnWith:@"评论" icon:@"timeline_icon_comment"];
        self.attitudesBtn = [self setupBtnWith:@"赞" icon:@"timeline_icon_unlike"];
        // 添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}
/**
 * 添加分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}
/**
 *  初始化按钮
 *
 *  @param title 按钮标题
 *  @param icon  按钮图片名字
 */
- (UIButton *)setupBtnWith:(NSString *)title icon:(NSString *)icon
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    return btn;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    int btnCount = (int)self.btns.count;
    CGFloat btnW = self.width / btnCount;
    for (int i = 0; i < btnCount; i ++) {
        UIButton *btn = self.btns[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = self.height;
    }
    
    int dividerCount = (int)self.dividers.count;
    for (int i = 0; i < dividerCount; i ++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = self.height;
        divider.x = (i + 1) * btnW;
        divider.y = 0;
    }
}

- (void)setStatus:(Status *)status
{
    _status = status;
    [self setupBtn:self.repostsBtn count:status.reposts_count title:@"转发"];
    [self setupBtn:self.commentsBtn count:status.comments_count title:@"评论"];
    [self setupBtn:self.attitudesBtn count:status.attitudes_count title:@"赞"];
    
}
/**
 *  设置按钮的标题
 *
 *  @param btn   要设置的按钮
 *  @param count 标题数字
 *  @param title 原标题
 */
- (void)setupBtn:(UIButton *)btn count:(int)count title:(NSString *)title
{
    if (count) {
        if (count > 10000) {
            double reCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",reCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{
            title = [NSString stringWithFormat:@"%d",count];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
@end
