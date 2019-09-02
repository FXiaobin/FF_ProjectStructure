//
//  NewPeopleGuide.h
//  ProjectStructure
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,NewPeopleGuideType) {
    NewPeopleGuideType_Home,
    NewPeopleGuideType_Second,
    NewPeopleGuideType_Third,
    NewPeopleGuideType_PersonCenter
};

NS_ASSUME_NONNULL_BEGIN

/// 新手教程引导图

@interface NewPeopleGuide : UIView


@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) NSArray *images;


@property (nonatomic,strong) UIImageView *coverIcon;

+(void)showNewPeopleGuideWithType:(NewPeopleGuideType)type;
+(void)showNewPeopleGuideWithType:(NewPeopleGuideType)type toView:(UIView *)toView;

@end

NS_ASSUME_NONNULL_END
