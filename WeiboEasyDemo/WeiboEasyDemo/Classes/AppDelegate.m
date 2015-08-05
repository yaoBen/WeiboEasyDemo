//
//  AppDelegate.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/2.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "AppDelegate.h"
#import "OAuthViewController.h"
#import "AccountTool.h"
#import "SDWebImageManager.h"
#import "Status.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    Account *account = [AccountTool account];
    // 2.成为主窗口
    [self.window makeKeyAndVisible];
    
    // 3.设置根控制器
    if (account) {
        [self.window switchRootViewController];
    }else{
        OAuthViewController *ovc = [[OAuthViewController alloc] init];
        self.window.rootViewController = ovc;
    }
    
    
//     2.设置根控制器
//    NSString *key = @"CFBundleVersion";
//    NSString *lastVersion = [kUserDefaults stringForKey:key];
//    
//    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
//    NSString *currentVersion = info[key];
//    if ([lastVersion isEqualToString:currentVersion]) {
//        TabbarViewController *tabbarVc = [[TabbarViewController alloc] init];
//        self.window.rootViewController = tabbarVc;
//    }else{
//        NewFeatureViewController *nfVc = [[NewFeatureViewController alloc] init];
//        self.window.rootViewController = nfVc;
//        [kUserDefaults setObject:currentVersion forKey:key];
//        [kUserDefaults synchronize];
//    }
    
    
    

    
    /* --------  大量重复代码
//    // 设置文字属性
//    NSMutableDictionary *textattr = [NSMutableDictionary dictionary];
//    textattr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    NSMutableDictionary *seletedTextattr = [NSMutableDictionary dictionary];
//    seletedTextattr[NSForegroundColorAttributeName] = [UIColor greenColor];
//    // 3.设置自控制器
//    UIViewController *vc1 = [[UIViewController alloc] init];
//    vc1.tabBarItem.title = @"首页";
//    vc1.tabBarItem.image = [UIImage imageNamed:@"apptab_06"];
//    // 声明图片按原始属性展示,不用自动渲染成其他颜色.
//    vc1.tabBarItem.selectedImage = [[UIImage imageNamed:@"apptab_03"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    // 设置文字的样式
//    [vc1.tabBarItem setTitleTextAttributes:textattr forState:UIControlStateNormal];
//    [vc1.tabBarItem setTitleTextAttributes:seletedTextattr forState:UIControlStateSelected];
//    vc1.view.backgroundColor = BWRandomColor;
//    UIViewController *vc2 = [[UIViewController alloc] init];
//    vc2.tabBarItem.title = @"消息";
//    vc2.tabBarItem.image = [UIImage imageNamed:@"apptab_08"];
//    vc2.tabBarItem.selectedImage = [[UIImage imageNamed:@"apptab_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [vc2.tabBarItem setTitleTextAttributes:textattr forState:UIControlStateNormal];
//    [vc2.tabBarItem setTitleTextAttributes:seletedTextattr forState:UIControlStateSelected];
//    vc2.view.backgroundColor = BWRandomColor;
//    UIViewController *vc3 = [[UIViewController alloc] init];
//    vc3.tabBarItem.title = @"发现";
//    vc3.tabBarItem.image = [UIImage imageNamed:@"apptab_05"];
//    vc3.tabBarItem.selectedImage = [[UIImage imageNamed:@"apptab_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [vc3.tabBarItem setTitleTextAttributes:textattr forState:UIControlStateNormal];
//    [vc3.tabBarItem setTitleTextAttributes:seletedTextattr forState:UIControlStateSelected];
//    vc3.view.backgroundColor = BWRandomColor;
//    UIViewController *vc4 = [[UIViewController alloc] init];
//    vc4.tabBarItem.title = @"我";
//    vc4.tabBarItem.image = [UIImage imageNamed:@"apptab_07"];
//    vc4.tabBarItem.selectedImage = [[UIImage imageNamed:@"apptab_04"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [vc4.tabBarItem setTitleTextAttributes:textattr forState:UIControlStateNormal];
//    [vc4.tabBarItem setTitleTextAttributes:seletedTextattr forState:UIControlStateSelected];
//    vc4.view.backgroundColor = BWRandomColor;
     */
    
    // 很多重复代码 ---->将重复代码抽取到一个方法中
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /**
     *   app的状态
     *   1,死亡状态，没有打开app
     *   2,前台运行状态
     *   3,后台暂停状态:停止一切动画,定时器,多媒体操作,联网操作,很难进行其他操作
     *   4,后台运行状态
     */
    // 向操作系统申请后台运行的资格,能维持多久,是不确定的
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        // 当申请运行时间已经过期,就会调用该block
        [application endBackgroundTask:task];
    }];
    
    // 在info.plist设置后台模式 Required background modes ==  App plays audio or streams audio/video using AirPlay
    // 搞一个0kb的MP3循环播放
    
    // 以前的后台模式
    // 保持网络连接
    // 多媒体播放
    // VOIP:网络电话
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    //  1,取消下载
    [mgr cancelAll];
    //  2,清除缓存中的所有图片
    [mgr.imageCache clearMemory];
    
}
@end
