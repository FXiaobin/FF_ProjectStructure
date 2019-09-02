//
//  ShowPopViewController.m
//  BottomPopController
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "ShowPopViewController.h"

#define k_ShowPopWidth  [UIScreen mainScreen].bounds.size.width
#define k_ShowPopHeight  [UIScreen mainScreen].bounds.size.height

@interface ShowPopViewController ()

@property (nonatomic,strong) UIButton *bgButton;

@end

@implementation ShowPopViewController

-(instancetype)init{
    if (self = [super init]) {
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.showAnimated = YES;
        self.tapClose = YES;
        self.directionType = kShowPopContentViewDirectionTypeBottom;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ///默认宽度
    if (self.directionType == kShowPopContentViewDirectionTypeLeft || self.directionType == kShowPopContentViewDirectionTypeRight) {
        if (self.containerViewWidth <= 0.0) {
            self.containerViewWidth = 160.0;
        }
        
    }else{
        if (self.containerViewHeight <= 0.0) {
            self.containerViewHeight = 200.0;
        }
    }
    
    [self showContentViewWithAnimation:self.showAnimated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.bgButton];
   
    [self.view addSubview:self.containerView];
    
    /*
     使用方法：
     1. 继承这个类；
     2. 在viewDidLoad中，根据需要重新设置containerView的高度，并将要显示的contentView添加到containerView上
     3. 使用[self presentViewController:vc animated:NO completion:nil];将控制器模态出来即可
    */
    
}

-(void)setContainerViewHeight:(CGFloat)containerViewHeight{
    _containerViewHeight = containerViewHeight;
    
    if (self.directionType == kShowPopContentViewDirectionTypeTop) {
        self.containerView.frame = CGRectMake(0, -containerViewHeight,k_ShowPopWidth , containerViewHeight);
        
    }else if (self.directionType == kShowPopContentViewDirectionTypeBottom) {
        self.containerView.frame = CGRectMake(0, k_ShowPopHeight,k_ShowPopWidth , containerViewHeight);
    }
  
}

-(void)setContainerViewWidth:(CGFloat)containerViewWidth{
    _containerViewWidth = containerViewWidth;
    if (self.directionType == kShowPopContentViewDirectionTypeLeft) {
        self.containerView.frame = CGRectMake(-containerViewWidth, 0,containerViewWidth , k_ShowPopHeight);
        
    }else if (self.directionType == kShowPopContentViewDirectionTypeRight) {
        self.containerView.frame = CGRectMake(k_ShowPopWidth, 0,containerViewWidth , k_ShowPopHeight);
    }
}

-(void)setMaskBgColor:(UIColor *)maskBgColor{
    _maskBgColor = maskBgColor;
    self.bgButton.backgroundColor = maskBgColor;
}

-(void)showContentViewWithAnimation:(BOOL)animation{
    [self showContentViewWithAnimation:animation directionType:self.directionType completed:^(ShowPopViewController *vc) {
        
    }];
}

-(void)dismissContentViewWithAnimation:(BOOL)animation{
    [self dismissContentViewWithAnimation:animation directionType:self.directionType completed:^(ShowPopViewController *vc) {
        
    }];
}

-(void)showContentViewWithAnimation:(BOOL)animation directionType:(ShowPopContentViewDirectionType)directionType completed:(void (^)(ShowPopViewController *vc))completed{
    
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.containerView.frame;
            if (directionType == kShowPopContentViewDirectionTypeTop) {
                frame.origin.y += self.containerView.frame.size.height;
                
            }else if (directionType == kShowPopContentViewDirectionTypeLeft) {
                frame.origin.x += self.containerView.frame.size.width;
                
            }else if (directionType == kShowPopContentViewDirectionTypeBottom) {
                frame.origin.y -= self.containerView.frame.size.height;
                
            }else if (directionType == kShowPopContentViewDirectionTypeRight) {
                frame.origin.x -= self.containerView.frame.size.width;
            }
            self.containerView.frame = frame;
            
            self.bgButton.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            if (completed) {
                completed(self);
            }
            if (self.showContentViewCompletedBlock) {
                self.showContentViewCompletedBlock(self);
            }
        }];
        
    }else{
     
        CGRect frame = self.containerView.frame;
        frame.origin.y -= self.containerView.frame.size.height;
        self.containerView.frame = frame;
        self.bgButton.alpha = 1.0;
        
        if (completed) {
            completed(self);
        }
        if (self.showContentViewCompletedBlock) {
            self.showContentViewCompletedBlock(self);
        }

    }
}

-(void)dismissContentViewWithAnimation:(BOOL)animation directionType:(ShowPopContentViewDirectionType)directionType completed:(void (^)(ShowPopViewController *vc))completed{
   
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.containerView.frame;
            
            if (directionType == kShowPopContentViewDirectionTypeTop) {
                frame.origin.y -= frame.size.height;
                
            }else if (directionType == kShowPopContentViewDirectionTypeLeft) {
                frame.origin.x -= frame.size.width;
                
            }else if (directionType == kShowPopContentViewDirectionTypeBottom) {
                frame.origin.y += frame.size.height;
                
            }else if (directionType == kShowPopContentViewDirectionTypeRight) {
                frame.origin.x += frame.size.width;
            }
            
            self.containerView.frame = frame;
            self.bgButton.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:nil];
            if (completed) {
                completed(self);
            }
            if (self.dismissContentViewCompletedBlock) {
                self.dismissContentViewCompletedBlock(self);
            }
        }];
        
    }else{
        
        CGRect frame = self.containerView.frame;
        frame.origin.y = k_ShowPopHeight;
        self.containerView.frame = frame;
        self.bgButton.alpha = 0.0;
        [self dismissViewControllerAnimated:NO completion:nil];
        
        if (completed) {
            completed(self);
        }
        
        if (self.dismissContentViewCompletedBlock) {
            self.dismissContentViewCompletedBlock(self);
        }
    }
    
}

-(void)dismissPopCover:(UIButton *)sender{
    if (!self.tapClose) {
        return;
    }
    [self dismissContentViewWithAnimation:self.showAnimated];
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
        _containerView.backgroundColor = [UIColor whiteColor];
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
