//
//  UIViewController+WKWebView.h
//  WKWebProgressViewDemo
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 JixinZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface UIViewController (WKWebView)<WKUIDelegate,WKNavigationDelegate>

///创建WKWebView对象
- (void)createWebView;

///加载网页URL
- (void)startLoadWithURL:(NSString *)urlString;

///显示和隐藏进度条 外部重写代理方法时需要调用
- (void)hiddenProgressBar:(BOOL)isHidden;

///更改进度条颜色
- (void)progressViewColor:(UIColor *)progressColor;


- (void)goBack;
- (void)goForward;
- (void)reload;

- (void)showBottomActionButton;

///更新webView的frame
- (void)resetWebViewFrameWihtRect:(CGRect)rect;

@end
