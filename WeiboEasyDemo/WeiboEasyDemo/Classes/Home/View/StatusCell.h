//
//  StatusCell.h
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/14.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrame;
@interface StatusCell : UITableViewCell
@property (nonatomic, strong)  StatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
