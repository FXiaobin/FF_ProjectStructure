//
//  BaseTableViewCell.m
//  FFCommonProject
//
//  Created by mac on 2018/6/6.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell ()


@end

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSString *)identifier{
    return NSStringFromClass([self class]);
}

+(NSString *)identifier{
    return NSStringFromClass([self class]);
}

+ (void)registerClassCellWithTableView:(UITableView *)tableView {
    [tableView registerClass:[self class] forCellReuseIdentifier:[self identifier]];
}

+(BaseTableViewCell *)dequeueReusableCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{

    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)separatorInsetWithTableView:(UITableView *)tableView insets:(UIEdgeInsets)edgeInsets{
    tableView.layoutMargins = edgeInsets;
    self.layoutMargins = edgeInsets;
    tableView.separatorInset = edgeInsets;
    self.separatorInset = edgeInsets;
}




@end
