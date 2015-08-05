//
//  User.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/29.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    UserVerifiedTypeNone = -1,
    UserVerifiedTypePersonal = 0,
    UserVerifiedTypeOrgEnterprice = 2, // 企业官方
    UserVerifiedTypeOrgMedia = 3, // 媒体官方
    UserVerifiedTypeOrgWebsite = 5,// 网站官方
    UserVerifiedTypeDaren = 220
} UserVerifiedType;





@interface User : NSObject
/** 用户的微博id */

@property (nonatomic, copy)  NSString *idstr;
/** 用户的微博昵称 */
@property (nonatomic, copy)  NSString *name;
/** 用户的微博头像地址 */
@property (nonatomic, copy)  NSString *profile_image_url;
/** 会员类型 > 2 代表是会员 */
@property (nonatomic, assign)  int mbtype;
/** 会员等级 */
@property (nonatomic, assign)  int mbrank;

@property (nonatomic, assign, getter = isVip)  BOOL vip;

/** 认证类型 */
@property (nonatomic, assign)  UserVerifiedType verified_type;


@end
