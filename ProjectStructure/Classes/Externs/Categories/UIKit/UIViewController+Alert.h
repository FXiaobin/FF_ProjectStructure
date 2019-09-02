//
//  UIViewController+Alert.h
//  FFCommonProject
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HiddenLoading               [self hiddenAllHUD];
#define ShowLoadingHUD              [self showLoadingWithText:nil];
#define ShowLoadingTextHUD(text)    [self showLoadingWithText:text];

#define SuccessAlert(text)          [self showAlert:text image:@"MBProgress_success"];
#define InfoAlert(text)             [self showAlert:text image:@"MBProgress_info"];
#define ErrorAlert(text)            [self showAlert:text image:@"MBProgress_fail"];

@interface UIViewController (Alert)

///加载菊花
-(MBProgressHUD *)showLoadingWithText:(NSString *)text;

///加载自定义图片动画
-(MBProgressHUD *)showLoadingWithText:(NSString *)text imageArray:(NSArray *)imageArray;

-(MBProgressHUD *)showLoadingWithText:(NSString *)text gifImage:(NSString *)gifImageName;

///弹出提示
-(MBProgressHUD *)showAlert:(NSString *)text image:(NSString *)imageName;

///弹出提示 提示消失后有回调通知
-(MBProgressHUD *)showAlert:(NSString *)text image:(NSString *)imageName completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock;

-(void)hiddenAllHUD;

@end
