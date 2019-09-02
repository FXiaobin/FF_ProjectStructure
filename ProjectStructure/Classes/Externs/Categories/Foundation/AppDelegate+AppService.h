//
//  AppDelegate+AppService.h
//  FFCommonProject
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppService)

///AppDelegate实例对象
+ (AppDelegate *)instanceAppDelegate;

///AppDelegate根控制器
+ (UITabBarController *)rootTabBarController;

///tabBar上当前选中的控制器
+ (UIViewController *)currentSelectedTabBarItemViewController;

#pragma mark --- push 导航控制器
///获取当前页面所属的导航控制器
+ (UINavigationController *)currentVisibleNavigationController;

///导航控制器 --- 当前导航控制器可见的控制器
+ (UIViewController *)visibleViewControllerForNavigationController;

#pragma mark --- present 模态
///present类型 -- 获取某个试图控制器present出的控制器数组 viewController:第一次present的控制器
+(NSArray *)childViewControllersWithPresentViewController:(UIViewController *)viewController;

///present类型 -- 返回可见的控制器 viewController:第一次present的控制器
+ (UIViewController *)visibleViewControllerWithPresentViewController:(UIViewController *)viewController;

@end
