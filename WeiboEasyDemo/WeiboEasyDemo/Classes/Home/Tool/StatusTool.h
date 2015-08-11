//
//  StatusTool.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/11.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusTool : NSObject

/**
 *  根据条件查询数据库里面的数据
 *
 *  @param params 查询条件
 *
 *  @return 返回要查得数据
 */
+ (NSArray *)statusesWithParams:(NSDictionary *)params;
/**
 *  保存微博数据
 *
 *  @param statuses 微博数组
 */
+ (void)saveStatuses:(NSArray *)statuses;
@end
