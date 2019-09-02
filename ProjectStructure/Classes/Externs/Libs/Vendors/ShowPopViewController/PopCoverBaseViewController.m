//
//  PopCoverBaseViewController.m
//  BottomPopController
//
//  Created by mac on 2018/11/7.
//  Copyright © 2018 healifeGroup. All rights reserved.
//

#import "PopCoverBaseViewController.h"
#import <Masonry.h>

@interface PopCoverBaseViewController ()

@property (nonatomic,strong) UIButton *bgButton;

@end

@implementation PopCoverBaseViewController

-(instancetype)init{
    if (self = [super init]) {
        self.providesPresentationContextTransitionStyle = YES;
        self.definesPresentationContext = YES;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self showContentView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [self.view addSubview:self.bgButton];
    
    if (self.contentView == nil) {
        NSLog(@"----- 弹窗视图传值不能为nil ----");
        return;
    }
    
    [self.view addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(self.contentViewHeight);
        make.height.mas_equalTo(self.contentViewHeight);
    }];
    
    [self contentViewClickEventHandler];
}

-(void)setMaskBgColor:(UIColor *)maskBgColor{
    _maskBgColor = maskBgColor;
    self.bgButton.backgroundColor = maskBgColor;
}

-(void)contentViewClickEventHandler{
    ///Example: 子类需x重写
    //    PopContentView *contentView = (PopContentView *)self.contentView;
    //    __weak typeof(self) weakSelf = self;
    //    contentView.cancelBtnActionBlock = ^(UIButton * _Nonnull sender) {
    //        [weakSelf dismissContentView];
    //    };
}

-(void)showContentView{
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bgButton.alpha = 1.0;
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        if (self.showContentViewCompletedBlock) {
            self.showContentViewCompletedBlock(self);
        }
    }];
}

-(void)dismissContentView{
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(self.contentViewHeight);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bgButton.alpha = 0.0;
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
        if (self.dismissContentViewCompletedBlock) {
            self.dismissContentViewCompletedBlock(self);
        }
    }];
}

-(void)dismissPopCover:(UIButton *)sender{
    [self dismissContentView];
}

-(UIButton *)bgButton{
    if (_bgButton == nil) {
        _bgButton = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [_bgButton addTarget:self action:@selector(dismissPopCover:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgButton;
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
