//
//  IconView.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/22.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "IconView.h"
#import "User.h"
#import "UIImageView+WebCache.h"

@interface IconView ()
// 认证类型图片
@property (nonatomic, weak)  UIImageView *verifiedview;

@end
@implementation IconView


- (UIImageView *)verifiedview
{
    if (!_verifiedview) {
        UIImageView *verifiedview = [[UIImageView alloc] init];
        [self addSubview:verifiedview];
        self.verifiedview = verifiedview;
    }
    return _verifiedview;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

//UserVerifiedTypeNone = -1,
//UserVerifiedTypePersonal = 0,
//UserVerifiedTypeOrgEnterprice = 2, // 企业官方
//UserVerifiedTypeOrgMedia = 3, // 媒体官方
//UserVerifiedTypeOrgWebsite = 5,// 网站官方
//UserVerifiedTypeDaren = 220
-(void)setUser:(User *)user
{
    _user = user;
    // 设置头像图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    // 设置认证图标
    self.verifiedview.hidden = NO;
    switch (user.verified_type) {
        case UserVerifiedTypePersonal:
            self.verifiedview.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case UserVerifiedTypeOrgEnterprice:
        case UserVerifiedTypeOrgMedia:
        case UserVerifiedTypeOrgWebsite:
            self.verifiedview.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
        case UserVerifiedTypeDaren:
            self.verifiedview.image = [UIImage imageNamed:@"avatar_grassroot"];
        default:
            self.verifiedview.hidden = YES;
            break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.verifiedview.size = self.verifiedview.image.size;
    self.verifiedview.x = self.width - self.verifiedview.width * .6;
    self.verifiedview.y = self.height - self.verifiedview.height * .6;
}
@end
