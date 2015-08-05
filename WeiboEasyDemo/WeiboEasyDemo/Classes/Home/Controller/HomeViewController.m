//
//  HomeViewController.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/2.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "HomeViewController.h"
#import "BYDropdownMenu.h"
#import "TitleMenuViewController.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "TitleButton.h"
#import "MJExtension.h"
#import "User.h"
#import "Status.h"
#import "UIImageView+WebCache.h"
#import "StatusFrame.h"
#import "StatusCell.h"
#import "HWLoadMoreFooter.h"
#import "Photo.h"

@interface HomeViewController ()<BYDropdownMenuDelegate>
@property (nonatomic, strong)  NSMutableArray *statusFrames;
@end

@implementation HomeViewController

- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = BWColor(230, 230, 230, 1);
    //  设置导航栏内容
    [self setuoNavigationItem];
    //  获取用户昵称
    [self setuoUserInfo];
    //  集成下拉刷新
    [self setupRefresh];
    // 集成上拉刷新控件
    [self setupUpRefresh];
    //  获取未读微博数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    //  主线程会抽出一些时间来处理timer(不管主线程是否在处理其他事件)
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  集成上拉刷新控件
 */
- (void)setupUpRefresh
{
    HWLoadMoreFooter *footer = [HWLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

/**
 *  获取未读微博数
 */
- (void)setupUnreadCount
{
    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc] init];
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    Account *account = [AccountTool account];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:account.access_token forKey:@"access_token"];
    [postDic setObject:account.uid forKey:@"uid"];
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //  设置提醒数字
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = [status intValue];
        }
        BWLog(@"请求成功:%@\n",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BWLog(@"请求不成功:%@",error);
    }];

}
/**
 *  集成下拉刷新
 */
- (void)setupRefresh
{
    //  1,添加刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:refreshControl];
    //  2,进入刷新状态
    [refreshControl beginRefreshing];
    //  3,开始刷新
    [self refreshStateChange:refreshControl];
}

/**
 *  刷新微博数据
 *
 *  @param refreshControl
 */
- (void)refreshStateChange:(UIRefreshControl *)refreshControl
{
    
    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc] init];
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    Account *account = [AccountTool account];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:account.access_token forKey:@"access_token"];
    StatusFrame *lastStatusF = self.statusFrames.firstObject;
    if (lastStatusF) {
        [postDic setObject:lastStatusF.status.idstr forKey:@"since_id"];
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //  新微博数组
        [Status setupObjectClassInArray:^NSDictionary *{
            return @{@"pic_urls":@"Photo"};
        }];
        NSArray *newStatuses = [Status objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        //  添加到原数组前面
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        BWLog(@"请求成功:%@\n",responseObject);
        [self.tableView reloadData];
        [refreshControl endRefreshing];
        //  显示新微博数量
        [self showNewStatusesCount:newStatuses.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [refreshControl endRefreshing];
        BWLog(@"请求不成功:%@",error);
    }];
    
}

/**
 *  将Status模型转换为StatusFrame模型
 *
 *  @param statuses  Status模型
 *
 *  @return
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *newFrames = [NSMutableArray array];
    for (Status *status in statuses) {
        StatusFrame *f = [[StatusFrame alloc] init];
        f.status = status;
        [newFrames addObject:f];
    }
    return newFrames;
}
/**
 *  显示新微博数量
 *
 *  @param count 微博数量
 */
- (void)showNewStatusesCount:(NSUInteger)count
{
    // 刷新成功(清空图标数字)
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // 1.添加label
    UILabel *label = [[UILabel alloc] init];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    label.y = 64 - label.height;
    // 2.设置label的背景颜色
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    if (count == 0) {
        label.text = @"没有新微博数据,请稍后再试";
    }else{
        label.text = [NSString stringWithFormat:@"共刷新了%lu条微博数据",(unsigned long)count];
    }
//    [self.navigationController.view addSubview:label];
    // 3.添加到导航控制器的view上,并在navigationbar的下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    // 4.开始动画
    [UIView animateWithDuration:0.8 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8 delay:1. options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}
/**
 *  设置导航栏内容
 */
- (void)setuoNavigationItem
{
    /* 设置导航栏左右的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    /* 设置导航栏中间的标题 */
    UIButton *titleButton = [[TitleButton alloc] init];
    //    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    titleButton.width = 150;
    //    titleButton.height = 30;
    Account *account = [AccountTool account];
    //  设置文字
    NSString *name = account.name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    //    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    //    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    //    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    //    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    //    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    //  设置button监听
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}
/*
    access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    uid	false	int64	需要查询的用户ID。
 */
/**
 *  获取用户昵称
 */
- (void)setuoUserInfo
{
    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc] init];
    Account *account = [AccountTool account];
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:account.access_token forKey:@"access_token"];
    [postDic setObject:account.uid forKey:@"uid"];
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        account.name = responseObject[@"name"];
        [AccountTool saveAccount:account];
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        [titleButton setTitle:account.name forState:UIControlStateNormal];
        BWLog(@"请求成功:%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BWLog(@"请求不成功:%@",error);
    }];
}

///**
// *  加载微博数据
// *
// *  @return 
// */
////https://api.weibo.com/2/statuses/friends_timeline.json
//- (void)loadNewStatus
//{
//    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc] init];
//    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
//    Account *account = [AccountTool account];
//    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
//    [postDic setObject:account.access_token forKey:@"access_token"];
//    
//    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSArray *statuses = [Status objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        self.statusFrames = [self statusFramesWithStatuses:statuses];
//        BWLog(@"请求成功:%@\n%@",responseObject,statuses);
//        [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        BWLog(@"请求不成功:%@",error);
//    }];
//}

- (void)friendsearch
{
    BWLog(@"friendsearch");
}

- (void)pop
{
    BWLog(@"pop");
}
- (void)titleClick:(UIButton *)titleButton
{
    //  显示下拉菜单
    BYDropdownMenu *menu = [BYDropdownMenu menu];
    menu.delegate = self;
//    menu.content = [UIButton buttonWithType:UIButtonTypeContactAdd];
    //  设置显示的内容
    TitleMenuViewController *vc = [[TitleMenuViewController alloc] init];
    vc.view.height = 132;
    vc.view.width = 150;
    menu.contentViewController = vc;
    //  显示下拉菜单
    [menu showFrom:titleButton];
    
    
    
//     //  这样获得的窗口是当前显示在屏幕最上面的窗口
//    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
//    //添加蒙板
//    UIView *cover = [[UIView alloc] init];
//    cover.frame = window.bounds;
//    cover.backgroundColor = [UIColor clearColor];
//    [window addSubview:cover];
//    //添加带箭头的灰色图片
//    UIImageView *dropdownMenu = [[UIImageView alloc] init];
//    //  如果图片某个方向不规则(如突起或凹进去),那该方向就不能拉伸
//    dropdownMenu.image = [UIImage imageNamed:@"popover_background"];
//    dropdownMenu.width = 217;
//    dropdownMenu.height = 220;
//    dropdownMenu.x = 52;
//    dropdownMenu.y = 64;
//    dropdownMenu.userInteractionEnabled = YES;
//    TitleMenuViewController *vc = [[TitleMenuViewController alloc] init];
//    vc.view.height = 132;
//    [dropdownMenu addSubview:vc.view];
//   
//    [cover addSubview:dropdownMenu];
    
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    StatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        [Status setupObjectClassInArray:^NSDictionary *{
            return @{@"pic_urls":@"Photo"};
        }];
        NSArray *newStatuses = [Status objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将 HWStatus数组 转为 HWStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BWLog(@"请求失败-%@", error);
        
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusCell *cell = [StatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
//    StatusFrame *statusF = self.statusFrames[indexPath.row];
//    Status *status = statusF.status;
//    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
//    cell.textLabel.text = status.source;
//    cell.detailTextLabel.text = status.text;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
}

#pragma mark - Table view Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *statusF = self.statusFrames[indexPath.row];
    return statusF.cellHeight;
}


#pragma mark - BYDropdownMenu Delegate

- (void)dropdownMenuDidShow:(BYDropdownMenu *)dropDownMenu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
}

- (void)dropdownMenuDidDismiss:(BYDropdownMenu *)dropDownMenu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
}

@end
