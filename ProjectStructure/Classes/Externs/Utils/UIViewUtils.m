//
//  UIViewUtils.m
//  dfds
//
//  Created by fanxiaobin on 17/3/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "UIViewUtils.h"
#import <MJRefresh/MJRefresh.h>
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@implementation UIViewUtils

+ (void)addTarget:(id)target selector:(SEL)selector forView:(UIView *)aView{
    aView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:@selector(selector)];
    [aView addGestureRecognizer:tap];
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)alignment font:(UIFont *)font numberOfLines:(NSInteger)lines{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.textAlignment = alignment;
    label.font = font;
    label.numberOfLines = lines;
    
    return label;
}

+ (UIButton *)createButtomWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)sel{
    
    UIButton *aButton = [[UIButton alloc] initWithFrame:frame];
    [aButton setTitleColor:titleColor forState:UIControlStateNormal];
    [aButton setTitle:title forState:UIControlStateNormal];
    aButton.titleLabel.font = font;
    [aButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return aButton;
}

+ (UIButton *)createButtomWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)sel tag:(NSInteger)tag{
    
    UIButton *aButton = [self createButtomWithFrame:frame title:title titleColor:titleColor font:font target:target action:sel];
    aButton.tag = tag;
    
    return aButton;
}

+ (UIButton *)createButtomWithFrame:(CGRect)frame backgroundImage:(NSString *)imageName target:(id)target action:(SEL)sel{
    UIButton *aButton = [[UIButton alloc] initWithFrame:frame];
    [aButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [aButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return aButton;
}

+ (UIButton *)createButtomWithFrame:(CGRect)frame image:(NSString *)imageName target:(id)target action:(SEL)sel{
    UIButton *aButton = [[UIButton alloc] initWithFrame:frame];
    if ([imageName hasPrefix:@"http"]) {
        [aButton sd_setImageWithURL:[NSURL URLWithString:imageName] forState:UIControlStateNormal];
    }else{
       [aButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal]; 
    }
    
    [aButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    aButton.adjustsImageWhenHighlighted = NO;
    
    return aButton;
}

+ (UIButton *)createButtomWithFrame:(CGRect)frame image:(NSString *)imageName target:(id)target action:(SEL)sel placeholderImage:(NSString *)placeholder{
    UIButton *aButton = [[UIButton alloc] initWithFrame:frame];
    
    [aButton setImage:[UIImage imageNamed:placeholder] forState:UIControlStateNormal];
    if ([imageName hasPrefix:@"http"]) {
        [aButton sd_setImageWithURL:[NSURL URLWithString:imageName] forState:UIControlStateNormal];
    }else{
        [aButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    [aButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return aButton;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName contentMode:(UIViewContentMode)contentModel{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:imageName];
    
    if ([imageName hasPrefix:@"http"] || [imageName hasPrefix:@"https"]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    
    imageView.clipsToBounds = YES;
    imageView.contentMode = contentModel;
    
    return imageView;
}

+ (UITextView *)createTextViewWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor{
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.text = text;
    textView.textColor = textColor;
    
    return textView;
}

+ (UITextField *)createTextFieldWithFrame:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle placeholder:(NSString *)placeholder tintColor:(UIColor *)tintColor{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.tintColor = tintColor;
    textField.placeholder = placeholder;
    textField.borderStyle = borderStyle;
    
    return textField;
}

+ (UITextField *)createTextFieldWithFrame:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle font:(UIFont *)font placeholder:(NSString *)placeholder placeholderColor:(UIColor *)placeholderColor tintColor:(UIColor *)tintColor{
    
    UITextField *tf = [self createTextFieldWithFrame:frame borderStyle:borderStyle placeholder:placeholder tintColor:tintColor];
    tf.textColor = tintColor;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.font = font;
    
    if (placeholderColor) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName : font, NSForegroundColorAttributeName : placeholderColor}];
        tf.attributedPlaceholder = str;
    }
    
    return tf;
}

+ (UITableView *)createTableViewWithFrame:(CGRect)frame target:(id)target style:(UITableViewStyle)style isHeaderRefreshing:(BOOL)isHeaderRefreshing headerRefreshAction:(SEL)headerAction isFooterLoadMore:(BOOL)isFooterLoadMore footerLoadMoreAction:(SEL)footerAction{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    tableView.delegate = target;
    tableView.dataSource = target;
    tableView.tableFooterView = [UIView new];
    
    if (isHeaderRefreshing) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:headerAction];
        header.lastUpdatedTimeLabel.hidden = YES;
        tableView.mj_header = header;
    }
    
    if (isFooterLoadMore) {
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:footerAction];
    }
    
    return tableView;
}


+ (UICollectionView *)createCollectionViewWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout *)layout target:(id)target isHeaderRefreshing:(BOOL)isHeaderRefreshing headerRefreshAction:(SEL)headerAction isFooterLoadMore:(BOOL)isFooterLoadMore footerLoadMoreAction:(SEL)footerAction{
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];;
    collectionView.delegate = target;
    collectionView.dataSource = target;
    
    if (isHeaderRefreshing) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:headerAction];
        header.lastUpdatedTimeLabel.hidden = YES;
        collectionView.mj_header = header;
    }
    
    if (isFooterLoadMore) {
        collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:footerAction];
    }
    
    return collectionView;
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message targetVC:(UIViewController *)targetVC ensureActionTitle:(NSString *)ensureTitle completeBlock:(UIViewUtilsResult)block isShowCancelAction:(BOOL)isShow{
    
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [av addAction:[UIAlertAction actionWithTitle:ensureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block(action);
        }
    }]];
    
    if (isShow) {
        [av addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    }
    
    [targetVC presentViewController:av animated:YES completion:nil];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message targetVC:(UIViewController *)targetVC ensureActionTitle:(NSString *)ensureTitle cancelTitle:(NSString *)cancelTitle cancelBlock:(UIViewUtilsResult)cancelBlock completeBlock:(UIViewUtilsResult)block{
    
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [av addAction:[UIAlertAction actionWithTitle:ensureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block(action);
        }
    }]];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock(action);
        }
    }];
    [cancelAction setValue:kSubTitleColor forKey:@"_titleTextColor"];
    [av addAction:cancelAction];
    
    [targetVC presentViewController:av animated:YES completion:nil];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message targetVC:(UIViewController *)targetVC ensureActionDestructiveTitle:(NSString *)destructiveTitle completeBlock:(UIViewUtilsResult)block isShowCancelAction:(BOOL)isShow{
    
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [av addAction:[UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block(action);
        }
    }]];
    
    if (isShow) {
        [av addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    }
    
    [targetVC presentViewController:av animated:YES completion:nil];
}

+ (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message targetVC:(UIViewController *)targetVC defaultTitleColor:(UIColor *)titleColor actionTitles:(NSArray *)actionTitles completeBlockOne:(UIViewUtilsResult)block1 completeBlockTwo:(UIViewUtilsResult)block2{
    
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
 
    for(int i = 0; i < actionTitles.count; i++){
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (i == 0) {
                block1(action);
                
            }else if (i == 1){
                block2(action);
            }
            
        }];
        
        //修改选项颜色
        if (titleColor) {
            [action setValue:titleColor forKey:@"titleTextColor"];
        }
        
        [av addAction:action];
    }
    
    [av addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [targetVC presentViewController:av animated:YES completion:nil];
   
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message targetVC:(UIViewController *)targetVC ensureActionTitle:(NSString *)ensureTitle placeholder:(NSString *)placeholder completeBlock:(void (^) (UITextField *tf))block isShowCancelAction:(BOOL)isShow{
    
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:ensureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSArray *tfs = av.textFields;
        UITextField *tf = tfs.count ? tfs.lastObject : nil;
        if (block) {
            block(tf);
        }
    }];
    
    [av addAction:action];
    
    [action setValue:kHexColor(0xFF7D01) forKey:@"titleTextColor"];
    
    [av addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholder;
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    if (isShow) {
        [av addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    }
  
    [targetVC presentViewController:av animated:YES completion:nil];
}

@end
