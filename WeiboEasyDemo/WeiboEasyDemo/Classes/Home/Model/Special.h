//
//  Special.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/7.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Special : NSObject
/** 这个特殊片段的文字 */
@property (nonatomic, copy)  NSString *text;
/** 这个特殊片段的范围 */
@property (nonatomic, assign)  NSRange range;
/** 这个特殊片段的矩形框 */
@property (nonatomic, strong)  NSArray *rects;
@end
