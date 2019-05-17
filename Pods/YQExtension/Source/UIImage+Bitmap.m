//
//  UIImage+Bitmap.m
//
//
//  Created by 杨清 on 2017/7/26.
//  Copyright © 2017年 QuinceyYang. All rights reserved.
//

#import "UIImage+Bitmap.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (Bitmap)
+ (UIImage*)captureScreen
{
	// 获取程序窗口
	UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
	UIGraphicsBeginImageContext(screenWindow.frame.size);  // 开始绘图
	// 将窗口的layer图片渲染到当前绘图上下文中
	[screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
	// 获取图片
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();  // 结束绘图
	return viewImage;
}
+ (UIImage*)captureView:(UIView *)targetView
{
	CGRect rect = targetView.frame;  // 获取目标UIView所在的区域
	UIGraphicsBeginImageContext(rect.size);  // 开始绘图
	CGContextRef context = UIGraphicsGetCurrentContext();  // 获取当前的绘图Context
	// 调用CALayer的方法将当前控件绘制到绘图Context中
	[targetView.layer renderInContext:context];
	// 获取该绘图Context中的图片
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}
-(UIImage *)imageAtRect:(CGRect)rect
{
	// 获取该UIImage图片对应的CGImageRef对象
	CGImageRef srcImage = [self CGImage];
	// 从srcImage中“挖取”rect区域
	CGImageRef imageRef = CGImageCreateWithImageInRect(srcImage, rect);
	// 将“挖取”出来的CGImageRef转换为UIImage对象
	UIImage* subImage = [UIImage imageWithCGImage: imageRef];
	return subImage;
}
- (UIImage *)imageByScalingAspectToMinSize:(CGSize)targetSize
{
	// 获取源图片的宽和高
	CGSize imageSize = self.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	// 获取图片缩放目标大小的宽和高
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	// 定义图片缩放后的宽度
	CGFloat scaledWidth = targetWidth;
	// 定义图片缩放后的高度
	CGFloat scaledHeight = targetHeight;
	CGPoint anchorPoint = CGPointZero;
	// 如果源图片的大小与缩放的目标大小不相等
	if (!CGSizeEqualToSize(imageSize, targetSize))
	{
		// 计算水平方向上的缩放因子
		CGFloat xFactor = targetWidth / width;
		// 计算垂直方向上的缩放因子
		CGFloat yFactor = targetHeight / height;
		// 定义缩放因子scaleFactor为两个缩放因子中较大的一个
		CGFloat scaleFactor = xFactor > yFactor? xFactor : yFactor;
		// 根据缩放因子计算图片缩放后的宽度和高度
		scaledWidth  = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		// 如果横向上的缩放因子大于纵向上的缩放因子，那么图片在纵向上需要裁切
		if (xFactor > yFactor)
		{
			anchorPoint.y = (targetHeight - scaledHeight) * 0.5;
		}
		// 如果横向上的缩放因子小于纵向上的缩放因子，那么图片在横向上需要裁切
		else if (xFactor < yFactor)
		{
			anchorPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}
	// 开始绘图
	UIGraphicsBeginImageContext(targetSize);
	// 定义图片缩放后的区域
	CGRect anchorRect = CGRectZero;
	anchorRect.origin = anchorPoint;
	anchorRect.size.width  = scaledWidth;
	anchorRect.size.height = scaledHeight;
	// 将图片本身绘制到auchorRect区域中
	[self drawInRect:anchorRect];
	// 获取绘制后生成的新图片
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage ;  // 返回新图片
}
- (UIImage *)imageByScalingAspectToMaxSize:(CGSize)targetSize
{
	// 获取源图片的宽和高
	CGSize imageSize = self.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	// 获取图片缩放目标大小的宽和高
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	// 定义图片缩放后的实际宽度和高度
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	CGPoint anchorPoint = CGPointZero;
	// 如果源图片的大小与缩放的目标大小不相等
	if (!CGSizeEqualToSize(imageSize, targetSize))
	{
		CGFloat xFactor = targetWidth / width;
		CGFloat yFactor = targetHeight / height;
		// 定义缩放因子scaleFactor为两个缩放因子中较小的一个
		CGFloat scaleFactor = xFactor < yFactor ? xFactor:yFactor;
		// 根据缩放因子计算图片缩放后的宽度和高度
		scaledWidth = width * scaleFactor;
		scaledHeight = height * scaleFactor;
		// 如果横向的缩放因子小于纵向的缩放因子，图片在上面和下面有空白
		// 那么图片在纵向上需要下移一段距离，保持图片在中间
		if (xFactor < yFactor)
		{
			anchorPoint.y = (targetHeight - scaledHeight) * 0.5;
		}
		// 如果横向的缩放因子小于纵向的缩放因子，图片在左边和右边有空白
		// 那么图片在横向上需要右移一段距离，保持图片在中间
		else if (xFactor > yFactor)
		{
			anchorPoint.x = (targetWidth - scaledWidth) * 0.5;
		}
	}
	// 开始绘图
	UIGraphicsBeginImageContext(targetSize);
	// 定义图片缩放后的区域
	CGRect anchorRect = CGRectZero;
	anchorRect.origin = anchorPoint;
	anchorRect.size.width  = scaledWidth;
	anchorRect.size.height = scaledHeight;
	// 将图片本身绘制到auchorRect区域中
	[self drawInRect:anchorRect];
	// 获取绘制后生成的新图片
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;  // 返回新图片
}
- (UIImage *)imageByScalingToSize:(CGSize)targetSize
{
	// 开始绘图
	UIGraphicsBeginImageContext(targetSize);
	// 定义图片缩放后的区域，无须保持纵横比，所以直接缩放
	CGRect anchorRect = CGRectZero;
	anchorRect.origin = CGPointZero;
	anchorRect.size = targetSize;
	[self drawInRect:anchorRect];  // 将图片本身绘制到auchorRect区域中
	// 获取绘制后生成的新图片
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;  // 返回新图片
}
// 图片旋转角度
- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
	// 定义一个执行旋转的CGAffineTransform结构体
	CGAffineTransform t = CGAffineTransformMakeRotation(radians);
	// 对图片的原始区域执行旋转，获取旋转后的区域
	CGRect rotatedRect = CGRectApplyAffineTransform(
		CGRectMake(0.0 , 0.0, self.size.width, self.size.height) , t);
	CGSize rotatedSize = rotatedRect.size;  // 获取图片旋转后的大小
	// 创建绘制位图的上下文
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	// 指定坐标变换，将坐标中心平移到图片的中心
	CGContextTranslateCTM(ctx, rotatedSize.width/2, rotatedSize.height/2);
	CGContextRotateCTM(ctx , radians);  // 执行坐标变换，旋转过radians弧度
	CGContextScaleCTM(ctx, 1.0, -1.0);  // 执行坐标变换，执行缩放
	CGContextDrawImage(ctx, CGRectMake(-self.size.width / 2,
		- self.size.height / 2, self.size.width,
		self.size.height), self.CGImage);  // 绘制图片
	// 获取绘制后生成的新图片
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;  // 返回新图片
}
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
	return [self imageRotatedByRadians:degrees * M_PI / 180];
}
- (void) saveToDocuments:(NSString*)fileName
{
	// 获取当前应用路径中Documents目录下的指定文件名对应的文件路径
	NSString *path = [[NSHomeDirectory()
		stringByAppendingPathComponent:@"Documents"]
		stringByAppendingPathComponent:fileName];
	[UIImagePNGRepresentation(self)
		writeToFile:path atomically:YES];  // 保存PNG图片
//	[UIImageJPEGRepresentation(self, 1.0)  // 1.0代表图片压缩比率
//		writeToFile:path atomically:YES];  // 保存JPG图片
}


//yqing add next ==================================================================================================================
#pragma mark -

#pragma mark 返回一张新图片
+ (UIImage*)drawImage:(NSString *)name inRect:(CGRect)inRect
{
    UIGraphicsBeginImageContext(inRect.size);  // 创建内存中的图片
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rectNew = CGRectMake(0, 0, inRect.size.width, inRect.size.height);
    //在绘制到context前通过矩阵垂直翻转坐标系
    // uiImage是将要绘制的UIImage图片，width和height是它的宽高
    CGContextTranslateCTM(ctx, 0, rectNew.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    CGContextDrawImage(ctx, rectNew, [UIImage imageNamed:name].CGImage);
    CGContextTranslateCTM(ctx, 0, rectNew.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    
    // 获取该绘图Context中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // ---------结束绘图---------
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage*)drawImage2:(NSString *)name inRect:(CGRect)inRect
{
    UIGraphicsBeginImageContext(inRect.size);  // 创建内存中的图片
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rectNew = CGRectMake(0, 0, inRect.size.width, inRect.size.height);
    
    UIImage *img = [[UIImage alloc] initWithCGImage:[[UIImage imageNamed:name] CGImage]];
    [img drawInRect:rectNew];
    
    // 获取该绘图Context中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // ---------结束绘图---------
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (UIImage *)drawGraphics:(NSInteger)type style:(NSInteger)style size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  // 创建内存中的图片
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //这里添加绘制图形代码
    
    
    // 获取该绘图Context中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // ---------结束绘图---------
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end



@implementation UIImage (Category)

///把图片变灰
-(UIImage *)getGrayImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    
    return grayImage;
}

///通过颜色来生成一个纯色图片
+(UIImage *)imageFromColor:(UIColor *)color rectSize:(CGRect)Rect
{
    UIGraphicsBeginImageContext(Rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, Rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end


@implementation UIImage (ResizableImage)
- (UIImage*) resizableImage:(UIEdgeInsets)insets {
    if ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f ) {
        return [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    }
    
    return [self stretchableImageWithLeftCapWidth:insets.left topCapHeight:insets.top];
}

@end



