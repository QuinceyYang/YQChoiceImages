//
//  NSDictionary+Log.m
//
//
//  Created by 杨清 on 2017/7/19.
//  Copyright © 2017年 QuinceyYang. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)

/**
 解决字典输出中文乱码的问题
 
 @return 输出结果
 */
- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *string = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [string appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    [string appendString:@"}\n"];
    
    return string;
}

@end
