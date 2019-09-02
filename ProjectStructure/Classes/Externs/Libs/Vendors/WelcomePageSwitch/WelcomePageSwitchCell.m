//
//  WelcomePageSwitchCell.m
//  ProjectStructure
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "WelcomePageSwitchCell.h"

@implementation WelcomePageSwitchCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.accessBtn];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
        
        [self.accessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-80.0);
            make.width.mas_equalTo(120.0);
            make.height.mas_equalTo(40.0);
        }];
        
    }
    return self;
}

-(void)accessBtnAction:(UIButton *)sender{
    if (self.accessBtnActionBlock) {
        self.accessBtnActionBlock(sender);
    }
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
        _imageView.image = kPlaceholderImage;
    }
    return _imageView;
}

-(UIButton *)accessBtn{
    if (_accessBtn == nil) {
        _accessBtn = [[UIButton alloc] init];
        _accessBtn.backgroundColor = kMainColor;
        _accessBtn.clipsToBounds = YES;
        _accessBtn.layer.cornerRadius = 5.0;
        _accessBtn.hidden = YES;
        [_accessBtn setTitle:@"立即体验" forState:UIControlStateNormal];
        [_accessBtn addTarget:self action:@selector(accessBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accessBtn;
}

@end
