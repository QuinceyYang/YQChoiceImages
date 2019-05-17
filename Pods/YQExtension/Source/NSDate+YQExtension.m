//
//  NSDate+YQExtension.m
//
//
//  Created by 杨清 on 2017/8/16.
//  Copyright © 2017年 QuinceyYang. All rights reserved.
//

#import "NSDate+YQExtension.h"

@implementation NSDate (YQExtension)

#pragma mark - NSDate 转 NSString
/**
 * NSDate 转 NSString（格式: yyyy-MM-dd HH:mm:ss）
 */
+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

/**
 * NSDate 转 NSString（格式: yyyy-MM-dd）
 */
+ (NSString *)dayFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

/**
 * NSDate 转 NSString（格式: MM月dd日）
 */
+ (NSString *)monthDayFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"MM月dd日"];
    return [dateFormatter stringFromDate:date];
}

/**
 * NSDate 转 NSString（格式: HH:mm）
 */
+ (NSString *)timeFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"HH:mm"];
    return [dateFormatter stringFromDate:date];
}

#pragma mark - NSString 转 NSDate

#pragma mark yyyy-MM-dd HH:mm:ss 转换为 NSDate
+(NSDate *)dateFromString:(NSString *)strDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:strDate];
}

#pragma mark yyyy-MM-dd转换为 NSDate
+(NSDate *)dateFromDayString:(NSString *)strDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter dateFromString:strDate];
}

#pragma mark 通过年月日时分秒 转 NSDate
+(NSDate *)dateWithYear:(int)year
                  month:(int)month
                    day:(int)day
                   hour:(int)hour
                 minute:(int)minute
                 second:(int)second
{
    NSString *strDate = [NSString stringWithFormat:@"%4d-%02d-%02d %02d:%02d:%02d", year,month,day,hour,minute,second];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:strDate];
    return date;
}


#pragma mark - 通过NSDate获得NSDateComponents
+(NSDateComponents *)componentsFromDate:(NSDate *)date
{
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* components = [gregorian components:unitFlags fromDate:date];
    
    return components;
}

//_______________________________________________________________________________________
- (BOOL) isEarlierThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)isLaterThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

@end
