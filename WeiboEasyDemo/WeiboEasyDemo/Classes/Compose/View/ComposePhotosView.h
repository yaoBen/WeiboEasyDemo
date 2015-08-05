//
//  ComposePhotosView.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/25.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposePhotosView : UIView
@property (nonatomic, strong, readonly)  NSMutableArray *photos;
- (void)addPhoto:(UIImage *)image;
@end
