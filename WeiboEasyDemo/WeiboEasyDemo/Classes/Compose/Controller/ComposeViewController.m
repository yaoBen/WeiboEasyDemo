//
//  ComposeViewController.m
//  WeiboEasyDemo
//
//  Created by 姚犇 on 15/7/23.
//  Copyright (c) 2015年 姚犇. All rights reserved.
//

#import "ComposeViewController.h"
#import "AccountTool.h"
#import "EmotionTextView.h"
#import "HttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "ComposeToolBar.h"
#import "ComposePhotosView.h"
#import "EmotionKeyboard.h"
#import "Emotion.h"
@interface ComposeViewController ()<UITextViewDelegate,ComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, weak)  EmotionTextView *textview;
@property (nonatomic, weak)  ComposeToolBar *toolbar;
@property (nonatomic, weak)  ComposePhotosView *photosview;
@property (nonatomic, assign) BOOL isSwitch;
@property (nonatomic, strong)  EmotionKeyboard *eKeyboard;
@end

@implementation ComposeViewController

- (EmotionKeyboard *)eKeyboard
{
    if (!_eKeyboard){
        self.eKeyboard = [[EmotionKeyboard alloc] init];
        self.eKeyboard.width = self.view.width;
        self.eKeyboard.height = 216;
    }
    return _eKeyboard;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置导航栏
    [self setupNav];
    // 设置输入框
    [self setupTextView];
    // 设置工具条
    [self setupToolbar];
    
    // 添加相册
    [self setupPhotosview];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.textview becomeFirstResponder];
}
- (void)setupPhotosview
{
    // 添加图片显示控件
    ComposePhotosView *photosview = [[ComposePhotosView alloc] init];
    photosview.width = self.view.width;
    photosview.height = self.view.height;
//    photosview.backgroundColor = BWRandomColor;
    photosview.y = 150;
    [self.textview addSubview:photosview];
    self.photosview = photosview;
}
- (void)setupToolbar
{
    ComposeToolBar *toolbar = [[ComposeToolBar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.x = 0;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}
/**
 *  设置输入框
 */
- (void)setupTextView
{
    EmotionTextView *textview = [[EmotionTextView alloc] init];
    textview.frame = self.view.bounds;
    textview.alwaysBounceVertical = YES;
    textview.delegate = self;
    textview.placeholder = @"分享新鲜事...";
    textview.font = [UIFont systemFontOfSize:15];
    [textview becomeFirstResponder];
    [self.view addSubview:textview];
    self.textview = textview;
    
    // 文字改变通知
    [kNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textview];
    // 键盘位置改变通知
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // 表情按钮点击通知
    [kNotificationCenter addObserver:self selector:@selector(emotionButtonDidClick:) name:kEmotionDidSelectedNotification object:nil];
    // 删除按钮点击通知
    [kNotificationCenter addObserver:self selector:@selector(deleteButtonDidClick) name:kEmotionDeleteNotification object:nil];
}
/**
 *  监听删除按钮点击
 */
- (void)deleteButtonDidClick
{
    [self.textview deleteBackward];
}
/**
 *  监听表情按钮点击
 *
 *  @param notification
 */
- (void)emotionButtonDidClick:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    Emotion *emotion = userInfo[kEmotionDidSelectedKey];
    [self.textview insertEmotion:emotion];
}
/**
 *  监听键盘位置的改变
 *  UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 352}, {320, 216}},
 *	UIKeyboardCenterEndUserInfoKey = NSPoint: {160, 442},
 *	UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {320, 252}},
 *	UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 316}, {320, 252}},
 *	UIKeyboardAnimationDurationUserInfoKey = 0.25,
 *	UIKeyboardCenterBeginUserInfoKey = NSPoint: {160, 460},
 *	UIKeyboardAnimationCurveUserInfoKey = 7
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    if (self.isSwitch)  return;
    NSDictionary *dict = notification.userInfo;
    double duration = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rect = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        if (rect.origin.y > self.view.height) {// 键盘被隐藏的时候
            self.toolbar.y = self.view.height - self.toolbar.height;
        }else{
            self.toolbar.y = rect.origin.y - self.toolbar.height;
        }
        
    }];
}
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textview.hasText;
}
/**
 *  设置导航栏
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UILabel *titleview = [[UILabel alloc] init];
    NSString *preifix = @"发微博";
    NSString *name = [AccountTool account].name;
    if (name) {
        NSString *str = [NSString stringWithFormat:@"%@\n%@",preifix,name];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
        //    NSTextAttachment *att = [[NSTextAttachment alloc] init];
        //    att.image = [UIImage imageNamed:@"app_01"];
        //    NSAttributedString *str2 = [NSAttributedString attributedStringWithAttachment:att];
        //    [attr appendAttributedString:str2];
        [attr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:preifix]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        //    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[str rangeOfString:name]];
        titleview.attributedText = attr;
        titleview.textAlignment = NSTextAlignmentCenter;
        titleview.width = 150;
        titleview.height = 50;
        titleview.numberOfLines = 0;
        self.navigationItem.titleView = titleview;
    }else{
        self.title = preifix;
    }
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  https://api.weibo.com/2/statuses/update.json
 *  https://upload.api.weibo.com/2/statuses/upload.json
 *  access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 *  status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 *  pic	true	binary	要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
 */
- (void)send
{
    if (self.photosview.photos.count) {
        [self sendWithImage];
    }else{
        [self sendWithoutImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendWithoutImage
{
    Account *account = [AccountTool account];
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:account.access_token forKey:@"access_token"];
    [postDic setObject:self.textview.fullText forKey:@"status"];
    
    [HttpTool post:@"https://api.weibo.com/2/statuses/update.json" parameters:postDic success:^(id json) {
        [MBProgressHUD showSuccess:@"发表成功"];
        BWLog(@"请求成功:%@",json);
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发表不成功"];
        BWLog(@"请求不成功:%@",error);
    }];
}

- (void)sendWithImage
{
    Account *account = [AccountTool account];
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:account.access_token forKey:@"access_token"];
    [postDic setObject:self.textview.text forKey:@"status"];
    
    [HttpTool post:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:postDic constructingBodyWithBlock:^NSData *{
        UIImage *image = self.photosview.photos.firstObject;
        NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
        return imgData;
    }success:^(id json) {
        [MBProgressHUD showSuccess:@"发表成功"];
        BWLog(@"请求成功:%@",json);
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发表不成功"];
        BWLog(@"请求不成功:%@",error);
    }];
//    [mgr POST: parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        UIImage *image = self.photosview.photos.firstObject;
//        NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
//        [formData appendPartWithFileData:imgData name:@"pic" fileName:@"text.jpg" mimeType:@"image/jpeg"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD showSuccess:@"发表成功"];
//        BWLog(@"请求成功:%@",responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"发表不成功"];
//        BWLog(@"请求不成功:%@",error);
//    }];
}
#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - ComposeToolbarDelegate
- (void)composeToolBar:(ComposeToolBar *)toolBar didSelectedButton:(ComposeToolBarButtonType)type
{
    switch (type) {
        case ComposeToolBarButtonTypeCamera:
            [self openCamera];
            break;
        case ComposeToolBarButtonTypePicture:
            [self openPhotoLibrary];
            break;
        case ComposeToolBarButtonTypeMention:
            BWLog(@"--------->@");
            break;
        case ComposeToolBarButtonTypeTrend:
            BWLog(@"--------->#");
            break;
        case ComposeToolBarButtonTypeEmoticon:
            BWLog(@"--------->表情");
            [self switchKeyboard];
            break;
    }
}

- (void)switchKeyboard
{
    if (self.textview.inputView == nil) {
        self.textview.inputView = self.eKeyboard;
        
        self.toolbar.showEmoticonKeyboard = YES;
    }else{
        self.textview.inputView = nil;
        self.toolbar.showEmoticonKeyboard = NO;
    }
    
    self.isSwitch = YES;
    [self.textview endEditing:YES];
     self.isSwitch = NO;
    [UIView animateWithDuration:.25 animations:^{
        [self.textview becomeFirstResponder];
       
    }];
}
- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}
- (void)openPhotoLibrary
{
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosview addPhoto:image];
}
@end
