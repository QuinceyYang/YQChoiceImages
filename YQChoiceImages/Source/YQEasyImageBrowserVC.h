//
//  YQEasyImageBrowserVC.h
//  ParkingWe
//
//  Created by 杨清 on 2019/5/15.
//  Copyright © 2019 soargift.com. All rights reserved.
//

#import "YQBaseViewController.h"
#import "YQBaseViewController.h"
#import "UIView+Extension.h"

NS_ASSUME_NONNULL_BEGIN

@interface YQEasyImageBrowserVC : YQBaseViewController

@property (strong, nonatomic) NSMutableArray <UIImage *>*imageArr;
@property (assign, nonatomic) NSInteger currentIndex;
@property (copy, nonatomic) void (^completionBlock)(NSMutableArray <UIImage *>*imageArr);

@end

NS_ASSUME_NONNULL_END
