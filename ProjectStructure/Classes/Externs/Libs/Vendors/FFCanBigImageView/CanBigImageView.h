//
//  CanBigImageView.h
//  ClickShowImageViewDemo
//
//  Created by mac on 2018/6/23.
//  Copyright © 2018年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

///点击图片可放大

@interface CanBigImageView : UIImageView

//如果有导航条 这个值要设置为导航条的高度
@property (nonatomic,assign) CGFloat navHeight;

- (void)showBigImageView;

- (void)hiddenBigImageView;

@end
