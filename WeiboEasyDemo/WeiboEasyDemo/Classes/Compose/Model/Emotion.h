//
//  Emotion.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/30.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emotion : NSObject<NSCoding>
/** 表情的文字描述 */
@property (nonatomic, copy)  NSString *chs;
/** 表情的图片名 */
@property (nonatomic, copy)  NSString *png;
/** emoji表情的编码 */
@property (nonatomic, copy)  NSString *code;
@end
