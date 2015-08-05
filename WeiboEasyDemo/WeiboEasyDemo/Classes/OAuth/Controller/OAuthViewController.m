//
//  OAuthViewController.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/6/23.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AccountTool.h"

@interface OAuthViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)  NSString *code;
@end

@implementation OAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webview.delegate = self;
    [self.view addSubview:webview];
    /*
     请求地址    @"https://api.weibo.com/oauth2/authorize"
     请求参数
     client_id	true	string	申请应用时分配的AppKey。
     redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     */
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",kAppkey,kRedirectUri];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webview loadRequest:request];

}


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [request.URL absoluteString];
    BWLog(@"request url :%@",urlString);
    NSRange range = [urlString rangeOfString:@"code="];
    if (range.length > 0) {
        self.code = [urlString substringFromIndex:range.length + range.location];
        BWLog(@"code :%@",self.code);
        [self accesstokenWithCode:self.code];
        return NO;
    }
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
//https://api.weibo.com/oauth2/access_token
//lient_id	true	string	申请应用时分配的AppKey。
//client_secret	true	string	申请应用时分配的AppSecret。
//grant_type	true	string	请求的类型，填写authorization_code
//
//grant_type为authorization_code时
//必选	类型及范围	说明
//code	true	string	调用authorize获得的code值。
//redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
- (void)accesstokenWithCode:(NSString *)code
{
    AFHTTPRequestOperationManager *mgr = [[AFHTTPRequestOperationManager alloc] init];
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:kAppkey forKey:@"client_id"];
    [postDic setObject:kAppSecret forKey:@"client_secret"];
    [postDic setObject:@"authorization_code" forKey:@"grant_type"];
    [postDic setObject:code forKey:@"code"];
    [postDic setObject:kRedirectUri forKey:@"redirect_uri"];
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:postDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        Account *account = [Account accountWithDict:responseObject];
        [AccountTool saveAccount:account];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
        BWLog(@"请求成功:%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BWLog(@"请求不成功:%@",error);
    }];
}
@end
