//
//  ComposeToolBar.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/25.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ComposeToolBarButtonTypeCamera,     //  拍照
    ComposeToolBarButtonTypePicture,    //  相册
    ComposeToolBarButtonTypeMention,    //  @
    ComposeToolBarButtonTypeTrend,      //  #
    ComposeToolBarButtonTypeEmoticon    //  表情\键盘
    
} ComposeToolBarButtonType;

@class ComposeToolBar;
@protocol ComposeToolBarDelegate <NSObject>
@optional
- (void)composeToolBar:(ComposeToolBar *)toolBar didSelectedButton:(ComposeToolBarButtonType)type;


@end
@interface ComposeToolBar : UIView
@property (nonatomic, assign) BOOL showEmoticonKeyboard;
@property (nonatomic, weak)  id<ComposeToolBarDelegate> delegate;
@end
