//
//  EmotionPageView.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/31.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 每行最多表情个数 */
#define kEmotionMaxCols   7
/** 每列最多表情的个数 */
#define kEmotionMaxRows   3
/** 每页表情的个数 */
#define kEmotionNumberOfPage  ((kEmotionMaxCols * kEmotionMaxRows) - 1)
@interface EmotionPageView : UIView
/** 每页显示的表情数组 */
@property (nonatomic, strong)  NSArray *emotions;
@end
