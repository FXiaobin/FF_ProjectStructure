//
//  CommonUtils.h
//  dfds
//
//  Created by fanxiaobin on 17/3/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^resultBlock)(id object);


@interface CommonUtils : NSObject

@property (nonatomic,copy) resultBlock commonUtilsBlock;

+ (CommonUtils *)manager;

///视图边框 圆角 添加点击事件
+ (void)cornerRadius:(CGFloat)cornerRadius forView:(UIView *)aview;

/*
 *单独设置某一个或多个边为圆角 可选值为：
 *UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 */
+ (void)cornersByRounding:(UIRectCorner)rectCorner viewBounds:(CGRect)viewBounds cornerRadius:(CGFloat)cornerRadius  forView:(UIView *)aview;

+ (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor forView:(UIView *)aview;
+ (void)shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)size forView:(UIView *)aview;

///按钮设置默认和选中图片后 点击按钮高亮显示图片错误的修改
+ (void)bttonStateWithButton:(UIButton *)button image:(NSString *)imageName selImage:(NSString *)selImageName;

+ (void)addTarget:(id)target selector:(SEL)selector forView:(UIView *)aView;

///计算文字高度
+ (CGFloat)heightWithText:(NSString *)text textSize:(CGSize)textSize attributes:(NSDictionary *)attributes;

///导航条颜色设置
+ (void)navigationBarSetWithTargetColor:(UIColor *)mainColor;

+ (void)navigationBarDefaultStyleWithNavigationBar:(UINavigationBar *)navigationBar;

+ (void)navigationBarStockStyleWithNavigationBar:(UINavigationBar *)navigationBar;

///属性字符串
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)text color:(UIColor *)color fontSize:(CGFloat)fontSize range:(NSRange)range;
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)text color:(UIColor *)color font:(UIFont *)font range:(NSRange)range;
+ (CGSize)sizeWithContent:(NSString *)content attributed:(NSDictionary *)attributedDic limitedSize:(CGSize)limitSize;
+ (NSAttributedString *)paragraphStyleWithContent:(NSString *)content lineSpacing:(CGFloat)lineSpacing;
+ (NSAttributedString *)paragraphStyleWithContent:(NSString *)content lineSpacing:(CGFloat)lineSpacing textColor:(UIColor *)textColor;
+ (NSAttributedString *)paragraphStyleWithContent:(NSString *)content lineSpacing:(CGFloat)lineSpacing lineHeight:(CGFloat)lineHeight;
+ (NSAttributedString *)paragraphStyleWithContent:(NSString *)content lineSpacing:(CGFloat)lineSpacing text:(NSString *)text textColor:(UIColor *)textColor;

//+(NSString *)removeHtmlString:(NSString *)string;
+(NSString *)removeHtmlAndSpaceString:(NSString *)string;

//NSDate 常用的
+ (NSString *)timeStringGetWithDate:(NSDate *)date;
+ (NSTimeInterval)timeIntervalNowTo1970WithDate:(NSDate *)date;
+ (NSDate *)dateWithTimeDateFormatter:(NSString *)dateStr;
+ (NSString *)timeFormatterStringWithDate:(NSDate *)date dateFormatter:(NSString *)dateFormatter;
+ (NSString *)timeFormatterStringWithTimestamp:(NSTimeInterval)timestamp dateFormatter:(NSString *)dateFormatter;
+ (NSString*)remainingTimeToEndDate:(NSDate *)endDate text:(NSString *)text;
+ (NSInteger)isSalingWithDate:(NSDate *)date;
+ (NSString *)crazyTimeToEndDate:(NSDate *)endDate;


///保存图片到相册
- (void)saveImageToPhotoLibraryWithImage:(UIImage *)image completeBlock:(resultBlock)block;

///搜索历史保存
+ (void)saveSearchString:(NSString *)searchString;
+ (NSArray *)fetchHistorySearchResultArray;
+ (void)clearAllHistorySearchString;


/// 转场动画
+ (void)transationAnimationForViewWithType:(NSString *)type subType:(NSString *)subType forView:(UIView *)aView;

/// 抖动动画
+ (void)shakeAnimationWithAnimationView:(UIView *)animationView;
/// 缩放动画
+ (void)scaleAnimationWithAnimationView:(UIView *)animationView;
/// 旋转动画
+ (void)rotationAnimationWithAnimationView:(UIView *)animationView;


+(UIViewController *)getCurrentViewControllerWithView:(UIView *)aView;

+ (UIViewController *)currentViewController;
+ (UINavigationController *)currentNavigationController;

@end
