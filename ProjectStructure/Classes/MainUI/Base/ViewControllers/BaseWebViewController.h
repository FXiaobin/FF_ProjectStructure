//
//  BaseWebViewController.h
//  JinGuFinance
//
//  Created by IOS开发 on 2018/4/10.
//  Copyright © 2018年 JinGuCaiJing. All rights reserved.
//

#import "DZNWebViewController.h"

@interface BaseWebViewController : DZNWebViewController<DZNNavigationDelegate>

@property (nonatomic,strong) NSString *navTitle;
-(instancetype)initWithURLString:(NSString *)urlStr;

@end
