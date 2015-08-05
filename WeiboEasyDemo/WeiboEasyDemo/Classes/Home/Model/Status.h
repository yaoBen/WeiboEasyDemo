//
//  Status.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/29.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface Status : NSObject
//** 微博id */
@property (nonatomic, copy)  NSString *idstr;
//** 微博来源 */
@property (nonatomic, copy)  NSString *source;
//** 微博信息内容 */
@property (nonatomic, copy)  NSString *text;
//**  微博作者的用户信息字段 */
@property (nonatomic, strong)  User *user;
/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;
/** 配图数组 */
@property (nonatomic, strong)  NSArray *pic_urls;
/** 转发微博 */
@property (nonatomic, strong)  Status *retweeted_status;

/**	int	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;

@end
