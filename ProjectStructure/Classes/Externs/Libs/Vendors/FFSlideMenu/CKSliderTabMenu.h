//
//  CKSliderTabMenu.h
//  CKSlideMenu-OC
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 caike. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  在CKSlideMenu库的基础上修订的  只是头部菜单选择 不包含下面的控制器
 */

@class CKSliderTabMenu;

@protocol CKSliderTabMenuDelegate <NSObject>

- (void)CKSliderTabMenu:(CKSliderTabMenu *)sliderMenu didSelectedIndex:(NSInteger)index;

@end

typedef NS_ENUM(NSInteger,kSlideMenuTitleStyle){
    kSlideMenuTitleStyleNormal,           //默认 无效果
    kSlideMenuTitleStyleGradient,         //颜色渐变
    kSlideMenuTitleStyleTransfrom,        //放大
    kSlideMenuTitleStyleAll               //颜色渐变+放大
};

typedef NS_ENUM(NSInteger,kSlideMenuIndicatorStyle){
    kSlideMenuIndicatorStyleNormal,          //默认
    kSlideMenuIndicatorStyleFollowText,      //跟随文本长度
    kSlideMenuIndicatorStyleStretch          //伸缩
};

@interface CKSliderTabMenu : UIView

@property (nonatomic,weak) id <CKSliderTabMenuDelegate> delegate;

/** title风格 */
@property (nonatomic,assign) kSlideMenuTitleStyle titleStyle;

/** indicator风格 */
@property (nonatomic,assign) kSlideMenuIndicatorStyle indicatorStyle;
/** 菜单是否固定  默认不固定  固定会平分*/
@property (nonatomic,assign)BOOL isFixed;

/** 是否懒加载自控制器 */
@property (nonatomic,assign)BOOL lazyLoad;

/** 选中颜色 */
@property (nonatomic,strong)UIColor *selectedColor;

/** 未选中颜色 */
@property (nonatomic,strong)UIColor *unselectedColor;

/** 菜单字体 */
@property (nonatomic,strong)UIFont *font;

/** item文字边距 */  /*modefiy*/
@property (nonatomic,assign)CGFloat itemPadding;

/** 下标宽度 */
@property (nonatomic,assign)CGFloat indicatorWidth;

/** 下标高度 */
@property (nonatomic,assign)CGFloat indicatorHeight;

/** 下标颜色 默认为选中颜色*/
@property (nonatomic,strong)UIColor *indicatorColor;

/** 下标距离底部偏移量 */
@property (nonatomic,assign)CGFloat indicatorOffsety;

/** 下标伸缩动画的偏移量 SlideMenuIndicatorStyleStretch生效 */
@property (nonatomic,assign)CGFloat indicatorAnimatePadding;

/** bodyScrollView的父视图 默认为SlideMenu的父视图*/
@property (nonatomic,weak)UIView *bodySuperView;

/** 是否显示分割线 */
@property (nonatomic,assign)BOOL showLine;

/** 是否显示下标 默认显示*/
@property (nonatomic,assign)BOOL showIndicator;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;


/**
 刷新数据
 
 @param titles 标题数组
 @param index 显示位置
 */
- (void)reloadTitles:(NSArray *)titles atIndex:(NSInteger)index;

/**
 滚动到对应位置
 
 @param toIndex 需要显示的位置
 */
- (void)scrollToIndex:(NSInteger)toIndex;


@end
