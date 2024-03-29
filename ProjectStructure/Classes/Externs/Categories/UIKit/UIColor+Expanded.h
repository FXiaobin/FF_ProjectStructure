//
//  UIColor+HexStringToColor.h
//  SmartGate
//
//  Created by fred on 14-8-19.
//  Copyright (c) 2014年 fred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Expanded)

+(UIColor *) hexStringToColor: (NSString *) stringToConvert;
+(UIColor *) hexStringToColor: (NSString *) stringToConvert andAlpha:(CGFloat)alpha;

+(UIColor *)mainColor;

+(UIColor *)defaultBackGroundColor;
+(UIColor *)defaultSeperatorColor;
+(UIColor *)defaultTitleWordColor;
+(UIColor *)defaultContentWordColor;
+(UIColor *)defaultTimeWordColor;

@end
