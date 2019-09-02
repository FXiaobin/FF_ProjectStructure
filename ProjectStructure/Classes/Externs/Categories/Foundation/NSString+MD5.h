//
//  NSString+MD5.h
//  WealthCloud
//
//  Created by caifumap on 2017/3月/30.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)
// MD5加密
/*
 *由于MD5加密是不可逆的,多用来进行验证
 */
// 32位小写
+(NSString *)MD5ForLower32Bate:(NSString *)str;
// 32位大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
// 16为大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
// 16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str;

@end
