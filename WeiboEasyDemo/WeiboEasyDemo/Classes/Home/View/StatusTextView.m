//
//  StatusTextView.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/8/7.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "StatusTextView.h"
#import "Special.h"

#define kStatusTextViewConverTag  999
@implementation StatusTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.editable = NO;
        // 禁止滚动  让文字全部显示出来
        self.scrollEnabled = NO;
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
    }
    return self;
}

- (void)setupSpecialRects
{
    id specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (Special *special in specials) {
        self.selectedRange = special.range;
        // 获得选中范围的矩形框
        NSArray *selectedRects = [self selectionRectsForRange:self.selectedTextRange];
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        
        NSMutableArray *rects = [NSMutableArray array];
        for (UITextSelectionRect *selectionRect in selectedRects) {
            CGRect rect = selectionRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0) continue;
            
            [rects addObject:[NSValue valueWithCGRect:rect]];
        }
        special.rects = rects;
    }
}
- (Special *)touchintSpecialWith:(CGPoint)location
{
    id specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (Special *special in specials) {
        for ( NSValue *valueRect in special.rects ) {
            if (CGRectContainsPoint(valueRect.CGRectValue, location)) {
                return special;
            }
        }
    }
    return nil;

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];

    [self setupSpecialRects];
    Special *special = [self touchintSpecialWith:location];
    for ( NSValue *valueRect in special.rects ) {
            UIView *conver = [[UIView alloc] init];
            conver.tag = kStatusTextViewConverTag;
            conver.frame = valueRect.CGRectValue;
            conver.backgroundColor = [UIColor greenColor];
            [self insertSubview:conver atIndex:0];
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *child in self.subviews) {
        if (child.tag == kStatusTextViewConverTag) {
            [child removeFromSuperview];
        }
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
//    BWLog(@"point:%@",NSStringFromCGPoint(point));
//    return YES;
    [self setupSpecialRects];
    Special *special = [self touchintSpecialWith:point];
    if (special.rects.count) {
        return YES;
    }else{
        return NO;
    }
}
@end
