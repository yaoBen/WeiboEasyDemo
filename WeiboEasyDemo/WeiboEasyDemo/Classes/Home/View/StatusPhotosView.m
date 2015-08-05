//
//  StatusPhotosView.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/21.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "StatusPhotosView.h"
#import "UIImageView+WebCache.h"
#import "Photo.h"

#define kStatusPhotoWH   70
#define kStatusPhotoMargin  10
#define kStatusPhotosMaxCols(count)  ((count == 4)?2:3)
@implementation StatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


+ (CGSize)sizeWithStatusPhotosCount:(int)count
{
    int maxCols = kStatusPhotosMaxCols(count);
    int cols = count >= maxCols?maxCols:count;
    int rows = (count + maxCols -1)/maxCols;
    
    CGFloat width = cols * kStatusPhotoWH + (cols-1) * kStatusPhotoMargin;
    CGFloat height = rows * kStatusPhotoWH + (rows-1) * kStatusPhotoMargin;
    return CGSizeMake(width, height);
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    // 添加足够的photo控件
    NSUInteger photosCount = photos.count;
    while ( self.subviews.count < photosCount ) {
        UIImageView *photoview = [[UIImageView alloc] init];
        photoview.contentMode = UIViewContentModeScaleAspectFill;
        photoview.clipsToBounds = YES;
        [self addSubview:photoview];
    }
    
    // 遍历所有的photoview,添加图片
    for (int i = 0; i < self.subviews.count; i ++) {
        UIImageView *photoview = self.subviews[i];
        if (i < photosCount) {
            Photo *photo = _photos[i];
            [photoview sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            photoview.hidden = NO;
        }else{
            photoview.hidden = YES;
        }
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    int photosCount = (int)self.photos.count;
    for (int i = 0; i < photosCount ; i ++) {
        UIImageView *photoview = self.subviews[i];
        int col = i % kStatusPhotosMaxCols(photosCount);
        int row = i / kStatusPhotosMaxCols(photosCount);
        photoview.x = col * (kStatusPhotoWH + kStatusPhotoMargin);
        photoview.y = row * (kStatusPhotoMargin + kStatusPhotoWH);
        photoview.width = kStatusPhotoWH;
        photoview.height = kStatusPhotoWH;
    }
    
}
@end
