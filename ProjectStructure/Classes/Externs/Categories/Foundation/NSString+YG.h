//
//  NSString+YG.h
//  WealthCloud
//
//  Created by caifumap on 2017/3月/31.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YG)

#pragma mark --- json对象转换

///Object对象 -> Json字符串
+(NSString *)jsonStringWithObject:(id)obj;
///Json字符串 -> NSDictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


#pragma mark --- 文件路径

/// 给当前文件追加文档路径
- (NSString *)cz_appendDocumentDir;

/// 给当前文件追加缓存路径
- (NSString *)cz_appendCacheDir;

/// 给当前文件追加临时路径
- (NSString *)cz_appendTempDir;


#pragma mark --- 正则表达式匹配

///是否是6位数字
- (BOOL)isSixNumber;
///是否是4位数字
- (BOOL)isFourNumber;
///是否是手机号码
- (BOOL)isMobilePhone;
///是否是4位数字
-(BOOL)isCode;
///是否是用户名（3-20字母和数字）
- (BOOL)isUserName;
///是否是昵称
- (BOOL)isNickname;
///是否是密码（6-18字母和数字）
-(BOOL)isPassword;
- (BOOL)isEmailAddress;
-(NSNumber *)asNumber;
- (BOOL)isTelephone;
- (BOOL)isUrl;
///是否是最多两位小数
-(BOOL)isTwoFloat;
///是否是正整数
- (BOOL)isPlusNum;
// 判断是否是身份证号码
+(BOOL)validateIdCard:(NSString *)idCard;

#pragma mark - <Other>
///不区分字母大小写比较
-(BOOL)isSameWithUperOrLowerWordString:(NSString *)otherStr;

@end
