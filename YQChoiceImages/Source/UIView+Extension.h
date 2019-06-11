//
//  UIView+Extension.h
//  Easy to set frames
//
//  Created by QuinceyYang on 15/9/25.
//  Copyright © 2015年 QuinceyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;


/**
 * @author yqing
 * @brief  绘制虚线
 * @param  length   虚线的宽度
 * @param  space    虚线的间距
 * @param  color    虚线的颜色
 */
- (void)drawDashLineWithLength:(int)length space:(int)space color:(UIColor *)color;

@end
