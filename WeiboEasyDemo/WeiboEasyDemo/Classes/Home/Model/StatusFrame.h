//
//  StatusFrame.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/14.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//  1,存放着一个cell内部所有子控件的frame
//  2,cell的高度
//  3,一个数据模型Status

#import <Foundation/Foundation.h>


// 昵称字体
#define kStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define kStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define kStatusCellSourceFont kStatusCellTimeFont
// 正文字体
#define kStatusCellContentFont [UIFont systemFontOfSize:14]
// 转发微博正文字体
#define kStatusCellRetweetedContentFont [UIFont systemFontOfSize:13]

// cell的边框宽度
#define kStatusCellBorderW 10
// cell的间距
#define kStatusCellMargin 15
@class Status;

@interface StatusFrame : NSObject
@property (nonatomic, strong)  Status *status;
/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, assign)  CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign)  CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign)  CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign)  CGRect photosViewF;
/** 昵称 */
@property (nonatomic, assign)  CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign)  CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign)  CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign)  CGRect contentLabelF;

/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic, assign)  CGRect retweetedViewF;
/** 转发微博正文 */
@property (nonatomic, assign)  CGRect retweetedContentLabelF;
/** 转发微博配图 */
@property (nonatomic, assign)  CGRect retweetedPhotosViewF;

/* 工具条 */
/** 工具条 */
@property (nonatomic, assign)  CGRect toolbarF;

/** cell的高度 */
@property (nonatomic, assign)  CGFloat cellHeight;
@end
