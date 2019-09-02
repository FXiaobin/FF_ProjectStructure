//
//  NSDate+YG.h
//  WealthCloud
//
//  Created by caifumap on 2017/3月/30.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YG)

/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;


///获取某个时间间隔的日期
+ (NSDate *)dateWithTimeInterver:(NSTimeInterval)timerInterval;
///将日期字符串 -> 日期
+ (NSDate *)dateWithDateString:(NSString *)dateString formatterString:(NSString *)formatterStr;
///将日期 -> 字符串 （按照某个格式）
+ (NSString *)formatterStringWithDate:(NSDate *)date formatterString:(NSString *)formatterStr;
///获取某个时间间隔的日期字符串 （按照某个格式）
+ (NSString *)formatterStringWithTimeInterver:(NSTimeInterval)timerInterval formatterString:(NSString *)formatterStr;



@end
