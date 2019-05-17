//
//  NSString+YQExtension.m
//
//
//  Created by 杨清 on 2017/7/26.
//  Copyright © 2017年 QuinceyYang. All rights reserved.
//

#import "NSString+YQExtension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (YQExtension)


+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//sha1 encode
+ (NSString *)sha1:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


#pragma mark - 

- (CGSize)yq_sizeWithFont:(UIFont *)font
{
    CGSize textSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSString* textContent = self;
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        textSize = [textContent boundingRectWithSize: CGSizeMake(INFINITY, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size;
    }
    else {
        textSize = [self sizeWithFont:font constrainedToSize:CGSizeMake(INFINITY, INFINITY) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    textSize = CGSizeMake(ceil(textSize.width), ceil(textSize.height));
    return textSize;
}

- (CGFloat)yq_widthWithFont:(UIFont *)font
{
    CGSize textSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSString* textContent = self;
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        textSize = [textContent boundingRectWithSize: CGSizeMake(INFINITY, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size;
    }
    else {
        textSize = [self sizeWithFont:font constrainedToSize:CGSizeMake(INFINITY, INFINITY) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    textSize = CGSizeMake(ceil(textSize.width), ceil(textSize.height));
    return textSize.width;
}



- (CGSize)yq_sizeWithFont:(UIFont *)font width:(CGFloat)width
{
    CGSize textSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSString* textContent = self;
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        textSize = [textContent boundingRectWithSize: CGSizeMake(width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size;
    }
    else {
        textSize = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, INFINITY) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    textSize = CGSizeMake(width, ceil(textSize.height));
    return textSize;
}


- (CGSize)yq_sizeWithFont:(UIFont *)font height:(CGFloat)height
{
    CGSize textSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSString* textContent = self;
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        textSize = [textContent boundingRectWithSize: CGSizeMake(INFINITY, height)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size;
    }
    else {
        textSize = [self sizeWithFont:font constrainedToSize:CGSizeMake(INFINITY, height) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    textSize = CGSizeMake(ceil(textSize.width), height);
    return textSize;
}



//===================================================================================================================

///已知宽度，返回高度
- (CGFloat)yq_heightWithFont:(UIFont *)font width:(CGFloat)width
{
    CGSize textSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSString* textContent = self;
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        textSize = [textContent boundingRectWithSize: CGSizeMake(width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size;
    }
    else {
        textSize = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, INFINITY) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return ceil(textSize.height);
}


- (CGFloat)yq_widthWithFont:(UIFont *)font height:(CGFloat)height
{
    CGSize textSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSString* textContent = self;
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        textSize = [textContent boundingRectWithSize: CGSizeMake(INFINITY, height)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size;
    }
    else {
        textSize = [self sizeWithFont:font constrainedToSize:CGSizeMake(INFINITY, height) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return ceil(textSize.width);
}

//============================================================================================================
///比较两个版本之间的大小。返回 -1:错误  1:YES  0:NO
- (NSInteger)isSmallThanVersion:(NSString *)version
{
    if ([self componentsSeparatedByString:@"."].count<=1) {
        return -1;
    }
    if ([version componentsSeparatedByString:@"."].count<=1) {
        return -1;
    }
    NSArray <NSString *>*versionArr1 = [self componentsSeparatedByString:@"."];
    NSArray <NSString *>*versionArr2 = [version componentsSeparatedByString:@"."];
    
    if (versionArr1.count < versionArr2.count) {
        for (NSInteger i=0; i<versionArr1.count; i++) {
            if ([versionArr1[i] integerValue] == [versionArr2[i] integerValue]) {
                continue;
            }
            else if ([versionArr1[i] integerValue] < [versionArr2[i] integerValue]) {
                return YES;
            }
            else {
                return NO;
            }
        }
        return YES;
    }
    else {
        for (NSInteger i=0; i<versionArr2.count; i++) {
            if ([versionArr1[i] integerValue] == [versionArr2[i] integerValue]) {
                continue;
            }
            else if ([versionArr1[i] integerValue] < [versionArr2[i] integerValue]) {
                return YES;
            }
            else {
                return NO;
            }
        }
        return NO;
    }
}

//___________________________________________________________________________________________________
- (BOOL)isRangeStr:(NSString *)str {
    
    NSRange range = [self rangeOfString:str];
    if (range.location == NSNotFound) {
        return NO;
    }else {
        return YES;
    }
}


+ (NSString *) jsonStringWithString:(NSString *)string{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+ (NSString *) jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+ (NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

+ (NSString *) jsonStringWithObject:(id)object{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    }
    return value;
}

+ (NSString *)countDown:(NSString *)dateStr {
    unsigned componentFlags = (NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *intime = [dateFormatter dateFromString:dateStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *day = [calendar components:componentFlags fromDate:intime toDate:[NSDate date] options:0];
    return [NSString stringWithFormat:@"%ld天%ld时%ld分%ld秒",(long)[day day] , (long)[day hour], (long)[day minute], (long)[day second]];
}

+ (NSMutableAttributedString *)string:(NSString *)string range:(NSRange)range color:(UIColor *)color {
    
    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [AttributedString addAttributes:@{NSForegroundColorAttributeName: color} range:range];
    return AttributedString;
}

+ (NSMutableAttributedString *)stringTitle:(NSString *)string range:(NSRange)range {
    
    NSMutableAttributedString *MutableAttributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [MutableAttributedString addAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:255.0/255.0 green:131.0/255.0 blue:47.0/255.0 alpha:1],
                                             NSFontAttributeName : [UIFont systemFontOfSize:20]
                                             } range:range];
    return MutableAttributedString;
}

//__________________________________________________________________________________________
+ (CGSize)countLabelContentSize:(NSString *)content font:(UIFont *)font width:(CGFloat)width
{
    // 设置行高上限
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    // 计算实际frame大小，并将label的frame变成实际大小
    CGSize _labelsize = [content sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    return _labelsize;
}

#pragma mark -- 包大小转换工具类（将包大小转换成合适单位）
+ (NSString *)getDataSizeString:(int)nSize
{
    NSString *string = nil;
    if (nSize<1024)
    {
        string = [NSString stringWithFormat:@"%dB", nSize];
    }
    else if (nSize<1048576)
    {
        string = [NSString stringWithFormat:@"%dK", (nSize/1024)];
    }
    else if (nSize<1073741824)
    {
        if ((nSize%1048576)== 0 )
        {
            string = [NSString stringWithFormat:@"%dM", nSize/1048576];
        }
        else
        {
            int decimal = 0; //小数
            NSString* decimalStr = nil;
            decimal = (nSize%1048576);
            decimal /= 1024;
            
            if (decimal < 10)
            {
                decimalStr = [NSString stringWithFormat:@"%d", 0];
            }
            else if (decimal >= 10 && decimal < 100)
            {
                int i = decimal / 10;
                if (i >= 5)
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 1];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", 0];
                }
                
            }
            else if (decimal >= 100 && decimal < 1024)
            {
                int i = decimal / 100;
                if (i >= 5)
                {
                    decimal = i + 1;
                    
                    if (decimal >= 10)
                    {
                        decimal = 9;
                    }
                    
                    decimalStr = [NSString stringWithFormat:@"%d", decimal];
                }
                else
                {
                    decimalStr = [NSString stringWithFormat:@"%d", i];
                }
            }
            
            if (decimalStr == nil || [decimalStr isEqualToString:@""])
            {
                string = [NSString stringWithFormat:@"%dMss", nSize/1048576];
            }
            else
            {
                string = [NSString stringWithFormat:@"%d.%@M", nSize/1048576, decimalStr];
            }
        }
    }
    else    // >1G
    {
        string = [NSString stringWithFormat:@"%dG", nSize/1073741824];
    }
    
    return string;
}

//__________________________________________________________________________________
/**
 * 字符串是否限定在指定的字符
 * @author yqing
 */
- (BOOL)isLimitInString:(NSString *)inString
{
    if (!inString) {
        return NO;
    }
    if (inString.length == 0) {
        return NO;
    }
    //过滤特殊字符
    for (NSInteger i=0; i<self.length; i++) {
        NSString *sub = [self substringWithRange:NSMakeRange(i, 1)];
        if (![inString containsString:sub]) {
            return NO;
        }
    }
    return YES;
}

/**
 * 字符串是否是手机号
 * @author yqing
 */
- (BOOL)isMobileNumber
{
    NSString *pattern = @"^1\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

/**
 * 字符串是否是车牌号
 * @author yqing
 */
- (BOOL)isCarNumber
{
    NSString *pattern = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4,5}[A-Z0-9挂学警港澳]{1}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

/**
 * 字符串是否是有效的密码
 * @author yqing
 */
- (BOOL)isValidPasswordOfMinLength:(long)minLen maxLength:(long)maxLen
{
    if (minLen > maxLen) {
        return NO;
    }
    NSString *pattern = [NSString stringWithFormat:@"^[A-Za-z0-9]{%ld,%ld}$",minLen,maxLen];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

@end
