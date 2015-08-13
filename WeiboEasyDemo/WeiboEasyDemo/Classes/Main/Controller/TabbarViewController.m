//
//  TabbarViewController.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/3.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "TabbarViewController.h"
#import "HomeViewController.h"
#import "MessageCenterViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "NavigationViewController.h"
#import "BYTabBar.h"
#import "ComposeViewController.h"

@interface TabbarViewController ()<BYTabBarDelegate>

@end

@implementation TabbarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    [self addChildVc:home WithTitle:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    MessageCenterViewController *messageCenter = [[MessageCenterViewController alloc] init];
    [self addChildVc:messageCenter WithTitle:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    [self addChildVc:discover WithTitle:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    [self addChildVc:profile WithTitle:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
//    [self setValue:[[BYTabBar alloc] init] forKey:@"tabBar"];
//    UIButton *plusBtn = [[UIButton alloc] init];//WithFrame:CGRectMake(160, 2, 64, 44)
//    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
//    [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateNormal];
//    [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
//    [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateNormal];
//    plusBtn.size = plusBtn.currentBackgroundImage.size;
//   // [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
//    plusBtn.centerX = self.tabBar.width * .5;
//    plusBtn.centerY = self.tabBar.height * .5;
//    BWLog(@"plus btton:%@\n%@",NSStringFromCGRect(plusBtn.frame),NSStringFromCGRect(self.tabBar.frame));
//    [self.tabBar addSubview:plusBtn];
    BYTabBar *tabbar = [[BYTabBar alloc] init];
    tabbar.delegate = self;
    [self setValue:tabbar forKey:@"tabBar"];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  添加一个自控制器
 *
 *  @param childVc  子控制器
 *  @param title    标题
 *  @param image    图片
 *  @param selImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc WithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selImage
{
//    childVc.tabBarItem.title = title;//
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字属性
    NSMutableDictionary *textattr = [NSMutableDictionary dictionary];
    textattr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    NSMutableDictionary *seletedTextattr = [NSMutableDictionary dictionary];
    seletedTextattr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVc.tabBarItem setTitleTextAttributes:textattr forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:seletedTextattr forState:UIControlStateSelected];
//    childVc.view.backgroundColor = BWRandomColor;
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}

#define mark - BYTabBarDelegate代理方法
- (void)tabBarDidClickPlusButton:(BYTabBar *)tabBar
{
    ComposeViewController *compose = [[ComposeViewController alloc] init];
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}
@end

