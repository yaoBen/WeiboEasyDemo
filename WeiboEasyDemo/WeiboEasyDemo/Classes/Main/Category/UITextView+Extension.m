//
//  UITextView+Extension.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/3.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

/**
 *  添加有属性的文字到textview
 *
 *  @param attr         属性文字
 *  @param settingBlock 对文字属性的设置block
 */
- (void)insertAttributedText:(NSAttributedString *)attr settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    // 获取原来的文字
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] init];
    [attrStr appendAttributedString:self.attributedText];
    
    // 光标位置
    NSUInteger loc = self.selectedRange.location;
    [attrStr replaceCharactersInRange:self.selectedRange withAttributedString:attr];
    if (settingBlock) {
        settingBlock(attrStr);
    }
    
    self.attributedText = attrStr;
    
    self.selectedRange = NSMakeRange(loc + 1, 0);
}
@end
