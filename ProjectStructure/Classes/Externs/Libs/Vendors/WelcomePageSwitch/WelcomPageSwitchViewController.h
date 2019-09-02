//
//  WelcomPageSwitchViewController.h
//  ProjectStructure
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///滚动引导图

@interface WelcomPageSwitchViewController : UIViewController

@property (nonatomic,copy) void (^accessBtnActionBlock) (UIButton *sender);

+ (void)showWelcomPageSwitchViewControllerWithGuideImages:(NSArray *)images;
+ (void)showWelcomPageSwitchViewControllerWithGuideImages:(NSArray *)images completed:(dispatch_block_t)completed;

@end

NS_ASSUME_NONNULL_END
