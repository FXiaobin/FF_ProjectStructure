//
//  ShowAlertPopViewController.m
//  BottomPopController
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "ShowAlertPopViewController.h"

#define k_ShowAlertWidth  [UIScreen mainScreen].bounds.size.width
#define k_ShowAlertHeight  [UIScreen mainScreen].bounds.size.height

@interface ShowAlertPopViewController ()

@property (nonatomic,strong) UIButton *bgButton;

@end

@implementation ShowAlertPopViewController

-(instancetype)init{
    if (self = [super init]) {
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.tapClose = YES;
        self.showType = kAlertShowTypeSystem;
        self.dismissType = kAlertDismissTypeSystem;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showAlertContentView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.bgButton];
    
    _alertViewSize = CGSizeMake(200.0, 200.0);
    self.containerView.center = self.view.center;
    self.containerView.frame = CGRectMake((k_ShowAlertWidth - _alertViewSize.width)/2.0, (k_ShowAlertHeight - _alertViewSize.height)/2.0, _alertViewSize.width, _alertViewSize.height);
    [self.view addSubview:self.containerView];
    
    /*
     使用方法：
     1. 继承这个类；
     2. 在viewDidLoad中，根据需要重新设置containerView的高度，并将要显示的contentView添加到containerView上
     3. 使用[self presentViewController:vc animated:NO completion:nil];将控制器模态出来即可
     */
    
}

-(void)setAlertViewSize:(CGSize)alertViewSize{
    _alertViewSize = alertViewSize;
    self.containerView.frame = CGRectMake((k_ShowAlertWidth - alertViewSize.width)/2.0, (k_ShowAlertHeight - alertViewSize.height)/2.0, alertViewSize.width, alertViewSize.height);
}

-(void)setMaskBgColor:(UIColor *)maskBgColor{
    _maskBgColor = maskBgColor;
    self.bgButton.backgroundColor = maskBgColor;
}

-(void)showAlertContentView{
    [self showAlertContentViewWithShowType:self.showType completed:^(ShowAlertPopViewController * _Nonnull showPopViewController) {
        
    }];
}

-(void)dismissAlertContentView{
    [self dismissAlertContentViewWithDismissType:self.dismissType completed:^(ShowAlertPopViewController * _Nonnull showPopViewController) {
        
    }];
}

-(void)showAlertContentViewWithShowType:(AlertShowType)showType completed:(void (^)(ShowAlertPopViewController *))completed{
    
    
    self.bgButton.alpha = 0.0;
    self.containerView.alpha = 0.0;
    
    switch (showType) {
        case kAlertShowTypeFade:{
            
            [UIView animateWithDuration:0.25 animations:^{
                self.containerView.transform = CGAffineTransformIdentity;
                self.bgButton.alpha = 1.0;
                self.containerView.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                if (completed) {
                    completed(self);
                }
                if (self.showAlertContentViewCompletedBlock) {
                    self.showAlertContentViewCompletedBlock(self);
                }
            }];
            
        } break;
            
        case kAlertShowTypeSystem:{
            self.containerView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            
            [UIView animateWithDuration:0.30 delay:0.1 usingSpringWithDamping:0.8 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveLinear animations:^{
                
                self.containerView.transform = CGAffineTransformIdentity;
                self.bgButton.alpha = 1.0;
                self.containerView.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                if (completed) {
                    completed(self);
                }
                if (self.showAlertContentViewCompletedBlock) {
                    self.showAlertContentViewCompletedBlock(self);
                }
            }];
            
        } break;
            
        case kAlertShowTypeFadeIn:{
            
            self.containerView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            
            [UIView animateWithDuration:0.25 animations:^{
                self.containerView.transform = CGAffineTransformIdentity;
                self.bgButton.alpha = 1.0;
                self.containerView.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                if (completed) {
                    completed(self);
                }
                if (self.showAlertContentViewCompletedBlock) {
                    self.showAlertContentViewCompletedBlock(self);
                }
            }];
            
        } break;
            
        case kAlertShowTypeFadeOut:{
            
            self.containerView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            
            [UIView animateWithDuration:0.25 animations:^{
                self.containerView.transform = CGAffineTransformIdentity;
                self.bgButton.alpha = 1.0;
                self.containerView.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                if (completed) {
                    completed(self);
                }
                if (self.showAlertContentViewCompletedBlock) {
                    self.showAlertContentViewCompletedBlock(self);
                }
            }];
            
        } break;
            
        case kAlertShowTypeBounceIn:{
            
            self.containerView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            
            [UIView animateWithDuration:0.30 delay:0.1 usingSpringWithDamping:0.3 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveLinear animations:^{
                
                self.containerView.transform = CGAffineTransformIdentity;
                self.bgButton.alpha = 1.0;
                self.containerView.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                if (completed) {
                    completed(self);
                }
                if (self.showAlertContentViewCompletedBlock) {
                    self.showAlertContentViewCompletedBlock(self);
                }
            }];
            
        } break;
            
        case kAlertShowTypeBounceOut:{
            
            self.containerView.transform = CGAffineTransformMakeScale(0.8, 0.8);

            [UIView animateWithDuration:0.30 delay:0.1 usingSpringWithDamping:0.3 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveLinear animations:^{

                self.containerView.transform = CGAffineTransformIdentity;
                self.bgButton.alpha = 1.0;
                self.containerView.alpha = 1.0;

            } completion:^(BOOL finished) {

                if (completed) {
                    completed(self);
                }
                if (self.showAlertContentViewCompletedBlock) {
                    self.showAlertContentViewCompletedBlock(self);
                }
            }];
     
        } break;
            
        case kAlertShowTypeBounceInScale:{
            
            self.containerView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            
            [UIView animateWithDuration:0.30 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveLinear animations:^{
                
                self.containerView.transform = CGAffineTransformIdentity;
                self.bgButton.alpha = 1.0;
                self.containerView.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                if (completed) {
                    completed(self);
                }
                if (self.showAlertContentViewCompletedBlock) {
                    self.showAlertContentViewCompletedBlock(self);
                }
            }];
            
        } break;
            
        case kAlertShowTypeBounceOutScale:{
            
            self.containerView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            
            [UIView animateWithDuration:0.30 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveLinear animations:^{
                
                self.containerView.transform = CGAffineTransformIdentity;
                self.bgButton.alpha = 1.0;
                self.containerView.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                if (completed) {
                    completed(self);
                }
                if (self.showAlertContentViewCompletedBlock) {
                    self.showAlertContentViewCompletedBlock(self);
                }
            }];
            
        } break;
       
        default:
            break;
    }
}

-(void)dismissAlertContentViewWithDismissType:(AlertDismissType)dismissType completed:(void (^)(ShowAlertPopViewController *))completed{
    
    self.bgButton.alpha = 1.0;
    self.containerView.alpha = 1.0;
    
    switch (dismissType) {
        case kAlertDismissTypeFade:{
            
            [UIView animateWithDuration:0.25 animations:^{
                self.containerView.transform = CGAffineTransformIdentity;
                self.bgButton.alpha = 0.0;
                self.containerView.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                if (completed) {
                    completed(self);
                }
                if (self.dismissAlertContentViewCompletedBlock) {
                    self.dismissAlertContentViewCompletedBlock(self);
                }
            }];
            
        } break;
            
        case kAlertDismissTypeSystem:{
            self.containerView.transform = CGAffineTransformIdentity;
            self.containerView.alpha = 0.0;
            
            [UIView animateWithDuration:0.20 animations:^{
                self.containerView.transform = CGAffineTransformIdentity;
                self.bgButton.alpha = 0.0;
                self.containerView.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                if (completed) {
                    completed(self);
                }
                if (self.dismissAlertContentViewCompletedBlock) {
                    self.dismissAlertContentViewCompletedBlock(self);
                }
            }];
            
        } break;
            
        case kAlertDismissTypeFadeIn:{
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.containerView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                
                self.bgButton.alpha = 0.0;
                self.containerView.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                if (completed) {
                    completed(self);
                }
                if (self.dismissAlertContentViewCompletedBlock) {
                    self.dismissAlertContentViewCompletedBlock(self);
                }
            }];
            
        } break;
            
        case kAlertDismissTypeFadeOut:{
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.containerView.transform = CGAffineTransformMakeScale(1.2, 1.2);
                
                self.bgButton.alpha = 0.0;
                self.containerView.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                if (completed) {
                    completed(self);
                }
                if (self.dismissAlertContentViewCompletedBlock) {
                    self.dismissAlertContentViewCompletedBlock(self);
                }
            }];
            
        } break;
            
        case kAlertDismissTypeBounceIn:{
            
            [UIView animateWithDuration:0.25 animations:^{
                self.containerView.transform = CGAffineTransformMakeScale(1.2, 1.2);
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.25 animations:^{
                    
                    self.containerView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                    
                    self.bgButton.alpha = 0.0;
                    self.containerView.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    [self dismissViewControllerAnimated:NO completion:nil];
                    if (completed) {
                        completed(self);
                    }
                    if (self.dismissAlertContentViewCompletedBlock) {
                        self.dismissAlertContentViewCompletedBlock(self);
                    }
                }];
            }];
         
        } break;
            
        case kAlertDismissTypeBounceOut:{
            
            [UIView animateWithDuration:0.25 animations:^{
                self.containerView.transform = CGAffineTransformMakeScale(0.6, 0.6);
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.25 animations:^{
                    
                    self.containerView.transform = CGAffineTransformMakeScale(1.2, 1.2);
                    
                    self.bgButton.alpha = 0.0;
                    self.containerView.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
            
                    [self dismissViewControllerAnimated:NO completion:nil];
                    if (completed) {
                        completed(self);
                    }
                    if (self.dismissAlertContentViewCompletedBlock) {
                        self.dismissAlertContentViewCompletedBlock(self);
                    }
                }];
            }];
     
        } break;
       
        default:
            break;
    }

}

-(void)dismissPopCover:(UIButton *)sender{
    if (!self.tapClose) {
        return;
    }
    [self dismissAlertContentView];
}

-(UIButton *)bgButton{
    if (_bgButton == nil) {
        _bgButton = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [_bgButton addTarget:self action:@selector(dismissPopCover:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgButton;
}

-(UIView *)containerView{
    if (_containerView == nil) {
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor orangeColor];
    }
    return _containerView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
