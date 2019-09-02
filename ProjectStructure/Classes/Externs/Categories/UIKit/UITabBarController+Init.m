//
//  UITabBarController+Init.m
//  FF_CustomBarAppearence
//
//  Created by fanxiaobin on 2017/9/27.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "UITabBarController+Init.h"
//#import "BaseNavigationController.h"

@implementation UITabBarController (Init)

-(void)customNavigationBarAppearence{
   
    [UINavigationBar appearance].barTintColor = kMainColor;
    [UINavigationBar appearance].tintColor = kWhiteColor;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : kFont(17.0), NSForegroundColorAttributeName : kWhiteColor}];
    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].shadowImage = [UIImage new];
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].backIndicatorImage = [UIImage imageNamed:@"nav_back"];
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [UIImage imageNamed:@"nav_back"];
   
    ///TabBar显示设置
    ///去黑线
//    [[UITabBar appearance] setShadowImage:[UIImage new]];
//    [UITabBar appearance].clipsToBounds = YES;
//    [UITabBar appearance].layer.borderWidth = 0.0;
    
    //[self modefyTabBarTopLineBackgroundColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = kMainColor;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : titleHighlightedColor} forState:UIControlStateSelected];
}

- (UINavigationController *)setupViewController:(NSString *)viewControllerClassName title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selImageName{
    
    Class cls = NSClassFromString(viewControllerClassName);
   
    UIViewController *vc = [[cls alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    UIImage *normalImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selImage = [[UIImage imageNamed:selImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selImage];
    item.titlePositionAdjustment = UIOffsetMake(0, -3);
    nc.tabBarItem = item;
    
    return nc;
}

-(void)setupTabBarControllerWithViewControllerNames:(NSArray *)viewControllerNames titles:(NSArray *)titles normalImages:(NSArray *)normalImages selectedImages:(NSArray *)selectedImages{
    
    ///TabBar显示设置
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = kMainColor;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : titleHighlightedColor} forState:UIControlStateSelected];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (int i = 0; i < viewControllerNames.count; i++) {
        NSString *viewControllerClassName = viewControllerNames[i];
        UINavigationController *nc = [self setupViewController:viewControllerClassName title:titles[i] image:normalImages[i] selectedImage:selectedImages[i]];
        [viewControllers addObject:nc];
    }
    self.viewControllers = viewControllers;
    
}

-(void)setupTabBarControllerWithViewControllers:(NSArray *)viewControllers titles:(NSArray *)titles normalImages:(NSArray *)normalImages selectedImages:(NSArray *)selectedImages{
    
    ///TabBar显示设置
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = kMainColor;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : titleHighlightedColor} forState:UIControlStateSelected];
    
    NSMutableArray *aviewControllers = [NSMutableArray array];
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *vc = viewControllers[i];
        
        UIImage *normalImage = [[UIImage imageNamed:normalImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selImage = [[UIImage imageNamed:selectedImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titles[i] image:normalImage selectedImage:selImage];
        item.titlePositionAdjustment = UIOffsetMake(0, -2);
        item.imageInsets = UIEdgeInsetsMake(-2, 0, 0, 0);

        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
        nc.tabBarItem = item;
        
        [aviewControllers addObject:nc];

    }
    self.viewControllers = aviewControllers;
    
}

///修改TabBar顶部分割线颜色
-(void)modefyTabBarTopLineBackgroundColor {
    
    CGRect rect = CGRectMake(0, 0, kScreenWidth, 0.5);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextFillRect(context,rect);//填充框
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.tabBar.shadowImage = img;
    self.tabBar.backgroundImage = [UIImage imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
}

@end
