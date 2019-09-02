//
//  UIViewController+WKWebView.m
//  WKWebProgressViewDemo
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 JixinZhang. All rights reserved.
//

#import "UIViewController+WKWebView.h"
#import <objc/runtime.h>

#define kBottomViewTag  4834983

static const char *kWebViewKey = "kWebViewKey";
static const char *kUIProgressViewKey = "kUIProgressViewKey";

@implementation UIViewController (WKWebView)

- (void)createWebView{
    
    ///创建WKWebView
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
    ///监听WKWebView进度
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    ///WKWebView进度条显示
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, 1)];
    progressView.tintColor = [UIColor blueColor];
    [self.view addSubview:progressView];
    
    
    ///关联对象
    objc_setAssociatedObject(self, kWebViewKey, webView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, kUIProgressViewKey, progressView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

///外部调用 加载网页URL
- (void)startLoadWithURL:(NSString *)urlString {
    if (urlString.length == 0) {
        NSLog(@"请输入web网址");
        return;
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.timeoutInterval = 15.0f;
    
    WKWebView *webView = objc_getAssociatedObject(self, kWebViewKey);
    
    [webView loadRequest:request];
}

- (void)hiddenProgressBar:(BOOL)isHidden{
    UIProgressView *progressView = objc_getAssociatedObject(self, kUIProgressViewKey);
    progressView.hidden = isHidden;
    if (!isHidden) {
        //防止progressView被网页挡住
        //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.2倍.
        //progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        [self.view bringSubviewToFront:progressView];
    }else{
        //progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);;
    }
}

///进度条颜色
-(void)progressViewColor:(UIColor *)progressColor{
    UIProgressView *progressView = objc_getAssociatedObject(self, kUIProgressViewKey);
    progressView.tintColor = progressColor;
}

///返回到前一页
- (void)goBack{
    WKWebView *webView = objc_getAssociatedObject(self, kWebViewKey);
    if ([webView canGoBack]) {
        [webView goBack];
    }
}

///进入下一页
- (void)goForward{
    WKWebView *webView = objc_getAssociatedObject(self, kWebViewKey);
    if ([webView canGoForward]) {
        [webView goForward];
    }
}

///重新加载一次
- (void)reload{
    WKWebView *webView = objc_getAssociatedObject(self, kWebViewKey);
    [webView reload];
}

-(void)resetWebViewFrameWihtRect:(CGRect)rect{
    WKWebView *webView = objc_getAssociatedObject(self, kWebViewKey);
    webView.frame = rect;
    
    UIView *bottomView = [self.view viewWithTag:kBottomViewTag];
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame)- 44, CGRectGetWidth(self.view.frame), 44);
}

///底部操作按钮
-(void)showBottomActionButton{
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)- 44, CGRectGetWidth(self.view.frame), 44)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    bottomView.layer.shadowOffset = CGSizeMake(1, -1);
    bottomView.layer.shadowOpacity = 0.5;
    
    bottomView.tag = kBottomViewTag;
    
    NSArray *titles = @[@"<",@">",@"refresh"];
    for (int i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(CGRectGetWidth(self.view.frame)/titles.count * i, 0, CGRectGetWidth(self.view.frame)/titles.count, CGRectGetHeight(bottomView.frame));
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button.tag = 10000 + i;
        [button addTarget:self action:@selector(bottomViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
    }
    
    [self.view addSubview:bottomView];
}

-(void)bottomViewBtnAction:(UIButton *)sender{
    NSInteger index = sender.tag - 10000;
    if (index == 0) {
        [self goBack];
        
    }else if (index == 1) {
        [self goForward];
        
    }else if (index == 2) {
        [self reload];
    }
    
}

#pragma mark - 监听

/*
 *4.在监听方法中获取网页加载的进度，并将进度赋给progressView.progress
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    WKWebView *wkWebView = objc_getAssociatedObject(self, kWebViewKey);
    UIProgressView *progressView = objc_getAssociatedObject(self, kUIProgressViewKey);
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        [self hiddenProgressBar:NO];
        progressView.progress = wkWebView.estimatedProgress;
        
        
        if (progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            [UIView animateWithDuration:0.2f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                //progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            } completion:^(BOOL finished) {
                [self hiddenProgressBar:YES];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - <WKWKNavigationDelegate Methods>

/*
 *5.在WKWebViewd的代理中展示进度条，加载完成后隐藏进度条
 */

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    //开始加载网页 显示progressView
    [self hiddenProgressBar:NO];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成需要隐藏progressView
    [self hiddenProgressBar:YES];
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    [self hiddenProgressBar:YES];
}

//页面跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //允许页面跳转
    //NSLog(@"%@",navigationAction.request.URL);
    decisionHandler(WKNavigationActionPolicyAllow);
}



@end
