//
//  AdLaunchManager.m
//  ProjectStructure
//
//  Created by mac on 2019/9/17.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "AdLaunchManager.h"

static NSInteger  second = 5;
static float lineWidth = 2.0f;
#define degreesToRadians(x) ((x) * M_PI / 180.0)

@implementation AdLaunchManager

-(instancetype)init{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor grayColor];

        self.countDownBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 80.0, 30.0 + kIsIPhoneX ? 44 : 0.0, 60.0, 30.0);
        [self addSubview:self.countDownBtn];

    }
    return self;
}

+(AdLaunchManager *)shareManagre{
    static AdLaunchManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AdLaunchManager alloc] init];
    });
    return manager;
}

-(void)showAdLaunchImageViewWithUrl:(NSString *)url completed:(dispatch_block_t)completed{
    [self showAdLaunchImageViewWithUrl:url countDownType:AdLaunchManagerCountDownType_Digital completed:completed];
}

-(void)showAdLaunchImageViewWithUrl:(NSString *)url countDownType:(AdLaunchManagerCountDownType)countDownType{
    [self showAdLaunchImageViewWithUrl:url countDownType:countDownType completed:^{
        
    }];
}

-(void)showAdLaunchImageViewWithUrl:(NSString *)url countDownType:(AdLaunchManagerCountDownType)countDownType completed:(dispatch_block_t)completed{
    self.completed = completed;
    self.countDownType = countDownType;
    
    if (url.length == 0) {
        return;
    }
    
    if (![url hasPrefix:@"http"]) {
        self.image = [UIImage imageNamed:url];
        
    }else{  //默认占位图为启动图
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    if (countDownType == AdLaunchManagerCountDownType_Round || countDownType == AdLaunchManagerCountDownType_RoundProgress || countDownType == AdLaunchManagerCountDownType_RoundBackProgress) {

        CGRect rect = self.countDownBtn.frame;
        rect.origin.x += 20.0;
        rect.size = CGSizeMake(40.0, 40.0);
        self.countDownBtn.frame = rect;
        self.countDownBtn.layer.cornerRadius = rect.size.width / 2.0;
        [self.countDownBtn setTitle:@"跳过" forState:UIControlStateNormal];
        
        if (countDownType == AdLaunchManagerCountDownType_RoundProgress) {
            [self.countDownBtn.layer addSublayer:self.progressLayer];
            return;
        }else if (countDownType == AdLaunchManagerCountDownType_RoundBackProgress) {
            [self.countDownBtn.layer addSublayer:self.backProgressLayer];
            return;
        }
    }
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    self.timer = timer;
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (countDownType == AdLaunchManagerCountDownType_Digital) {
            [self.countDownBtn setTitle:[NSString stringWithFormat:@"跳过%ld",second] forState:UIControlStateNormal];
        
        }else if (countDownType == AdLaunchManagerCountDownType_Round){
            [self.countDownBtn setTitle:[NSString stringWithFormat:@"%ld",second] forState:UIControlStateNormal];
        }
        second--;
        if (second <= 0) {
            //DDLog(@"----广告倒计时结束了 ----");
            [self hiddenAdLaunchWithDelay:1.0];
        }
        
    });
    dispatch_resume(timer);

}

#pragma mark -- CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self hiddenAdLaunchWithDelay:0.25];
    }
    if (self.countDownType == AdLaunchManagerCountDownType_RoundBackProgress) {
        [self.backProgressLayer removeFromSuperlayer];
    }
}


-(void)closeAd:(UIButton *)sender{
    
    [self hiddenAdLaunchWithDelay:0.25];
 
}

-(void)hiddenAdLaunchWithDelay:(CGFloat)delay{
    ///提前完成回调 - 欢迎滚动页面先添加到window的第二层 在广告视图的下面
    if (self.completed) {
        self.completed();
    }
    if (self.timer) {
        dispatch_cancel(self.timer);
    }
    
    [UIView animateWithDuration:0.25 delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(UIButton *)countDownBtn{
    if (_countDownBtn == nil) {
        _countDownBtn = [[UIButton alloc] init];
        [_countDownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countDownBtn.clipsToBounds = YES;
        _countDownBtn.layer.cornerRadius = 5.0;
        _countDownBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _countDownBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _countDownBtn.layer.borderWidth = 1.0;
        _countDownBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_countDownBtn addTarget:self action:@selector(closeAd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _countDownBtn;
}

- (UIBezierPath *)bezierPath {
    if (!_bezierPath) {
        
        CGFloat width = CGRectGetWidth(self.countDownBtn.frame)/2.0f;
        CGFloat height = CGRectGetHeight(self.countDownBtn.frame)/2.0f;
        CGPoint centerPoint = CGPointMake(width, height);
        float radius = CGRectGetWidth(self.countDownBtn.frame)/2.0f - lineWidth;
        
        _bezierPath = [UIBezierPath bezierPathWithArcCenter:centerPoint
                                                     radius:radius
                                                 startAngle:degreesToRadians(-90)
                                                   endAngle:degreesToRadians(270)
                                                  clockwise:YES];
    }
    return _bezierPath;
}

- (CAShapeLayer *)progressLayer {
    
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.countDownBtn.bounds;
        //_progressLayer.frame = CGRectMake(0, 0, 40, 40);
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineWidth = lineWidth;
        _progressLayer.lineCap = kCALineCapRound;
        // 进度条圈进度色
        _progressLayer.strokeColor = [UIColor orangeColor].CGColor;
        _progressLayer.strokeStart = 0.f;
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = second;
        pathAnimation.fromValue = @(0.0);
        pathAnimation.toValue = @(1.0);
        pathAnimation.removedOnCompletion = YES;
        pathAnimation.delegate = self;
        [_progressLayer addAnimation:pathAnimation forKey:nil];
        
        _progressLayer.path = self.bezierPath.CGPath;
    }
    return _progressLayer;
}

- (CAShapeLayer *)backProgressLayer {
    
    if (!_backProgressLayer) {
        _backProgressLayer = [CAShapeLayer layer];
        _backProgressLayer.frame = self.countDownBtn.bounds;
        _backProgressLayer.fillColor = [UIColor clearColor].CGColor;
        _backProgressLayer.lineWidth = lineWidth;
        _backProgressLayer.lineCap = kCALineCapRound;
        // 进度条圈进度色
        _backProgressLayer.strokeColor = [UIColor orangeColor].CGColor;
        //_backProgressLayer.strokeStart = 0.f;
        _backProgressLayer.strokeEnd = 1.0;
        _backProgressLayer.path = self.bezierPath.CGPath;
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = second;
        pathAnimation.fromValue = @(1.0);
        pathAnimation.toValue = @(0.0);
        pathAnimation.removedOnCompletion = YES;
        pathAnimation.delegate = self;
        [_backProgressLayer addAnimation:pathAnimation forKey:nil];
        
        
    }
    return _backProgressLayer;
}

@end
