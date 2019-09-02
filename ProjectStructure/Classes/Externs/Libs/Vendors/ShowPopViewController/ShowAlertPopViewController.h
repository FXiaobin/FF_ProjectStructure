//
//  ShowAlertPopViewController.h
//  BottomPopController
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AlertShowType) {
    kAlertShowTypeFade = 0,
    kAlertShowTypeFadeIn,
    kAlertShowTypeFadeOut,
    kAlertShowTypeSystem,
    kAlertShowTypeBounceIn,
    kAlertShowTypeBounceInScale,
    kAlertShowTypeBounceOut,
    kAlertShowTypeBounceOutScale,
};

typedef NS_ENUM(NSInteger,AlertDismissType) {
    kAlertDismissTypeFade = 0,
    kAlertDismissTypeFadeIn,
    kAlertDismissTypeFadeOut,
    kAlertDismissTypeSystem,
    kAlertDismissTypeBounceIn,
    kAlertDismissTypeBounceOut,
};

NS_ASSUME_NONNULL_BEGIN

/// Alert弹窗

@interface ShowAlertPopViewController : UIViewController

@property (nonatomic,strong) UIView *containerView;
///默认200.0 需要根据重新设置承载视图的高度
@property (nonatomic,assign) CGSize alertViewSize;
@property (nonatomic,strong)  UIColor *maskBgColor;

@property (nonatomic, assign) AlertShowType showType;
@property (nonatomic, assign) AlertDismissType dismissType;

/// Default YES. click background close
@property (nonatomic, assign) BOOL tapClose;

@property (nonatomic,copy) void (^showAlertContentViewCompletedBlock) (ShowAlertPopViewController *showPopViewController);
@property (nonatomic,copy) void (^dismissAlertContentViewCompletedBlock) (ShowAlertPopViewController *showPopViewController);

-(void)showAlertContentView;
-(void)dismissAlertContentView;
-(void)showAlertContentViewWithShowType:(AlertShowType)showType completed:(void (^)(ShowAlertPopViewController *showPopViewController))completed;

-(void)dismissAlertContentViewWithDismissType:(AlertDismissType)dismissType completed:(void (^)(ShowAlertPopViewController *showPopViewController))completed;

@end

NS_ASSUME_NONNULL_END
