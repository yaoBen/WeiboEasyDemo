//
//  NewFeatureViewController.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/12.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "TabbarViewController.h"

#define kNewFeatureCount    2
@interface NewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak)  UIPageControl *pagecontrol;
@end

@implementation NewFeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //  添加scrollview
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollview];
    
    CGFloat scrollW = scrollview.width;
    CGFloat scrollH = scrollview.height;
    for (int i = 0; i < kNewFeatureCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.x = i * scrollW;
        imageView.y = 0;
        //  显示图片
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i+1]];
        [scrollview addSubview:imageView];

        if (i == kNewFeatureCount - 1){
            [self setupLastImageView:imageView];
        }
    }
    //  设置scrollview的其它属性
    scrollview.contentSize = CGSizeMake(kNewFeatureCount * scrollW, 0);
    scrollview.bounces = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.delegate = self;
    
    //  添加pagecontroll
    UIPageControl *pagecontrol = [[UIPageControl alloc] init];
    pagecontrol.numberOfPages = kNewFeatureCount;
    pagecontrol.centerX = self.view.centerX;
    pagecontrol.centerY = scrollH - 50;
    pagecontrol.currentPageIndicatorTintColor = [UIColor orangeColor];
    pagecontrol.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self.view addSubview:pagecontrol];
    self.pagecontrol = pagecontrol;
#warning scrollview默认情况下,一创建出来就会带有一些子控件所以不能用scrollview。subviews lastobgject 添加imageview
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //  设置页码
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pagecontrol.currentPage = (int)(page + .5);
}

/**
 *  设置最后一张图片
 *
 *  @param imageView 最后一张图片
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    //  开启imageview的交互
    imageView.userInteractionEnabled = YES;
    //  添加分享按钮
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    shareBtn.width = 200;
    shareBtn.height = 40;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.y = imageView.height * 0.65;
    [imageView addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    //  添加开始微博按钮
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = imageView.width * 0.5;
    startBtn.y = CGRectGetMaxY(shareBtn.frame) + 10;
    [imageView addSubview:startBtn];
    [startBtn addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)shareClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.isSelected;
}
- (void)startClick:(UIButton *)startBtn
{
    TabbarViewController *tab = [[TabbarViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
}
@end
