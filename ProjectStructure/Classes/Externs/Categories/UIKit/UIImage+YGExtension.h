//
//  UIImage+YGExtension.h
//  WealthCloud
//
//  Created by caifumap on 2017/3月/24.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YGExtension)

//原图渲染
+ (UIImage *)imageWithOriginalName:(NSString *)imageName;

///根据图片名返回一张能够自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)name;

///裁剪到某个大小
-(UIImage*)scaleToSize:(CGSize)size;

///用颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//这两个方法都是剪裁为圆形image
- (UIImage *)roundedRect;
- (UIImage *)circleImage;

//对View进行截屏
+(void)screenCutWithView:(UIView *)view successBlock:( void(^)(UIImage * image,NSData * imagedata))block;


//添加水印图片
+ (UIImage *)LX_WaterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect;

#pragma mark - <圆形>
//裁剪圆形图片 把image从rect这个范围裁剪一个圆形 rect为CGRectZero时裁剪的是这个image的最大圆
+ (UIImage *)LX_ClipCircleImageWithImage:(UIImage *)image circleRect:(CGRect)rect;

//裁剪带边框的圆形图片
+ ( UIImage *)LX_ClipCircleImageWithImage:(UIImage *)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderW borderColor:( UIColor *)borderColor;

#pragma mark - <圆角>
//裁剪图片自定义圆角
+ (UIImage *)LX_ClipImageWithImage:(UIImage *)image roundRect:(CGRect)rect radious:(CGFloat) radious;

//裁剪带边框的图片 可设置圆角 边框颜色
+(UIImage *)LX_ClipImageRadiousWithImage:(UIImage *)image roundRect:(CGRect)rect radious:(CGFloat)radious borderWith:(CGFloat)borderW borderColor:( UIColor *)borderColor;


@end
