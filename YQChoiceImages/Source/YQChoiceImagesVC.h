//
//  YQChoiceImagesVC.h
//  ParkingWe
//
//  Created by 杨清 on 2019/5/14.
//  Copyright © 2019 soargift.com. All rights reserved.
//

#import "YQBaseViewController.h"
#import "YQBaseViewController.h"
#import "UIView+Extension.h"
#import "YQButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface YQChoiceImagesVC : YQBaseViewController

/// 选择图片视图
@property (strong, nonatomic, readonly) UIView *choiceImagesView;
/// 相机按钮（出发拍照或从相册选择图片）
@property (strong, nonatomic, readonly) YQButton *cameraBtn;
/// 最终选择的照片
@property (strong, nonatomic, readonly) NSArray<UIImage *>*choiceImagesArr;
@property (strong, nonatomic, readonly) UIScrollView *scrollView;

/**
 * Override method
 */
- (void)choiceImagesViewDidUpdateFrame;


@end

NS_ASSUME_NONNULL_END
