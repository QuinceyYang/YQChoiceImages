//
//  UIImage+YQExtension.h
//
//
//  Created by 杨清 on 2017/8/9.
//  Copyright © 2017年 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YQExtension)

@property (strong, nonatomic) UIImage *circleImage;///<对应的圆角图片

/**
 * 通过颜色来生成一个纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 * 通过颜色来生成一个纯色图片, size = 1*1
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 * 生成一张圆角纯色图片
 * @param color  图片颜色
 * @param size   图片尺寸
 * @param radius 圆角半径
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius;

/**
 * 生成一张椭圆形图片
 * @param size   图片尺寸,也是椭圆形的尺寸
 * @param color  图片颜色
 */
+ (UIImage *)imageOvalWithSize:(CGSize)size color:(UIColor *)color;

/**
 * 生成一张五角星图片
 * @param size   图片尺寸,也是五角星的尺寸
 * @param color  图片颜色
 */
+ (UIImage *)imageStarWithSize:(CGSize)size color:(UIColor *)color;


/**
 * 生成一张返回(左箭头)图片(尺寸：40*42)
 * @param color  箭头颜色
 * @param lineWidth  线宽
 */
+ (UIImage *)imageBackArrowWithColor:(UIColor *)color lineWidth:(float)lineWidth;

/**
 * 生成对应的圆角图片
 */
- (UIImage *)circleImage;


/**
 * 生成一张五角星裁剪的图片
 */
- (UIImage *)starImage;

#pragma mark - 生成渐变色图片
/**
 * 生成一张渐变橙色图片(Normal状态)
 */
+ (UIImage *)imageGradientOrangeNormalWithSize:(CGSize)size;

/**
 * 生成一张渐变橙色图片(Selected状态)
 */
+ (UIImage *)imageGradientOrangeSelectedWithSize:(CGSize)size;

@end
