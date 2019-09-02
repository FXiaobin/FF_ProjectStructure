//
//  UINavigationController+Extern.m
//  FFCommonProject
//
//  Created by mac on 2018/5/31.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "UINavigationController+Extern.h"

@implementation UINavigationController (Extern)

///导航控制器是否存在某个控制器
- (BOOL)isHasViewControllerWithControllerName:(NSString *)controllerName{
    BOOL isHas = NO;
    Class cls = NSClassFromString(controllerName);
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:cls]) {
            isHas = YES;
            break;
            //return isHas;
        }
    }
    
    return isHas;
}

///根据子控制器名字返回导航控制器中的这个子控制器
-(UIViewController *)childViewControllerWithControllerName:(NSString *)controllerName{
    
    Class cls = NSClassFromString(controllerName);
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:cls]) {
            return vc;
        }
    }
    return nil;
}

@end
