//
//  EmotionListView.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/27.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "EmotionListView.h"
#import "EmotionPageView.h"




@interface EmotionListView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageCtr;
@property (nonatomic, weak)  UIScrollView *scrollview;
@end
@implementation EmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIPageControl *pageCtr = [[UIPageControl alloc] init];
        pageCtr.hidesForSinglePage = YES;
        [pageCtr setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
        [pageCtr setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        [self addSubview:pageCtr];
        self.pageCtr = pageCtr;
        
        UIScrollView *scrollview = [[UIScrollView alloc] init];
        scrollview.delegate = self;
        scrollview.showsVerticalScrollIndicator = NO;
        scrollview.showsHorizontalScrollIndicator = NO;
        scrollview.bounces = NO;
        scrollview.pagingEnabled = YES;
        [self addSubview:scrollview];
        self.scrollview = scrollview;
        
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger numbenOfPage = (emotions.count + kEmotionNumberOfPage -1) / kEmotionNumberOfPage;
    // 设置pageConteoller
    self.pageCtr.numberOfPages = numbenOfPage;
    
    // 设置UIScrollView
    
    
    for (int i = 0; i < numbenOfPage ; i ++) {
        EmotionPageView *view = [[EmotionPageView alloc] init];
        /** 剩余表情个数 */
        NSUInteger left = emotions.count - i * kEmotionNumberOfPage;
        NSRange range;
        range.location = i * kEmotionNumberOfPage;
        if (left > kEmotionNumberOfPage) {
            range.length = kEmotionNumberOfPage;
        }else{
            range.length = left;
        }
        view.emotions = [emotions subarrayWithRange:range];
        [self.scrollview addSubview:view];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置pageConteoller
    self.pageCtr.width = self.width;
    self.pageCtr.x = 0;
    self.pageCtr.height = 35;
    self.pageCtr.y = self.height - self.pageCtr.height;
    

    // 设置UIScrollView
    self.scrollview.x = self.scrollview.y = 0;
    self.scrollview.width = self.width;
    self.scrollview.height = self.pageCtr.y;
    
    self.scrollview.contentSize = CGSizeMake(self.scrollview.subviews.count * self.scrollview.width, 0);
    for (int i = 0; i < self.scrollview.subviews.count ; i ++) {
        UIView *view = self.scrollview.subviews[i];
        view.size = self.scrollview.size;
        view.x = i * self.scrollview.width;
        view.y = 0;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNum = scrollView.contentOffset.x / scrollView.width;
    self.pageCtr.currentPage = (int)(pageNum + 0.5);
}
@end
