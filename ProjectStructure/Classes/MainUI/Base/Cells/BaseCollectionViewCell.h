//
//  BaseCollectionViewCell.h
//  FFWisdomSchool
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell

@property (nonatomic,copy) NSString *identifier;

///是否显示分割线
@property (nonatomic,assign) BOOL showSeperatorLine;

+ (NSString *)identifier;

+ (void)registerCellClassWithCollectionView:(UICollectionView *)collectionView;

+(BaseCollectionViewCell *)dequeueReusableCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;


@end
