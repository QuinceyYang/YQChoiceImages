//
//  YQEasyImageBrowserVC.m
//  ParkingWe
//
//  Created by 杨清 on 2019/5/15.
//  Copyright © 2019 soargift.com. All rights reserved.
//

#import "YQEasyImageBrowserVC.h"

@interface YQEasyImageBrowserVC () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
/// 图片视图数组
@property (strong, nonatomic) NSMutableArray <UIView *>*viewsArr;
@end

@implementation YQEasyImageBrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-UIApplication.sharedApplication.statusBarFrame.size.height-self.navigationController.navigationBar.frame.size.height)];
    scrollView.backgroundColor = UIColor.blackColor;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    if (self.imageArr.count <= 0) {
        return;
    }
    _viewsArr = [NSMutableArray new];
    for (NSInteger i=0; i<self.imageArr.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*scrollView.width, 0, scrollView.width, scrollView.height)];
        [scrollView addSubview:view];
        [_viewsArr addObject:view];
        //
        UIImageView *iv = [[UIImageView alloc]initWithFrame:view.bounds];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = self.imageArr[i];
        [view addSubview:iv];
    }
    scrollView.contentSize = CGSizeMake(self.imageArr.count*scrollView.width, 0);
    if (_currentIndex>=0 && _currentIndex<self.imageArr.count) {
        scrollView.contentOffset = CGPointMake(_currentIndex*scrollView.width, 0);
    }
    self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld",_currentIndex+1,self.imageArr.count];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
#pragma mark 设置navigationBar
    if (self.navigationController != nil)
    {
        if (self.navigationController.navigationBarHidden == YES) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        //self.navigationItem.title = @"";
        [self setTitleColor:[UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0] font:[UIFont boldSystemFontOfSize:18]];
        [self setNavBgColor:UIColor.whiteColor];
        [self setNavShadowColor:[UIColor clearColor]];
        [self setNavLeftImage:@"common_back_icon"];
        [self setNavRightImage:@"icon_black_delete"];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    if (self.completionBlock) {
        self.completionBlock(self.imageArr);
    }
    [super viewDidDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Override methods
#pragma mark 点击右按钮(删除图片)
- (void)tapNavRightBtn:(UIButton *)sender {
    if (_imageArr.count <= 0) {
        return;
    }
    NSInteger delIndex = _currentIndex;
    [_imageArr removeObjectAtIndex:delIndex];
    [_viewsArr[delIndex] removeFromSuperview];
    [_viewsArr removeObjectAtIndex:delIndex];
    //
    for (NSInteger i=0; i<_viewsArr.count; i++) {
        _viewsArr[i].x = i*_scrollView.width;
    }
    _scrollView.contentSize = CGSizeMake(_viewsArr.count*_scrollView.width, 0);
    if (_imageArr.count <= 0) {
        _currentIndex = 0;
        self.navigationItem.title = @"无照片";
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else {
        if (_currentIndex >= _imageArr.count) {
            self.currentIndex = _imageArr.count-1;
        }
        else {
            self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld",_currentIndex+1,self.imageArr.count];
        }
    }
}


#pragma mark - setter getter
- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (currentIndex<0 || currentIndex>=_imageArr.count) {
        return;
    }
    _currentIndex = currentIndex;
    if (_scrollView) {
        self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld",_currentIndex+1,_imageArr.count];
        [_scrollView setContentOffset:CGPointMake(_currentIndex*_scrollView.width, 0) animated:YES];
    }
}

#pragma mark - < UIScrollViewDelegate >
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //NSLog(@"scrollView.contentOffset = %@   +++++++",NSStringFromCGPoint(scrollView.contentOffset));
    NSInteger idx = scrollView.contentOffset.x/scrollView.width;
    if (idx != _currentIndex) {
        _currentIndex = idx;
        self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld",_currentIndex+1,self.imageArr.count];
    }
}

@end
