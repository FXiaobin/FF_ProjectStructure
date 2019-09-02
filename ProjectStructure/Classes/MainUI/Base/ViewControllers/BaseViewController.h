//
//  BaseViewController.h
//  GuXuanTangAPP
//
//  Created by IOS开发 on 2018/1/16.
//  Copyright © 2018年 YuanHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

///用来控制iPhone X无导航情况状态栏的显示 默认高度为0.0 默认为主色
@property (nonatomic,strong) UIView *topXBar;
@property (nonatomic,strong) MASConstraint *topXBarHeightConstraint;

@end
