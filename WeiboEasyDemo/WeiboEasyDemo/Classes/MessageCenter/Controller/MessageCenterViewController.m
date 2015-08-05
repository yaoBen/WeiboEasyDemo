//
//  MessageCenterViewController.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/2.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "Test1ViewController.h"

@interface MessageCenterViewController ()

@end

@implementation MessageCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // style: 这个参数是用来设置背景的,在ios7之前效果比较明显,之后没有效果
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // (只有在viewWillAppear的时候才能显示disable状态下的主题, 是因为view提前创建了  /*关掉背景颜色*/)
//    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)composeMsg
{
    BWLog(@"compose message");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifierCell];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据%ld",(long)indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Test1ViewController *tvc1 = [[Test1ViewController alloc] init];
    tvc1.title = @"test1控制器";
    [self.navigationController pushViewController:tvc1 animated:YES];
}
@end
