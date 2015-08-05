//
//  Emotion.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/30.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "Emotion.h"
#import "MJExtension.h"
@implementation Emotion

MJCodingImplementation

- (BOOL)isEqual:(Emotion *)object
{
    return [self.chs isEqualToString:object.chs] || [self.code isEqualToString:object.chs];
}
@end
