//
//  NSDate+YQExtension.h
//
//
//  Created by 杨清 on 2017/8/16.
//  Copyright © 2017年 QuinceyYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDate (YQExtension)

#pragma mark - NSDate 转 NSString
/**
 * NSDate 转 NSString（格式: yyyy-MM-dd HH:mm:ss）
 */
+ (NSString *)stringFromDate:(NSDate *)date;

/**
 * NSDate 转 NSString（格式: yyyy-MM-dd）
 */
+ (NSString *)dayFromDate:(NSDate *)date;

/**
 * NSDate 转 NSString（格式: MM月dd日）
 */
+ (NSString *)monthDayFromDate:(NSDate *)date;

/**
 * NSDate 转 NSString（格式: HH:mm）
 */
+ (NSString *)timeFromDate:(NSDate *)date;

#pragma mark - NSString 转 NSDate

/**
 * yyyy-MM-dd HH:mm:ss 转换为 NSDate
 */
+(NSDate *)dateFromString:(NSString *)strDate;

/**
 * pragma mark yyyy-MM-dd转换为 NSDate
 */
+(NSDate *)dateFromDayString:(NSString *)strDate;


/**
 * 通过年月日时分秒 转 NSDate
 */
+(NSDate *)dateWithYear:(int)year
                  month:(int)month
                    day:(int)day
                   hour:(int)hour
                 minute:(int)minute
                 second:(int)second;


#pragma mark -
/**
 * 通过NSDate获得NSDateComponents
 */
+(NSDateComponents *)componentsFromDate:(NSDate *)date;

//___________________________________________________________________________
- (BOOL)isLaterThanDate:(NSDate *)aDate;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;

@end
