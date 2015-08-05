//
//  StatusPhotosView.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/21.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusPhotosView : UIView

@property (nonatomic, strong)  NSArray *photos;
+ (CGSize)sizeWithStatusPhotosCount:(int)count;
@end
