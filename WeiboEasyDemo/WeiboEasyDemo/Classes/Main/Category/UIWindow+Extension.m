//
//  UIWindow+Extension.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/25.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "TabbarViewController.h"
#import "NewFeatureViewController.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [kUserDefaults stringForKey:key];
    
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = info[key];
    if ([lastVersion isEqualToString:currentVersion]) {
        TabbarViewController *tabbarVc = [[TabbarViewController alloc] init];
        self.rootViewController = tabbarVc;
    }else{
        NewFeatureViewController *nfVc = [[NewFeatureViewController alloc] init];
        self.rootViewController = nfVc;
        [kUserDefaults setObject:currentVersion forKey:key];
        [kUserDefaults synchronize];
    }
}
@end
