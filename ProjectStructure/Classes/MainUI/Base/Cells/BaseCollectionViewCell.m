//
//  BaseCollectionViewCell.m
//  FFWisdomSchool
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface BaseCollectionViewCell ()


@property (nonatomic,strong) UIImageView *sepratorLine;


@end

@implementation BaseCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(NSString *)identifier{
    return NSStringFromClass([self class]);
}

+(NSString *)identifier{
    return NSStringFromClass([self class]);
}

+(void)registerCellClassWithCollectionView:(UICollectionView *)collectionView{
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:[self identifier]];
}

+(BaseCollectionViewCell *)dequeueReusableCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    BaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self identifier] forIndexPath:indexPath];
    
    return cell;
}

-(void)setShowSeperatorLine:(BOOL)showSeperatorLine{
    _showSeperatorLine = showSeperatorLine;
    self.sepratorLine.hidden = !showSeperatorLine;
}

///分割线 默认不显示
-(UIImageView *)sepratorLine{
    if (_sepratorLine == nil) {
        _sepratorLine = [UIImageView new];
        _sepratorLine.backgroundColor = kSeperatorColor;
        _sepratorLine.hidden = YES;
        [self.contentView addSubview:_sepratorLine];
        [_sepratorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _sepratorLine;
}

@end
