//
//  UIView+Tap.m
//  WealthCloud
//
//  Created by fanxiaobin on 2017/4/14.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import "UIView+Tap.h"

@implementation UIView (Tap)

-(void)addTarget:(id)target selector:(SEL)selector{
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
}

-(void)addTarget:(id)target selector:(SEL)selector tag:(NSInteger)tag{
    
    [self addTarget:target selector:selector];
    self.tag = tag;
}

@end
