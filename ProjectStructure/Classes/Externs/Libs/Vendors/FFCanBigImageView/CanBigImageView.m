//
//  CanBigImageView.m
//  ClickShowImageViewDemo
//
//  Created by mac on 2018/6/23.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import "CanBigImageView.h"

#define kMainWidth       [UIScreen mainScreen].bounds.size.width
#define kMainHeight     [UIScreen mainScreen].bounds.size.height


@interface CanBigImageView ()<UIScrollViewDelegate>

@property (nonatomic,assign) BOOL isBig;

@property (nonatomic,assign) CGRect originRect;


@property (nonatomic,strong) UIView *bgMaskView;


@property (nonatomic,strong) UIScrollView *bgScrollView;


@property (nonatomic,strong) UIImageView *imageView;


@end

@implementation CanBigImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
       
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        CGRect orginRect = [window convertRect:self.frame toView:window];
        self.originRect = orginRect;
        
    }
    return self;
}

-(void)setNavHeight:(CGFloat)navHeight{
    _navHeight = navHeight;
    CGRect orginRect = self.originRect;
    orginRect.origin.y += self.navHeight;
    self.originRect = orginRect;
}

-(void)hiddenBigImageView{
    self.isBig = NO;
    
    UIImage *image = self.image;
    CGFloat imageH = kMainWidth * (image.size.height / image.size.width) * 1.0;
   
    CGFloat width = MIN(CGRectGetWidth(self.imageView.frame), CGRectGetHeight(self.imageView.frame));
    
    ///pin手势放大后 再隐藏时需要 恢复到初始位置
    if (self.imageView.frame.size.width >= [UIScreen mainScreen].bounds.size.width) {
        self.bgScrollView.contentSize = [UIScreen mainScreen].bounds.size;
        width = MIN(kMainWidth, imageH);
    }
    
    self.imageView.frame = CGRectMake(0, (kMainHeight - width) / 2.0, width, width);
    self.imageView.center = self.bgScrollView.center;
    
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.cornerRadius = width / 2.0;
    
    [UIView animateWithDuration:0.3 animations:^{
       
        self.imageView.center = CGPointMake(CGRectGetMidX(self.originRect), CGRectGetMidY(self.originRect) );
        self.imageView.frame = self.originRect;
        
        self.bgMaskView.alpha = 0.0;
        
        self.imageView.layer.cornerRadius = CGRectGetWidth(self.originRect) / 2.0;
      
    } completion:^(BOOL finished) {
        self.bgScrollView.alpha = 0.0;
        [self.imageView removeFromSuperview];
        [self.bgScrollView removeFromSuperview];
        self.imageView = nil;
        self.bgMaskView = nil;
        self.bgScrollView = nil;
    }];
}

- (void)showBigImageView{
    
    self.isBig = YES;
    
    UIImage *image = self.image;
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = image;
    imageView.frame = self.originRect;
    imageView.backgroundColor = [UIColor purpleColor];
    imageView.userInteractionEnabled = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [imageView addGestureRecognizer:tap];
    
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
    [imageView addGestureRecognizer:pin];
    
    self.imageView = imageView;
    
    CGFloat imageH = kMainWidth * (image.size.height / image.size.width) * 1.0;
    CGRect nowRect = CGRectMake(0, (kMainHeight - imageH) / 2.0, kMainWidth, imageH);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.bgMaskView];
    [window addSubview:self.bgScrollView];
    [self.bgScrollView addSubview:self.imageView];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.imageView.frame = nowRect;
        self.bgMaskView.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)tapAction:(UITapGestureRecognizer *)sender{
    
    self.isBig = !self.isBig;
   
    if (self.isBig) {
        
        [self showBigImageView];
        
    }else{
        
        [self hiddenBigImageView];
    }
}

-(void)pinAction:(UIPinchGestureRecognizer *)ges{
    UIImageView *imageView = (UIImageView *)ges.view;
    
    if (self.isBig) {
        
        UIImage *image = self.image;
        CGFloat imageH = kMainWidth * (image.size.height / image.size.width) * 1.0;
        CGRect nowRect = CGRectMake(0, (kMainHeight - imageH) / 2.0, kMainWidth, imageH);
        
        CGFloat width = kMainWidth * ges.scale;
        
        nowRect.size = CGSizeMake(width, imageH * ges.scale);
        imageView.frame = nowRect;
       
        imageView.center = self.bgScrollView.center;
        
        CGFloat contentH = imageH * ges.scale * 1.05;
        if (contentH < [UIScreen mainScreen].bounds.size.height) {
            contentH = [UIScreen mainScreen].bounds.size.height;
        }
        
        self.bgScrollView.contentSize = CGSizeMake(width * 1.05, contentH);

    }
}

-(UIScrollView *)bgScrollView{
    if (_bgScrollView == nil) {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgScrollView.backgroundColor = [UIColor clearColor];
        _bgScrollView.contentSize = [UIScreen mainScreen].bounds.size;
        _bgScrollView.delegate = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_bgScrollView addGestureRecognizer:tap];
    }
    return _bgScrollView;
}

-(UIView *)bgMaskView{
    if (_bgMaskView == nil) {
        _bgMaskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgMaskView.backgroundColor = [UIColor blackColor];
        _bgMaskView.alpha = 0.0;
    }
    return _bgMaskView;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGPoint center = CGPointMake(self.bgScrollView.contentSize.width / 2.0, self.bgScrollView.contentSize.height / 2.0);
    self.imageView.center = center;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

@end
