//
//  Test2ViewController.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/4.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "Test2ViewController.h"
#import "Test3ViewController.h"

@interface Test2ViewController ()

@end

@implementation Test2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    Test3ViewController *tvc3 = [[Test3ViewController alloc] init];
    tvc3.title = @"test3控制器";
    [self.navigationController pushViewController:tvc3 animated:YES];
}


@end
