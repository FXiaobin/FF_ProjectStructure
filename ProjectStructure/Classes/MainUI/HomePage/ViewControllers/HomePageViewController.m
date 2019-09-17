//
//  HomePageViewController.m
//  ProjectStructure
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "HomePageViewController.h"

#import "CommonRequest.h"
#import "UserData.h"

#import "CommonUtils.h"

#import "NewPeopleGuide.h"

#import "WelcomPageSwitchViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kRandomColor;
    
//    [CommonRequest deleteMyVideoRequestWithVideoId:@"21" success:^(id  _Nonnull responseObject) {
//
//    } failuer:^(NSError * _Nonnull error) {
//
//    }];
//
//    NSString *url = YHBAppStoreUrl;
//    DDLog(@"url = %@",url);
    
    
    NSDictionary *dic = @{
                          @"userId" : @"12",
                          @"username" : @"一个好人",
                          @"phoneNumber" : @"13626273847",
                          @"userPic" : @"default",
                          @"sex" : @"男",
                          @"city" : @"上海",
                          @"extra" : @{@"test" : @"hhhhh"}
                    
                          };
    UserData *user = [UserData saveModelWithUsersDic:dic];
   // DDLog(@"");
    
    user.sex = @"女";
    user.city = @"北京";
    UserData *newuser= [UserData updateUserModelWithNewModel:user];
   DDLog(@"username = %@",newuser.username);
    
    
    [[AdLaunchManager shareManagre] showAdLaunchImageViewWithUrl:@"http://img1.imgtn.bdimg.com/it/u=3199370898,1904291699&fm=11&gp=0.jpg" countDownType:AdLaunchManagerCountDownType_RoundBackProgress completed:^{
       
        DDLog(@" ------ 广告页面消失 ----- ");
        
        [WelcomPageSwitchViewController showWelcomPageSwitchViewControllerWithGuideImages:@[@"guide_01",@"guide_02",@"guide_03",@"guide_04"] completed:^{
            DDLog(@" ------ 欢迎滚动视图消失 ----- ");
            
            [NewPeopleGuide showNewPeopleGuideWithType:NewPeopleGuideType_Home];
        }];

        
    }];
    
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
