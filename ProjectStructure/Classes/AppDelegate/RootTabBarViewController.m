//
//  RootTabBarViewController.m
//  FF_CustomBarAppearence
//
//  Created by fanxiaobin on 2017/9/27.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "UITabBarController+Init.h"

#import "HomePageViewController.h"
#import "SecondPartViewController.h"
#import "ThirdPartViewController.h"
#import "PersonCenterViewController.h"

#import "NewPeopleGuide.h"

@interface RootTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavigationBarAppearence];
    
    NSArray *titles = @[@"首页",@"会议",@"发布",@"我的"];
    NSArray *imageArr = @[@"tabBar_home",@"tabBar_meeting",@"tabBar_publish",@"tabBar_personCenter"];
    NSArray *selectImageArr = @[@"tabBar_home_selected",@"tabBar_meeting_selected",@"tabBar_publish_selected",@"tabBar_personCenter_selected"];

    [self setupTabBarControllerWithViewControllers:@[[HomePageViewController new],
                                                     [[SecondPartViewController alloc] init],
                                                     [ThirdPartViewController new],
                                                     [[PersonCenterViewController alloc] init]
                                                     
                                                     ] titles:titles normalImages:imageArr selectedImages:selectImageArr];
    
    self.delegate = self;
    self.selectedIndex = 0;
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSInteger index = tabBarController.selectedIndex;
    switch (index) {
        case 0: {
            //[NewPeopleGuide showNewPeopleGuideWithType:NewPeopleGuideType_Home];
            
        } break;
        case 1: {
            [NewPeopleGuide showNewPeopleGuideWithType:NewPeopleGuideType_Second];
            
        } break;
        case 2: {
            [NewPeopleGuide showNewPeopleGuideWithType:NewPeopleGuideType_Third];
            
        } break;
        case 3: {
            [NewPeopleGuide showNewPeopleGuideWithType:NewPeopleGuideType_PersonCenter];
            
        } break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
