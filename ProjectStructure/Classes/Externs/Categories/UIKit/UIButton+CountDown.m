//
//  UIButton+CountDown.m
//  fff
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "UIButton+CountDown.h"

@implementation UIButton (CountDown)

- (void)countDownWithTitle:(NSString *)title second:(NSInteger)second{

    __block NSInteger sec = second;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
      
        if (sec <= 0) {
            //倒计时结束，关闭
            dispatch_source_cancel(timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
            
        }else{
            
            NSString *strTime = [NSString stringWithFormat:@"%02ld", sec];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                
            });
            
            sec--;
        }
    });
    dispatch_resume(timer);
    
}

@end
