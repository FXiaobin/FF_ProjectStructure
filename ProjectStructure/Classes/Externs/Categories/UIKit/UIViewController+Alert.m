//
//  UIViewController+Alert.m
//  FFCommonProject
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "UIViewController+Alert.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/UIImage+GIF.h>

#define kHUDDelayTimeInterval     2.0

@implementation UIViewController (Alert)

///加载提示...
-(MBProgressHUD *)showLoadingWithText:(NSString *)text{
    HiddenLoading;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = text;
    hud.label.font = kFont(kSCALE(28.0));
    //默认是菊花加载 MBProgressHUDModeIndeterminate
    //hud.mode = MBProgressHUDModeText;
    
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = kHexColor(0x333333);
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    
    return hud;
}

-(MBProgressHUD *)showLoadingWithText:(NSString *)text imageArray:(NSArray *)imageArray{
    HiddenLoading;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = text;
    hud.label.font = kFont(kSCALE(28.0));
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = kHexColor(0x333333);
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    
    if (imageArray.count > 0) {
        hud.mode = MBProgressHUDModeCustomView;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCALE(80), kSCALE(80))];
        
        NSMutableArray *images = [NSMutableArray array];
        for (NSString *imageName in imageArray) {
            UIImage *image = [UIImage imageNamed:imageName];
            [images addObject:image];
        }
        icon.animationImages = images;
        icon.animationDuration = 3.0;
        icon.animationRepeatCount = CGFLOAT_MAX;
        [icon startAnimating];
        
        hud.customView = icon;
    }
    return hud;
}

-(MBProgressHUD *)showLoadingWithText:(NSString *)text gifImage:(NSString *)gifImageName{
    HiddenLoading;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = text;
    hud.label.font = kFont(kSCALE(28.0));
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = kHexColor(0x333333);
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    
    if (gifImageName.length > 0) {
        hud.mode = MBProgressHUDModeCustomView;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCALE(80), kSCALE(80))];
        NSString *path = [[NSBundle mainBundle] pathForResource:gifImageName ofType:@"gif"];
         NSData *data = [NSData dataWithContentsOfFile:path];
        UIImage *gif = [UIImage sd_imageWithGIFData:data];
        icon.image = gif;
        
        hud.customView = icon;
    }
    return hud;
}


///提示显示
-(MBProgressHUD *)showAlert:(NSString *)text image:(NSString *)imageName{
    return [self showAlert:text image:imageName completeBlock:nil];
}

///提示显示
-(MBProgressHUD *)showAlert:(NSString *)text image:(NSString *)imageName completeBlock:(void(^)(MBProgressHUD *HUD))completeBlock{
  
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = text;
    hud.label.font = kFont(kSCALE(28.0));
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = kHexColor(0x333333);
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    
    if (imageName.length > 0) {
        hud.mode = MBProgressHUDModeCustomView;
        hud.margin = kSCALE(40);    ///内容距离四周的距离
        hud.offset = CGPointMake(0, -kNavigationBarHeight); ///调整hud显示的位置
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCALE(60), kSCALE(60))];
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

- (void)hiddenAllHUD{
    
    NSArray *huds = [self allMBProgressHudOnShowView];
    
    for (MBProgressHUD *hud in huds) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES];
    }
}

///视图上所有的hud
- (NSArray *)allMBProgressHudOnShowView{
    
    NSMutableArray *huds = [NSMutableArray array];
    NSArray *subviews = self.view.subviews;
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:[MBProgressHUD class]]) {
            [huds addObject:aView];
        }
    }
    return huds;
}

@end
