//
//  MBProgressHUD+Alert.m
//  FFCommonProject
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "MBProgressHUD+Alert.h"

#define kHUDDelayTimeInterval     2.0

@implementation MBProgressHUD (Alert)

///提示显示 - 只有文字
+(MBProgressHUD *)showAlert:(NSString *)text toView:(UIView *)toView{
    return [self showAlert:text image:nil toView:toView completeBlock:nil];
}

///提示显示 - 文字、图片
+(MBProgressHUD *)showAlert:(NSString *)text image:(NSString *)imageName toView:(UIView *)toView{
    return [self showAlert:text image:imageName toView:toView completeBlock:nil];
}

///提示显示 - 提示完成后回调通知
+(MBProgressHUD *)showAlert:(NSString *)text image:(NSString *)imageName toView:(UIView *)toView completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock{
    
    if (toView == nil) {
        toView = [UIApplication sharedApplication].keyWindow;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    hud.label.text = text;
    hud.label.font = kFont(kSCALE(28.0));
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = kHexColor(0x333333);
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    
    if (imageName.length > 0) {
        hud.mode = MBProgressHUDModeCustomView;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCALE(80), kSCALE(80))];
        icon.image = [UIImage imageNamed:imageName];
        hud.customView = icon;
        
    }else{
        hud.mode = MBProgressHUDModeText;
    }
    
    //[hud hideAnimated:YES afterDelay:kHUDDelayTimeInterval];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kHUDDelayTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
        
        if (completeBlock) {
            completeBlock(hud);
        }
        
    });
    
    return hud;
}

///加载提示...
+(MBProgressHUD *)showLoadingWithText:(NSString *)text toView:(UIView *)toView{
    if (toView == nil) {
        toView = [UIApplication sharedApplication].keyWindow;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    hud.label.text = text;
    hud.label.font = kFont(kSCALE(28.0));
    //默认是菊花加载 MBProgressHUDModeIndeterminate
    //hud.mode = MBProgressHUDModeText;
    
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = kHexColor(0x333333);
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    
    return hud;
}

+ (void)hiddenHUDWithShowView:(UIView *)showView{
    if (showView == nil) {
        showView = [UIApplication sharedApplication].keyWindow;
    }
    [MBProgressHUD hideHUDForView:showView animated:YES];
}

@end
