//
//  BaseViewController.m
//  GuXuanTangAPP
//
//  Created by IOS开发 on 2018/1/16.
//  Copyright © 2018年 YuanHui. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(UIView *)topXBar{
    if (_topXBar == nil) {
        _topXBar = [UIView new];
        _topXBar.backgroundColor = kMainColor;
    }
    return _topXBar;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [NetWorkRequest networkReachabilityStopMonitoring];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBgColor;
    
    
    
    //默认禁掉 不然一些第三方控件会出现问题（如SZTextView的占位文字会偏移）
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [self.view addSubview:self.topXBar];
    
    [self.topXBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        self.topXBarHeightConstraint = make.height.mas_equalTo(0.0);
    }];
    
    [self networkReachabilityStatus];

}

- (void)networkReachabilityStatus{
    
    [NetWorkRequest networkReachabilityStatusMonitoring:^(AFNetworkReachabilityStatus netStatus) {
        switch (netStatus) {
            case AFNetworkReachabilityStatusUnknown: {
                DDLog(@"---- 未知网络 ---");
            } break;
            case AFNetworkReachabilityStatusNotReachable: {
                DDLog(@"---- 无网络 ---");
            } break;
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                DDLog(@"---- WiFi网络 ---");
              
            } break;
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                DDLog(@"---- 移动网络 ---");
              
            } break;
                
            default:
                break;
        }
    }];
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
