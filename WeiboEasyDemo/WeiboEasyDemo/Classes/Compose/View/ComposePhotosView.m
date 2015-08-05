//
//  ComposePhotosView.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/25.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "ComposePhotosView.h"

@implementation ComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _photos = [NSMutableArray array];
    }
    return self;
}

- (void)addPhoto:(UIImage *)image
{
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageview];
    [self.photos addObject:image];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int cols = 3;
    CGFloat photoviewWH = 70;
    CGFloat photoMargin = 10;
    int photosCount = (int)self.subviews.count;
    for (int i = 0; i < photosCount ; i ++) {
        UIImageView *photoview = self.subviews[i];
        int col = i % cols;
        int row = i / cols;
        photoview.x = col * (photoviewWH + photoMargin);
        photoview.y = row * (photoviewWH + photoMargin);
        photoview.width = photoviewWH;
        photoview.height = photoviewWH;
    }
}


@end
