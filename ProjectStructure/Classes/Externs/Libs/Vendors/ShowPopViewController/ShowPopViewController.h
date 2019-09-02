//
//  ShowPopViewController.h
//  BottomPopController
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ShowPopContentViewDirectionType) {
    kShowPopContentViewDirectionTypeBottom = 0,
    kShowPopContentViewDirectionTypeLeft,
    kShowPopContentViewDirectionTypeTop,
    kShowPopContentViewDirectionTypeRight,
};

/// 上下左右弹出

NS_ASSUME_NONNULL_BEGIN

@interface ShowPopViewController : UIViewController

@property (nonatomic,strong) UIView *containerView;
///默认200.0 需要根据重新设置承载视图的高度
@property (nonatomic,assign) CGFloat containerViewHeight;
///默认200.0 需要根据重新设置承载视图的高度
@property (nonatomic,assign) CGFloat containerViewWidth;

@property (nonatomic,strong)  UIColor *maskBgColor;
/// Default YES. Set ContentView show animation.
@property (nonatomic, assign) BOOL showAnimated;
/// Default YES. click background close
@property (nonatomic, assign) BOOL tapClose;

@property (nonatomic,assign) ShowPopContentViewDirectionType directionType;

@property (nonatomic,copy) void (^showContentViewCompletedBlock) (ShowPopViewController *showPopViewController);
@property (nonatomic,copy) void (^dismissContentViewCompletedBlock) (ShowPopViewController *showPopViewController);

-(void)showContentViewWithAnimation:(BOOL)animation;
-(void)dismissContentViewWithAnimation:(BOOL)animation;
//-(void)showContentViewWithAnimation:(BOOL)animation completed:(void (^)(ShowPopViewController *showPopViewController))completed;
//-(void)dismissContentViewWithAnimation:(BOOL)animation completed:(void (^)(ShowPopViewController *showPopViewController))completed;



@end

NS_ASSUME_NONNULL_END
