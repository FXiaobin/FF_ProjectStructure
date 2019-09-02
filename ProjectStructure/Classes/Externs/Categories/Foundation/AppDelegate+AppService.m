//
//  AppDelegate+AppService.m
//  FFCommonProject
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "AppDelegate+AppService.h"

@implementation AppDelegate (AppService)

+ (AppDelegate *)instanceAppDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (UITabBarController *)rootTabBarController{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return (UITabBarController *)app.window.rootViewController;
}

+ (UIViewController *)currentSelectedTabBarItemViewController{
    UITabBarController *rootTabBarController = [self rootTabBarController];
    return rootTabBarController.selectedViewController;
}

///导航控制器 --- 当前页面所属的导航控制器
+(UINavigationController *)currentVisibleNavigationController{
    ///根控制器的几个主页有可能不是导航控制器(这个方法的前提必须是导航控制器)
    UIViewController *vc = [self currentSelectedTabBarItemViewController];
    UINavigationController *currentNC = nil;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        currentNC = (UINavigationController *)vc;
    }
    return currentNC;
}

///导航控制器 --- 当前导航控制器可见的控制器
+ (UIViewController *)visibleViewControllerForNavigationController{
    UINavigationController *nc = [self currentVisibleNavigationController];
    return nc.viewControllers.lastObject;
}

///获取某个试图控制器推出的控制器数组present
+(NSArray *)childViewControllersWithPresentViewController:(UIViewController *)viewController{
    NSMutableArray *viewControllers = [NSMutableArray array];

    //这里要考虑present的情况了
    int i = 1;
    while (i) {
        
        [viewControllers addObject:viewController];
        if (viewController.presentedViewController) {
            viewController = viewController.presentedViewController;
            
        }else{
            i = 0;
        }
    }
    
    return viewControllers;
}


///present类型 -- 返回可见的控制器 viewController:第一次present的控制器
+ (UIViewController *)visibleViewControllerWithPresentViewController:(UIViewController *)viewController{
    int i = 1;
    
    UIViewController *currentVC = viewController;
    
    while (i) {
        if (viewController.presentedViewController) {
            viewController = viewController.presentedViewController;
            
        }else{
            i = 0;
            currentVC = viewController;
        }
    }
    return currentVC;
}

@end
