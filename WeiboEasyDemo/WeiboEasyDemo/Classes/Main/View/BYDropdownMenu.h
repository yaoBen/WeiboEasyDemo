//
//  BYDropdownMenu.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/6.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BYDropdownMenu;
@protocol BYDropdownMenuDelegate <NSObject>
@optional
- (void)dropdownMenuDidShow:(BYDropdownMenu *)dropDownMenu;
- (void)dropdownMenuDidDismiss:(BYDropdownMenu *)dropDownMenu;

@end
@interface BYDropdownMenu : UIView
/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
@property (nonatomic, weak)  id<BYDropdownMenuDelegate> delegate;
@property (nonatomic, strong) UIViewController *contentViewController;
+ (instancetype)menu;
/**
 *  显示
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁
 */
- (void)dismiss;
@end
