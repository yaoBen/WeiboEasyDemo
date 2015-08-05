//
//  NavigationViewController.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/3.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//
#import "UIView+Extension.h"
#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController


+ (void)initialize
{
    //  设置整个项目item主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //  设置普通状态
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttr[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    
    NSMutableDictionary *disabledAttr = [NSMutableDictionary dictionary];
    disabledAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disabledAttr[NSFontAttributeName] = textAttr[NSFontAttributeName];
    [item setTitleTextAttributes:disabledAttr forState:UIControlStateDisabled];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        /*  设置导航栏内容  */
        
//        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        // 设置图片
//        [backBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
//        [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
//        // 设置尺寸
//        backBtn.size = backBtn.currentImage.size;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        
//        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
//        [moreBtn setImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
//        [moreBtn setImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
//        moreBtn.size = moreBtn.currentImage.size;
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
        
        // 自动显示或隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}
@end
