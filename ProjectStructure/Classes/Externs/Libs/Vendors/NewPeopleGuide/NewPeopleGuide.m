//
//  NewPeopleGuide.m
//  ProjectStructure
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "NewPeopleGuide.h"

NSString * const NewPeopleGuide_Home = @"NewPeopleGuide_Home";
NSString * const NewPeopleGuide_Second = @"NewPeopleGuide_Second";
NSString * const NewPeopleGuide_Third = @"NewPeopleGuide_Third";
NSString * const NewPeopleGuide_PersonCenter = @"NewPeopleGuide_PersonCenter";

@implementation NewPeopleGuide

+(void)showNewPeopleGuideWithType:(NewPeopleGuideType)type{
    [self showNewPeopleGuideWithType:type toView:nil];
}

+(void)showNewPeopleGuideWithType:(NewPeopleGuideType)type toView:(UIView *)toView{

    if (toView == nil) {
        toView = [UIApplication sharedApplication].keyWindow;
    }

    NSArray *images = nil;
    switch (type) {
        case NewPeopleGuideType_Home:{
            images = @[@"home_guide_01"];
            if (kIsIPhoneX) {
                images = @[@"home_guide_01"];
            }
            if ([[NSUserDefaults standardUserDefaults] objectForKey:NewPeopleGuide_Home]){
                return;
            }
            [[NSUserDefaults standardUserDefaults] setObject:NewPeopleGuide_Home forKey:NewPeopleGuide_Home];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }   break;
            
        case NewPeopleGuideType_Second:{
            images = @[@"meet_guide_01",@"meet_guide_02",@"meet_guide_03"];
            if (kIsIPhoneX) {
                images = @[@"meet_guide_01",@"meet_guide_02",@"meet_guide_03"];
            }
            if ([[NSUserDefaults standardUserDefaults] objectForKey:NewPeopleGuide_Second]){
                return;
            }
            [[NSUserDefaults standardUserDefaults] setObject:NewPeopleGuide_Second forKey:NewPeopleGuide_Second];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }   break;
            
        case NewPeopleGuideType_Third:{
            images = @[@"publish_guide_01"];
            if (kIsIPhoneX) {
                images = @[@"publish_guide_01"];
            }
            if ([[NSUserDefaults standardUserDefaults] objectForKey:NewPeopleGuide_Third]){
                return;
            }
            [[NSUserDefaults standardUserDefaults] setObject:NewPeopleGuide_Third forKey:NewPeopleGuide_Third];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }   break;
            
        case NewPeopleGuideType_PersonCenter:{
            images = @[@"my_guide_01",@"my_guide_02"];
            if (kIsIPhoneX) {
                images = @[@"my_guide_01",@"my_guide_02"];
            }
            if ([[NSUserDefaults standardUserDefaults] objectForKey:NewPeopleGuide_PersonCenter]){
                return;
            }
            [[NSUserDefaults standardUserDefaults] setObject:NewPeopleGuide_PersonCenter forKey:NewPeopleGuide_PersonCenter];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }   break;
            
        default:
            break;
    }
    
    NewPeopleGuide *guide = [[NewPeopleGuide alloc] initWithFrame:[UIScreen mainScreen].bounds];
    guide.images = images;
    [guide createCoverImageView];
    [toView addSubview:guide];

    if (type == NewPeopleGuideType_Home) {
        ///添加新手引导页面的时候 欢迎页面还没有消失 因为欢迎页面还要做一个0.25秒的动画后才会消失
        ///这句代码作用：让新手引导页面添加到滚动欢迎页面的下面 这样滚动欢迎页面就可以做动画了 不然等到滚动欢迎页面结束后再添加新手引导视图则会出现闪动
        [toView insertSubview:guide atIndex:1];
    }
}

-(void)createCoverImageView{
    
//    CGFloat topHeight = 0.0;
//    if (kIsIPhoneX) {
//        topHeight = 44.0;
//    }
//    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), topHeight)];
//    topBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
//    [self addSubview:topBgView];
//
//    self.coverIcon.frame = CGRectMake(0, topHeight, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - kSafeAreaBottomHeight - topHeight);
//    self.coverIcon.image = [UIImage imageNamed:self.images.firstObject];
//    [self addSubview:self.coverIcon];
//
//    if (kIsIPhoneX) {
//        UIView *bottomBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - kSafeAreaBottomHeight, CGRectGetWidth([UIScreen mainScreen].bounds), kSafeAreaBottomHeight)];
//        bottomBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
//        [self addSubview:bottomBgView];
//    }
    
    self.coverIcon.image = [UIImage imageNamed:self.images.firstObject];
    [self addSubview:self.coverIcon];
    
}

-(UIImageView *)coverIcon{
    if (_coverIcon == nil) {
        _coverIcon = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
        _coverIcon.userInteractionEnabled = YES;
        [_coverIcon addGestureRecognizer:tap];
    }
    return _coverIcon;
}

-(void)imageViewTap:(UITapGestureRecognizer *)sender{

    self.index++;
    if (self.index < self.images.count) {
        self.coverIcon.image = [UIImage imageNamed:self.images[self.index]];
    }else{
        [self removeFromSuperview];
    }

    
    

}

@end
