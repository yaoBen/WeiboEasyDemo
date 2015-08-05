//
//  BWSearchBar.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/5.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "BWSearchBar.h"

@implementation BWSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"搜索";
        self.background = [UIImage imageNamed:@"search_navigationbar_background"];
        self.font = [UIFont systemFontOfSize:14];
        //   通过init创建初始化绝大部分控件，控件是没有尺寸的
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

@end
