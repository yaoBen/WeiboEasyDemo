//
//  TextPart.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/6.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "TextPart.h"

@implementation TextPart

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@----%@",self.text,NSStringFromRange(self.range)];
}
@end
