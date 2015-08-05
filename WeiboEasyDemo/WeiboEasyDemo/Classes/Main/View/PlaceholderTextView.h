//
//  PlaceholderTextView.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/23.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy)  NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong)  UIColor *placeholderColor;

@end
