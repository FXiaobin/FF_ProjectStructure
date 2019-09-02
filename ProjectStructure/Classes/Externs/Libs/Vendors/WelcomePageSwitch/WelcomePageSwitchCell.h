//
//  WelcomePageSwitchCell.h
//  ProjectStructure
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WelcomePageSwitchCell : UICollectionViewCell


@property (nonatomic,strong) UIImageView *imageView;


@property (nonatomic,strong) UIButton *accessBtn;

@property (nonatomic,copy) void (^accessBtnActionBlock) (UIButton *sender);

@end

NS_ASSUME_NONNULL_END
