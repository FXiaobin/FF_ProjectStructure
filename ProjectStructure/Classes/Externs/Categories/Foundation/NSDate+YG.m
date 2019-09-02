//
//  NSDate+YG.m
//  WealthCloud
//
//  Created by caifumap on 2017/3月/30.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import "NSDate+YG.h"

@implementation NSDate (YG)
/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}
/**
 *  是否为昨天
 */
-(BOOL)isYesterday{
    NSDate* nowDate = [[NSDate date]dateWithYMD];
    NSDate * selfDate = [self dateWithYMD];
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}
-(NSDate*)dateWithYMD{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    
    return [fmt dateFromString:selfStr];
}
/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

- (NSDateComponents *)deltaWithNow{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

///获取某个时间间隔的日期
+ (NSDate *)dateWithTimeInterver:(NSTimeInterval)timerInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timerInterval/1000.0];
    return date;
}

///将日期字符串 -> 日期
+ (NSDate *)dateWithDateString:(NSString *)dateString formatterString:(NSString *)formatterStr{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    if (formatterStr.length == 0) {
        formatterStr = @"yyyy-MM-dd HH:mm:ss";
    }
    fmt.dateFormat = formatterStr;
    [fmt setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    return [fmt dateFromString:dateString];
}

///将日期 -> 字符串 （按照某个格式）
+ (NSString *)formatterStringWithDate:(NSDate *)date formatterString:(NSString *)formatterStr{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    if (formatterStr.length == 0) {
        formatterStr = @"yyyy-MM-dd HH:mm:ss";
    }
    fmt.dateFormat = formatterStr;
    [fmt setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    
    return [fmt stringFromDate:date];
}

///获取某个时间戳的日期字符串 （按照某个格式）
+ (NSString *)formatterStringWithTimeInterver:(NSTimeInterval)timerInterval formatterString:(NSString *)formatterStr{
    NSDate *date = [self dateWithTimeInterver:timerInterval];
    NSString *timeStr = [self formatterStringWithDate:date formatterString:formatterStr];
    return timeStr;
}



@end
