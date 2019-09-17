//
//  AdLaunchManager.h
//  ProjectStructure
//
//  Created by mac on 2019/9/17.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AdLaunchManagerCountDownType) {
    AdLaunchManagerCountDownType_Digital = 0,   //矩形数字
    AdLaunchManagerCountDownType_Round,         //圆形数字
    AdLaunchManagerCountDownType_RoundProgress,  //圆形进度
    AdLaunchManagerCountDownType_RoundBackProgress  //反向圆形进度
};

NS_ASSUME_NONNULL_BEGIN

///广告加载页

@interface AdLaunchManager : UIImageView<CAAnimationDelegate>

@property (nonatomic,assign) AdLaunchManagerCountDownType countDownType;


@property (nonatomic,strong) dispatch_source_t timer;
@property (nonatomic,copy) void (^completed) (void);

@property (nonatomic,strong) UIButton *countDownBtn;


@property (nonatomic,strong) UIBezierPath *bezierPath;
@property (nonatomic,strong) CAShapeLayer *progressLayer;
@property (nonatomic,strong) CAShapeLayer *backProgressLayer;

+ (AdLaunchManager *)shareManagre;

-(void)showAdLaunchImageViewWithUrl:(NSString *)url completed:(dispatch_block_t)completed;
-(void)showAdLaunchImageViewWithUrl:(NSString *)url countDownType:(AdLaunchManagerCountDownType)countDownType;
-(void)showAdLaunchImageViewWithUrl:(NSString *)url countDownType:(AdLaunchManagerCountDownType)countDownType  completed:(dispatch_block_t)completed;

@end

NS_ASSUME_NONNULL_END
