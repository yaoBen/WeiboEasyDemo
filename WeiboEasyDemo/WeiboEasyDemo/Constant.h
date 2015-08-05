//
//  Constant.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/2.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#ifndef WeiboEasyDemo_Constant_h
#define WeiboEasyDemo_Constant_h

// RGB色
#define BWColor(r, g ,b ,a)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 随机色
#define BWRandomColor            BWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1.0)

#define kUserDefaults            [NSUserDefaults standardUserDefaults]

#define kNotificationCenter      [NSNotificationCenter defaultCenter]


#endif
