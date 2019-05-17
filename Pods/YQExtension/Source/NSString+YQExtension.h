//
//  NSString+YQExtension.h
//
//
//  Created by 杨清 on 2017/7/26.
//  Copyright © 2017年 QuinceyYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YQExtension)

/**
 * md5加密
 */
+ (NSString *)md5:(NSString *)str;

/**
 * sha1加密
 */
+ (NSString *)sha1:(NSString *)str;


#pragma mark - 
/**
 * 一行所需的尺寸
 */
- (CGSize)yq_sizeWithFont:(UIFont *)font;


/**
 * 一行所需的宽度
 */
- (CGFloat)yq_widthWithFont:(UIFont *)font;

/**
 * 宽度固定，得出尺寸
 */
- (CGSize)yq_sizeWithFont:(UIFont *)font width:(CGFloat)width;


/**
 * 高度固定，得出尺寸
 */
- (CGSize)yq_sizeWithFont:(UIFont *)font height:(CGFloat)height;


- (CGFloat)yq_heightWithFont:(UIFont *)font width:(CGFloat)width;


- (CGFloat)yq_widthWithFont:(UIFont *)font height:(CGFloat)height;

///比较两个版本之间的大小。返回 -1:错误  1:YES  0:NO
- (NSInteger)isSmallThanVersion:(NSString *)version;

//__________________________________________________________________________________
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;

+(NSString *) jsonStringWithArray:(NSArray *)array;

+(NSString *) jsonStringWithString:(NSString *) string;

+(NSString *) jsonStringWithObject:(id) object;

- (BOOL)isRangeStr:(NSString *)str;

+ (NSString *)countDown:(NSString *)dateStr;

+ (NSMutableAttributedString *)string:(NSString *)string range:(NSRange)range color:(UIColor *)color;

+ (NSMutableAttributedString *)stringTitle:(NSString *)string range:(NSRange)range;

//__________________________________________________________________________________
+ (CGSize)countLabelContentSize:(NSString *)content font:(UIFont *)font width:(CGFloat)width;

// 转换数据包大小
+ (NSString *)getDataSizeString:(int)nSize;

//__________________________________________________________________________________
/**
 * 字符串是否限定在指定的字符
 * @author yqing
 */
- (BOOL)isLimitInString:(NSString *)inString;

/**
 * 字符串是否是手机号
 * @author yqing
 */
- (BOOL)isMobileNumber;

/**
 * 字符串是否是车牌号
 * @author yqing
 */
- (BOOL)isCarNumber;

/**
 * 字符串是否是有效的密码
 * @author yqing
 */
- (BOOL)isValidPasswordOfMinLength:(long)minLen maxLength:(long)maxLen;

@end
