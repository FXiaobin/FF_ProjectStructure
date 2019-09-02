//
//  UIImage+YGExtension.m
//  WealthCloud
//
//  Created by caifumap on 2017/3月/24.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import "UIImage+YGExtension.h"

@implementation UIImage (YGExtension)

// 设置图片为不渲染模式
+ (instancetype)imageWithOriginalName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
}

+ (UIImage *)resizedImage:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

-(UIImage*)scaleToSize:(CGSize)size{
    size = CGSizeMake(size.width  , size.height );
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width , size.height )];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color{
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)roundedRect {
    //
    CGSize size = CGSizeMake(self.size.width, self.size.height);
    //创建图片上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //绘制边框的圆
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
    
    CGContextFillPath(context);
    //设置头像frame
    CGFloat iconW = size.width;
    CGFloat iconH = size.height;
    //绘制圆形头像范围
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, iconW, iconH));
    //剪切可视范围
    CGContextClip(context);
    //绘制头像
    [self drawInRect:CGRectMake(0, 0, iconW, iconH)];
    //取出整个图片上下文的图片
    UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return iconImage;
}

- (UIImage *)circleImage{
    CGSize imageSize = self.size;
    // 开启图形上下文
    UIGraphicsBeginImageContext(imageSize);
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 矩形框
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    // 添加一个圆
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪(裁剪成刚才添加的图形形状)
    CGContextClip(ctx);
    // 往圆上面画一张图片
    [self drawInRect:rect];
    // 获得上下文中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

//对View进行截屏
+(void)screenCutWithView:(UIView *)view successBlock:( void(^)(UIImage * image,NSData * imagedata))block{
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    //2.获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //3.截屏
    [view.layer renderInContext:ctx];
    //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.转化成为Data
    //compressionQuality:表示压缩比 0 - 1的取值范围
    NSData * data = UIImageJPEGRepresentation(newImage, 1);
    //6、关闭上下文
    UIGraphicsEndImageContext();
    //7.回调
    block(newImage,data);
}

//添加水印图片
+ (UIImage *)LX_WaterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect{
    
    if (rect.origin.x == 0 && rect.origin.y == 0 && rect.size.width == 0 && rect.size.height == 0) {
        rect = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    //1.获取图片
    //2.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //3.绘制背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
    
    //4.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}

//裁剪圆形 rect: 从这个范围内裁剪 一般设置为这个image的大小(注意：不是imageView的大小)
+ (UIImage *)LX_ClipCircleImageWithImage:(UIImage *)image circleRect:(CGRect)rect{
    
    if (rect.origin.x == 0 && rect.origin.y == 0 && rect.size.width == 0 && rect.size.height == 0) {
        rect = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.设置剪裁区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    //绘制图片
    [image drawAtPoint:CGPointZero];
    //获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //返回新图片
    return  newImage;
}

//裁剪带边框的圆形图片
+ (UIImage *)LX_ClipCircleImageWithImage:(UIImage *)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderW borderColor:( UIColor *)borderColor{
    
    if (rect.origin.x == 0 && rect.origin.y == 0 && rect.size.width == 0 && rect.size.height == 0) {
        rect = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2、设置边框
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [borderColor setFill];
    [path fill];
    //3、设置裁剪区域
    UIBezierPath * clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.origin.x + borderW , rect.origin.x + borderW , rect.size.width - borderW * 2, rect.size.height - borderW *2)];
    [clipPath addClip];
    //3、绘制图片
    [image drawAtPoint:CGPointZero];
    //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5、关闭上下文
    UIGraphicsEndImageContext();
    //6、返回新图片
    return newImage;
    
}

//裁剪带边框的图片 可设置圆角
+ (UIImage *)LX_ClipImageWithImage:(UIImage *)image roundRect:(CGRect)rect radious:(CGFloat) radious{
    
    if (rect.origin.x == 0 && rect.origin.y == 0 && rect.size.width == 0 && rect.size.height == 0) {
        rect = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2、设置裁剪区域
    //    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radious];
    [path addClip];
    //3、绘制图片
    [image drawAtPoint:CGPointZero];
    //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5、关闭上下文
    UIGraphicsEndImageContext();
    //6、返回新图片
    return newImage;
}


//裁剪带边框的图片 可设置圆角 边框颜色
+(UIImage *)LX_ClipImageRadiousWithImage:(UIImage *)image roundRect:(CGRect)rect radious:(CGFloat)radious borderWith:(CGFloat)borderW borderColor:( UIColor *)borderColor{
    
    if (rect.origin.x == 0 && rect.origin.y == 0 && rect.size.width == 0 && rect.size.height == 0) {
        rect = CGRectMake(0, 0, image.size.width, image.size.height);
    }

    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2、设置边框
    UIBezierPath *path =[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radious];
    [borderColor setFill];
    [path fill];
    
    //3、设置裁剪区域
    UIBezierPath * clipPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.origin.x + borderW , rect.origin.x + borderW , rect.size.width - borderW * 2, rect.size.height - borderW *2) cornerRadius:radious];
    
    [clipPath addClip];
    
    //3、绘制图片
    [image drawAtPoint:CGPointZero];
    //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5、关闭上下文
    UIGraphicsEndImageContext();
    //6、返回新图片
    return newImage;
}

@end
