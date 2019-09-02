//
//  BaseWebViewController.m
//  JinGuFinance
//
//  Created by IOS开发 on 2018/4/10.
//  Copyright © 2018年 JinGuCaiJing. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()

@end

@implementation BaseWebViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self.navigationController setToolbarHidden:YES];
    UIProgressView *progressView = [self valueForKey:@"progressView"];
    progressView.progressTintColor = [UIColor whiteColor];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES];
}

-(instancetype)initWithURLString:(NSString *)urlStr{
    if (self = [super initWithURL:[NSURL URLWithString:urlStr]]) {
        self.hidesBottomBarWhenPushed = YES;
        
        self.supportedWebActions = DZNWebActionNone;
        self.supportedWebNavigationTools = DZNWebNavigationToolNone;
        self.showLoadingProgress = YES;
        self.showPageTitleAndURL = NO;
        self.hideBarsWithGestures = NO;
        self.allowHistory = NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.navTitle ? self.navTitle : @"";
   
    /*
     * 继承的这个库有病 设置了self.view = self.webView; 这个地方会调用两次 第一次self.webView=nil
     * 第二次才有值 并且MBProgressHUD的显示也出现了错误，所以这里要判断
     */
   
    if (self.webView) {
        
        self.webView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kSafeAreaBottomHeight);
    }

}

- (void)webView:(DZNWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [super webView:webView didStartProvisionalNavigation:navigation];
  
     ShowLoadingTextHUD(@"加载中...");
}

- (void)webView:(DZNWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    [super webView:webView didCommitNavigation:navigation];
}

- (void)webView:(DZNWebView *)webView didUpdateProgress:(CGFloat)progress{
    [super webView:webView didUpdateProgress:progress];
}

- (void)webView:(DZNWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [super webView:webView didFinishNavigation:navigation];
    HiddenLoading;
}

- (void)webView:(DZNWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [super webView:webView didFailNavigation:navigation withError:error];
    HiddenLoading;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
