//
//  NSString+Extension.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/20.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFount:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    return  [self boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}
- (CGSize)sizeWithFount:(UIFont *)font
{
    return [self sizeWithFount:font maxW:MAXFLOAT];
}

- (NSInteger)pathFileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
   
    NSInteger totalSize;
    BOOL dir;
    BOOL exist = [mgr fileExistsAtPath:self isDirectory:&dir];
    if (exist == NO) return 0;
    
    if (dir) {
        NSArray *subFiles = [mgr subpathsOfDirectoryAtPath:self error:nil];
        for (NSString *subPath in subFiles) {
            NSString *fullName = [self stringByAppendingPathComponent:subPath];
            [mgr fileExistsAtPath:fullName isDirectory:&dir];
            if (!dir) {
                totalSize += [[mgr attributesOfItemAtPath:fullName error:nil][NSFileSize] integerValue];
            }
        }
        return totalSize;
    }else{
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
    
}
@end
