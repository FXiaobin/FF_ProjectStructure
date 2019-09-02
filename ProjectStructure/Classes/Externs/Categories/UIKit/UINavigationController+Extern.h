//
//  UINavigationController+Extern.h
//  FFCommonProject
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Extern)

///导航控制器是否存在某个控制器
- (BOOL)isHasViewControllerWithControllerName:(NSString *)controllerName;

///根据子控制器名字返回导航控制器中的这个子控制器
-(UIViewController *)childViewControllerWithControllerName:(NSString *)controllerName;


@end
