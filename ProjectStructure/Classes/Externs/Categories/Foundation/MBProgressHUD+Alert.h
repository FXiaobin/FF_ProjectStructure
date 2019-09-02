//
//  MBProgressHUD+Alert.h
//  FFCommonProject
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "MBProgressHUD.h"

#define kMBProgress_successImage @"MBProgress_success"
#define kMBProgress_failImage    @"MBProgress_fail"
#define kMBProgress_infoImage    @"MBProgress_info"

#define HiddenHUDFromView(showView) [MBProgressHUD hiddenHUDWithShowView:showView];

@interface MBProgressHUD (Alert)

+(MBProgressHUD *)showLoadingWithText:(NSString *)text toView:(UIView *)toView;

///提示显示 - 只有文字
+(MBProgressHUD *)showAlert:(NSString *)text toView:(UIView *)toView;

///提示显示 - 文字、图片
+(MBProgressHUD *)showAlert:(NSString *)text image:(NSString *)imageName toView:(UIView *)toView;

///提示显示 - 提示完成后回调通知
+(MBProgressHUD *)showAlert:(NSString *)text image:(NSString *)imageName toView:(UIView *)toView completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock;

+(void)hiddenHUDWithShowView:(UIView *)showView;



@end
