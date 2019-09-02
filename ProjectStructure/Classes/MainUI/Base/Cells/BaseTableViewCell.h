//
//  BaseTableViewCell.h
//  FFCommonProject
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell


@property (nonatomic,strong) NSString *identifier;

+ (NSString *)identifier;

+ (void)registerClassCellWithTableView:(UITableView *)tableView;

+(BaseTableViewCell *)dequeueReusableCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

///设置分割线偏移
- (void)separatorInsetWithTableView:(UITableView *)tableView insets:(UIEdgeInsets)edgeInsets;

@end
