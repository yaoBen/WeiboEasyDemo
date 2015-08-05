//
//  StatusCell.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/14.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "StatusCell.h"
#import "StatusFrame.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "Photo.h"
#import "StatusToolbar.h"
#import "StatusPhotosView.h"
#import "IconView.h"

@interface StatusCell ()
/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, weak)  UIView *originalView;
/** 头像 */
@property (nonatomic, weak)  IconView *iconView;
/** 会员图标 */
@property (nonatomic, weak)  UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak)  StatusPhotosView *photosView;
/** 昵称 */
@property (nonatomic, weak)  UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak)  UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak)  UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak)  UILabel *contentLabel;

/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic, weak)  UIView *retweetedView;
/** 转发微博正文 */
@property (nonatomic, weak)  UILabel *retweetedContentLabel;
/** 转发微博配图 */
@property (nonatomic, weak)  StatusPhotosView *retweetedPhotosView;
/* 微博工具条 */
@property (nonatomic, weak)  StatusToolbar *toolbar;

@end
@implementation StatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
/**
 *  cell的初始化方法,一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件,以及子控件的一次性设置
 *
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        /**   初始化原创微博整体  */
        [self setupOriginalStatus];
        
        /**   初始化转发微博整体  */
        [self setupRetweetedStatus];
        
        /**   初始化工具条  */
        [self setupRetToolbar];
        
    }
    return self;
}
/**   初始化工具条  */
- (void)setupRetToolbar
{
    StatusToolbar *toolbar = [StatusToolbar toolbar];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}
/**
 *  初始化原创微博整体
 *
 */
- (void)setupOriginalStatus
{
    /** 原创微博整体 */
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    originalView.backgroundColor = [ UIColor whiteColor];
    self.originalView = originalView;
    
    /** 头像 */
    IconView *iconView = [[IconView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [originalView addSubview:vipView];
    self.vipView = vipView;
    /** 配图 */
    StatusPhotosView *photosView = [[StatusPhotosView alloc] init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    nameLabel.font = kStatusCellNameFont;
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    timeLabel.font = kStatusCellTimeFont;
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    sourceLabel.font = kStatusCellSourceFont;
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = kStatusCellContentFont;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;

}
/**   初始化转发微博整体  */
- (void)setupRetweetedStatus
{
    /** 转发微博整体 */
    UIView *retweetedView = [[UIView alloc] init];
    [self.contentView addSubview:retweetedView];
    retweetedView.backgroundColor = BWColor(240, 240, 240, 1);
    self.retweetedView = retweetedView;
    
    /** 转发微博正文 */
    UILabel *retweetedContentLabel = [[UILabel alloc] init];
    retweetedContentLabel.numberOfLines = 0;
    retweetedContentLabel.font = kStatusCellRetweetedContentFont;
    [retweetedView addSubview:retweetedContentLabel];
    self.retweetedContentLabel = retweetedContentLabel;
    
    /** 转发微博配图 */
    StatusPhotosView *retweetedPhotosView = [[StatusPhotosView alloc] init];
    [retweetedView addSubview:retweetedPhotosView];
    self.retweetedPhotosView = retweetedPhotosView;
}
- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    Status *status = statusFrame.status;
    User *user = status.user;
    /** 原创微博整体 */
    self.originalView.frame = statusFrame.originalViewF;
    
    /** 头像 */
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    
    /** 会员图标 */
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipStr = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipStr];
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.contentMode = UIViewContentModeCenter;
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    /** 配图 */
    if (status.pic_urls.count){
        self.photosView.frame = statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
//        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
    
    /** 昵称 */
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    /** 时间 */
    self.timeLabel.text = status.created_at;
    CGFloat timeX = CGRectGetMaxX(self.iconView.frame) + kStatusCellBorderW;
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + kStatusCellBorderW;
    CGSize timeSize = [status.created_at sizeWithFount:kStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){timeX,timeY,timeSize};
    
    /** 来源 */
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + kStatusCellBorderW;
    CGFloat sourceY = CGRectGetMaxY(self.nameLabel.frame) + kStatusCellBorderW;
    CGSize sourceSize = [status.source sizeWithFount:kStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){sourceX,sourceY,sourceSize};
    
    /** 正文 */
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    /*  转发微博  */
    if (status.retweeted_status) {
        Status *retweetedStatus = status.retweeted_status;
        User *retweetedUser = retweetedStatus.user;
        self.retweetedView.hidden = NO;
        /** 转发微博整体 */
        self.retweetedView.frame = statusFrame.retweetedViewF;
        /** 转发正文 */
        NSString *retweetedContent = [NSString stringWithFormat:@"@%@ : %@",retweetedUser.name,retweetedStatus.text];
        self.retweetedContentLabel.text = retweetedContent;
        self.retweetedContentLabel.frame = statusFrame.retweetedContentLabelF;
        /** 转发配图 */
        if (retweetedStatus.pic_urls.count){
            self.retweetedPhotosView.photos = retweetedStatus.pic_urls;
            self.retweetedPhotosView.hidden = NO;
            self.retweetedPhotosView.frame = statusFrame.retweetedPhotosViewF;
            
        }else{
            self.retweetedPhotosView.hidden = YES;
        }
    }else{
        self.retweetedView.hidden = YES;
    }
    
    /* 工具条 */
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.status = status;
}

@end
