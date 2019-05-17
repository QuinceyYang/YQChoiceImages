//
//  UIScrollView+YQExtension.m
//
//
//  Created by 杨清 on 2017/11/30.
//  Copyright © 2017年 QuinceyYang. All rights reserved.
//

#import "UIScrollView+YQExtension.h"

@implementation UIScrollView (YQExtension)

+ (void)load
{
    NSLog(@"UIScrollView Load !!!");
    if (@available(iOS 11.0, *)) {
        [[self appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];        
    } else {
        // Fallback on earlier versions
    }
}


@end
