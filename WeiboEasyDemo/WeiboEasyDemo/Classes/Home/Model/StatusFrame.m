//
//  StatusFrame.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/14.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "StatusFrame.h"
#import "Status.h"
#import "User.h"
#import "StatusPhotosView.h"


@implementation StatusFrame


- (void)setStatus:(Status *)status
{
    _status = status;
    User *user = status.user;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    /** 头像 */
    CGFloat iconX = kStatusCellBorderW;
    CGFloat iconY = kStatusCellBorderW;
    CGFloat iconWH = 35;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + kStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFount:kStatusCellNameFont];
    self.nameLabelF = (CGRect){nameX,nameY,nameSize};
    /** 会员图标 */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + kStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipW = 15;
        CGFloat vipH = nameSize.height;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    /** 时间 */
    CGFloat timeX = CGRectGetMaxX(self.iconViewF) + kStatusCellBorderW;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + kStatusCellBorderW;
    CGSize timeSize = [status.created_at sizeWithFount:kStatusCellTimeFont];
    self.timeLabelF = (CGRect){timeX,timeY,timeSize};
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + kStatusCellBorderW;
    CGFloat sourceY = CGRectGetMaxY(self.nameLabelF) + kStatusCellBorderW;
    CGSize sourceSize = [status.source sizeWithFount:kStatusCellSourceFont];
    self.sourceLabelF = (CGRect){sourceX,sourceY,sourceSize};
    /** 正文 */
    CGFloat contentX = kStatusCellBorderW;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + kStatusCellBorderW;
    CGFloat maxW = cellW - 2*contentX;
    CGSize contentSize = [status.text sizeWithFount:kStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){contentX,contentY,contentSize};
    /** 配图 */
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        CGFloat photosX = iconX;
        CGFloat photosY = CGRectGetMaxY(self.contentLabelF) + kStatusCellBorderW;
        int photoCount = (int)status.pic_urls.count;
        CGSize photosSize = [StatusPhotosView sizeWithStatusPhotosCount:photoCount];
        self.photosViewF = (CGRect){photosX, photosY, photosSize};
        originalH = CGRectGetMaxY(self.photosViewF)+kStatusCellBorderW;
    }else{
        originalH = CGRectGetMaxY(self.contentLabelF)+kStatusCellBorderW;
    }
    /** 原创微博整体 */
    self.originalViewF = CGRectMake(0, kStatusCellMargin, cellW, originalH);
    CGFloat toolbarY;
    /* 转发微博 */
    if (status.retweeted_status) {//  有转发微博
        Status *retweetedStatus = status.retweeted_status;
        User *retweetedUser = retweetedStatus.user;
        
        /**  转发微博正文 */
        CGFloat retweetedContentX = kStatusCellBorderW;
        CGFloat retweetedContentY = 0;
        NSString *retweetedContent = [NSString stringWithFormat:@"@%@ : %@",retweetedUser.name,retweetedStatus.text];
        CGSize retweetedContentSize = [retweetedContent sizeWithFount:kStatusCellRetweetedContentFont maxW:maxW];
        self.retweetedContentLabelF = (CGRect){retweetedContentX,retweetedContentY,retweetedContentSize};
        /** 转发微博配图 */
        
        CGFloat retweetedH = 0;
        if (retweetedStatus.pic_urls.count) {
            CGFloat retweetedPhotosX = kStatusCellBorderW;
            CGFloat retweetedPhotosY = CGRectGetMaxY(self.retweetedContentLabelF) + kStatusCellBorderW;
            int retweetedPhotoCount = (int)retweetedStatus.pic_urls.count;
            CGSize retweetedPhotosSize = [StatusPhotosView sizeWithStatusPhotosCount:retweetedPhotoCount];
            self.retweetedPhotosViewF = (CGRect){retweetedPhotosX, retweetedPhotosY, retweetedPhotosSize};
            retweetedH = CGRectGetMaxY(self.retweetedPhotosViewF)+kStatusCellBorderW;
        }else{
            retweetedH = CGRectGetMaxY(self.retweetedContentLabelF)+kStatusCellBorderW;
        }
        /**  转发微博整体 */
        self.retweetedViewF = CGRectMake(0, CGRectGetMaxY(self.originalViewF), cellW, retweetedH);
        
        toolbarY = CGRectGetMaxY(self.retweetedViewF);
    }else{//  没有转发微博
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    /* 工具条 */
    /** 工具条 */
    CGFloat toolbarX = 0;
    CGFloat toolbarH = 35;
    self.toolbarF = CGRectMake(toolbarX, toolbarY, cellW, toolbarH);
    
    /** cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.toolbarF);
}
@end
