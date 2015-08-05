//
//  UITextView+Extension.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/3.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

/**
*  添加有属性的文字到textview
*
*  @param attr         属性文字
*  @param settingBlock 对文字属性的设置block
*/
- (void)insertAttributedText:(NSAttributedString *)attr settingBlock:(void(^)(NSMutableAttributedString *attributedText))settingBlock;
@end
