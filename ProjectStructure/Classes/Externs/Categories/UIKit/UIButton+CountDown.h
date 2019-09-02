//
//  UIButton+CountDown.h
//  fff
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown)

///title：倒计时结束后显示的标题
- (void)countDownWithTitle:(NSString *)title second:(NSInteger)second;

@end
