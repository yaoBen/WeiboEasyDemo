//
//  UIBarButtonItem+Extension.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/4.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

/**
 *  创建一个barItem
 *
 *  @param target    点击Item后调用哪个对象的方法
 *  @param action    点击Item后执行target对应的方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 返回一个创建完的barItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
