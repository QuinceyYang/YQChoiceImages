//
//  UIImage+YQExtension.m
//
//
//  Created by 杨清 on 2017/8/9.
//  Copyright © 2017年 QuinceyYang. All rights reserved.
//

#import "UIImage+YQExtension.h"

@implementation UIImage (YQExtension)

@dynamic circleImage;

#pragma mark 通过颜色来生成一个纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark 通过颜色来生成一个纯色图片, size = 1*1
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


#pragma mark 生成一张圆角纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    [color setFill];
    [rectanglePath fill];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark 生成一张椭圆形图片
+ (UIImage *)imageOvalWithSize:(CGSize)size color:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    [color setFill];
    [ovalPath fill];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark 生成一张五角星图片
+ (UIImage *)imageStarWithSize:(CGSize)size color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    float rateW = size.width/100.f;
    float rateH = size.height/100.f;
    
    //// Star Drawing
    UIBezierPath* starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint: CGPointMake(50*rateW, 0*rateH)];
    [starPath addLineToPoint: CGPointMake(67.63*rateW, 25.73*rateH)];
    [starPath addLineToPoint: CGPointMake(97.55*rateW, 34.55*rateH)];
    [starPath addLineToPoint: CGPointMake(78.53*rateW, 59.27*rateH)];
    [starPath addLineToPoint: CGPointMake(79.39*rateW, 90.45*rateH)];
    [starPath addLineToPoint: CGPointMake(50*rateW, 80*rateH)];
    [starPath addLineToPoint: CGPointMake(20.61*rateW, 90.45*rateH)];
    [starPath addLineToPoint: CGPointMake(21.47*rateW, 59.27*rateH)];
    [starPath addLineToPoint: CGPointMake(2.45*rateW, 34.55*rateH)];
    [starPath addLineToPoint: CGPointMake(32.37*rateW, 25.73*rateH)];
    [starPath closePath];
    [color setFill];
    [starPath fill];

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark 生成一张返回(左箭头)图片
+ (UIImage *)imageBackArrowWithColor:(UIColor *)color lineWidth:(float)lineWidth
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(40, 42), NO, 0.0f);

    //// Bezier Drawing 10*18
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(10, 0)];
    [bezierPath addLineToPoint: CGPointMake(0, 9)];
    [bezierPath addLineToPoint: CGPointMake(10, 18)];
    [color setStroke];
    bezierPath.lineWidth = lineWidth;
    bezierPath.lineCapStyle = kCGLineCapRound;
    [bezierPath applyTransform:CGAffineTransformMakeTranslation(3,(42-18)*0.5)];
    [bezierPath stroke];

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


#pragma mark 生成对应的圆角图片
- (UIImage *)circleImage
{
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    // 方形变圆形
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark 生成一张五角星裁剪的图片
- (UIImage *)starImage
{
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);

    float rateW = rect.size.width/100.f;
    float rateH = rect.size.height/100.f;
    
    //// Star Drawing
    UIBezierPath* starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint: CGPointMake(50*rateW, 0*rateH)];
    [starPath addLineToPoint: CGPointMake(67.63*rateW, 25.73*rateH)];
    [starPath addLineToPoint: CGPointMake(97.55*rateW, 34.55*rateH)];
    [starPath addLineToPoint: CGPointMake(78.53*rateW, 59.27*rateH)];
    [starPath addLineToPoint: CGPointMake(79.39*rateW, 90.45*rateH)];
    [starPath addLineToPoint: CGPointMake(50*rateW, 80*rateH)];
    [starPath addLineToPoint: CGPointMake(20.61*rateW, 90.45*rateH)];
    [starPath addLineToPoint: CGPointMake(21.47*rateW, 59.27*rateH)];
    [starPath addLineToPoint: CGPointMake(2.45*rateW, 34.55*rateH)];
    [starPath addLineToPoint: CGPointMake(32.37*rateW, 25.73*rateH)];
    [starPath closePath];

    CGContextAddPath(ctx, starPath.CGPath);
    // 裁剪
    CGContextClip(ctx);
    
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 生成渐变色图片
/**
 * 生成一张渐变橙色图片(Normal状态)
 */
+ (UIImage *)imageGradientOrangeNormalWithSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 创建RGB颜色空间
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    // 定义渐变颜色：红、绿、蓝（可以根据需要增加或减少渐变颜色）
    CGFloat colors[] =
    {
        255.0/255.0 , 167.0/255.0 , 38.0/255.0 , 1.0,
        253.0/255.0 , 181.0/255.0 , 84.0/255.0 , 1.0,
        255.0/255.0 , 194.0/255.0 , 102.0/255.0 , 1.0,
        //0 , 1 , 0 , 1,
        //0 , 0 , 1 , 1,
    };
    // 创建渐变对象
    CGGradientRef _gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    
    CGContextDrawLinearGradient(ctx, _gradient, CGPointMake(0, 0), CGPointMake(rect.size.width, 0), 0);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/**
 * 生成一张渐变橙色图片(Selected状态)
 */
+ (UIImage *)imageGradientOrangeSelectedWithSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 创建RGB颜色空间
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    // 定义渐变颜色：红、绿、蓝（可以根据需要增加或减少渐变颜色）
    CGFloat colors[] =
    {
        255.0/255.0 , 158.0/255.0 , 13.0/255.0 , 1.0,
        251.0/255.0 , 171.0/255.0 , 62.0/255.0 , 1.0,
        255.0/255.0 , 184.0/255.0 , 76.0/255.0 , 1.0,
        //0 , 1 , 0 , 1,
        //0 , 0 , 1 , 1,
    };
    // 创建渐变对象
    CGGradientRef _gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    
    CGContextDrawLinearGradient(ctx, _gradient, CGPointMake(0, 0), CGPointMake(rect.size.width, 0), 0);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
