//
//  UIColor+Change.h
//  ChangeColor
//
//  Created by QuinceyYang on 16-3-13.
//  Copyright (c) 2016年 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Change)

///  获取canvas用的颜色字符串
- (NSString *)canvasColorString;

///获取网页颜色字串
- (NSString *) webColorString;

///获取RGB值
- (CGFloat *) getRGB;

///让颜色更亮
- (UIColor *) lighten;

///让颜色更暗
- (UIColor *) darken;

///取两个颜色的中间
- (UIColor *) mix: (UIColor *) color;



@end
