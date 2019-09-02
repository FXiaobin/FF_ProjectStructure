//
//  UIView+Tap.h
//  WealthCloud
//
//  Created by fanxiaobin on 2017/4/14.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tap)

- (void)addTarget:(id)target selector:(SEL)selector;
-(void)addTarget:(id)target selector:(SEL)selector tag:(NSInteger)tag;

@end
