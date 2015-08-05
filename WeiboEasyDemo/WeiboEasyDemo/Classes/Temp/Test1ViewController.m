//
//  Test1ViewController.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/3.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "Test1ViewController.h"
#import "Test2ViewController.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
//    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
//    backBtn.size = backBtn.currentImage.size;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    Test2ViewController *tvc2 = [[Test2ViewController alloc] init];
    tvc2.title = @"test2测试器";
    [self.navigationController pushViewController:tvc2 animated:YES];
}
@end
