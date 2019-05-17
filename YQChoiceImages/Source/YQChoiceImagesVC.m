//
//  YQChoiceImagesVC.m
//  ParkingWe
//
//  Created by 杨清 on 2019/5/14.
//  Copyright © 2019 soargift.com. All rights reserved.
//

#import "YQChoiceImagesVC.h"
//#import <CoreServices/UTCoreTypes.h>
#import <MobileCoreServices/MobileCoreServices.h>
//#import "UIImage+Bitmap.h"
#import "YQEasyImageBrowserVC.h"

@interface YQChoiceImagesVC () <UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) NSMutableArray <YQButton *>*photosBtnArr;

@end

@implementation YQChoiceImagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-UIApplication.sharedApplication.statusBarFrame.size.height-self.navigationController.navigationBar.frame.size.height)];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    CGFloat tmpY = 0;
    //添加图片
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, tmpY+10, scrollView.width, 82)];
        view.backgroundColor = UIColor.whiteColor;
        [scrollView addSubview:view];
        _choiceImagesView = view;
        self.photosBtnArr = [NSMutableArray new];
        //
        __weak __typeof(self)weakSelf = self;
        YQButton *cameraBtn = [[YQButton alloc]initWithFrame:CGRectMake(12, 12, 60, 60)];
        cameraBtn.tag = 100;
        [cameraBtn setBackgroundImage:[UIImage imageNamed:@"icon_picture_camera"] forState:UIControlStateNormal];
        [view addSubview:cameraBtn];
        _cameraBtn = cameraBtn;
        cameraBtn.tapAction = ^(YQButton *sender) {
            if (weakSelf.photosBtnArr.count < 5) {
                // 创建一个UIActionSheet
                UIActionSheet* sheet = [[UIActionSheet alloc]
                                        initWithTitle:nil  // 指定标题
                                        delegate:self  // 指定该UIActionSheet的委托对象就是该控制器自身
                                        cancelButtonTitle:@"取消"  // 指定取消按钮的标题
                                        destructiveButtonTitle:nil  // 指定销毁按钮的标题
                                        otherButtonTitles:@"拍照", @"从相册中选择", nil];  // 为其他按钮指定标题
                // 设置UIActionSheet的风格
                sheet.actionSheetStyle = UIActionSheetStyleDefault;
                [sheet showInView:weakSelf.view];
            }
            else {
                // 弹框提醒
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"最多只能添加5张图片" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                // 弹出对话框
                [weakSelf presentViewController:alert animated:true completion:nil];
            }
        };
    }
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
        self.navigationItem.title = @"添加照片";
        [self setTitleColor:[UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0] font:[UIFont boldSystemFontOfSize:18]];
        [self setNavBgColor:UIColor.whiteColor];
        [self setNavShadowColor:[UIColor clearColor]];
        //[self setNavLeftImage:@"common_back_icon"];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - getter setter
- (NSArray<UIImage *> *)choiceImagesArr {
    if (_photosBtnArr==nil || _photosBtnArr.count<=0) {
        return [NSArray new];
    }
    NSMutableArray<UIImage *> *imgArr = [NSMutableArray new];
    for (NSInteger i=0; i<_photosBtnArr.count; i++) {
        UIImage *img = [_photosBtnArr[i] backgroundImageForState:UIControlStateNormal];
        if (img) {
            [imgArr addObject:img];
        }
    }
    return [NSArray arrayWithArray:imgArr];
}

#pragma mark - Override methods
- (void)choiceImagesViewDidUpdateFrame {
    
}

#pragma mark - < UINavigationControllerDelegate >
-(void)navigationController:(UINavigationController *)navigationController
     willShowViewController:(UIViewController *)viewController
                   animated:(BOOL)animated
{
    if ([navigationController isKindOfClass:[UIImagePickerController class]])
    {
        navigationController.navigationBar.tintColor = [UIColor blackColor];
        viewController.navigationController.navigationBar.translucent = NO;
        [viewController.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:19],
           NSForegroundColorAttributeName:[UIColor blackColor]}];
    }
}

#pragma mark - < UIActionSheetDelegate >
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // 设置导航默认标题的颜色及字体大小
        picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
        [self presentViewController:picker animated:YES completion:nil];
    }
    else if (buttonIndex == 1)
    {
        // 从相册中选取
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            UILabel *l= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
            l.backgroundColor = [UIColor redColor];
            controller.navigationItem.titleView = l;
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {        //判断当前设备的系统是否是ios7.0以上
                controller.edgesForExtendedLayout = UIRectEdgeNone;
            }
            
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    }
}

#pragma mark - < UIImagePickerControllerDelegate >
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    __weak __typeof(self)weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSLog(@"img = %@", img);
        //3024 × 4032
        //img = [img imageByScalingAspectToMinSize:CGSizeMake(3024/2, 4032/2)];
        NSLog(@"img = %@", img);
        if (weakSelf.photosBtnArr.count < 5) {
            CGFloat x = 12 + weakSelf.photosBtnArr.count%5*72;
            CGFloat y = (weakSelf.photosBtnArr.count-weakSelf.photosBtnArr.count%5)/5*72;
            [UIView beginAnimations:nil context:nil];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x, y, 72, 72)];
            [weakSelf.choiceImagesView addSubview:view];
            YQButton *btn = [[YQButton alloc]initWithFrame:CGRectMake(0, 12, 60, 60)];
            btn.tag = 1;
            [btn setBackgroundImage:img forState:UIControlStateNormal];
            [view addSubview:btn];
            [weakSelf.photosBtnArr addObject:btn];
            weakSelf.cameraBtn.x = 12 + weakSelf.photosBtnArr.count%5*72;
            weakSelf.cameraBtn.y = (weakSelf.photosBtnArr.count-weakSelf.photosBtnArr.count%5)/5*72+12;
            weakSelf.choiceImagesView.height = weakSelf.cameraBtn.maxY+10;
            //
            YQButton *delBtn = [[YQButton alloc]initWithFrame:CGRectMake(btn.maxX-14, btn.y-14, 28, 28)];
            delBtn.tag = 2;
            [delBtn setImage:[UIImage imageNamed:@"icon_orange_delete"] forState:UIControlStateNormal];
            [view addSubview:delBtn];
            [UIView commitAnimations];
            [weakSelf choiceImagesViewDidUpdateFrame];
            //
            btn.tapAction = ^(YQButton *sender) {
                YQEasyImageBrowserVC *vc = [YQEasyImageBrowserVC new];
                NSMutableArray *imgArr = [NSMutableArray new];
                for (NSInteger i=0; i<weakSelf.photosBtnArr.count; i++) {
                    UIImage *img = [weakSelf.photosBtnArr[i] backgroundImageForState:UIControlStateNormal];
                    if (img) {
                        [imgArr addObject:img];
                    }
                }
                vc.imageArr = imgArr;
                vc.currentIndex = [weakSelf.photosBtnArr indexOfObject:sender];
                vc.completionBlock = ^(NSMutableArray<UIImage *> * _Nonnull imageArr) {
                    [UIView beginAnimations:nil context:nil];
                    for (NSInteger i=0; i<weakSelf.photosBtnArr.count; i++) {
                        UIImage *img = [weakSelf.photosBtnArr[i] backgroundImageForState:UIControlStateNormal];
                        if (img) {
                            if ([imageArr indexOfObject:img] == NSNotFound) {
                                YQButton *delBtn = [weakSelf.photosBtnArr[i].superview viewWithTag:2];
                                if (delBtn) {
                                    YQButton *btn = (YQButton *)[delBtn.superview viewWithTag:1];
                                    [weakSelf.photosBtnArr removeObject:btn];
                                    [btn.superview removeFromSuperview];
                                    for (NSInteger i=0; i<weakSelf.photosBtnArr.count; i++) {
                                        weakSelf.photosBtnArr[i].superview.x = 12 + i%5*72;
                                        weakSelf.photosBtnArr[i].superview.y = (i-i%5)/5*72;
                                    }
                                    weakSelf.cameraBtn.x = 12 + weakSelf.photosBtnArr.count%5*72;
                                    weakSelf.cameraBtn.y = (weakSelf.photosBtnArr.count-weakSelf.photosBtnArr.count%5)/5*72+12;
                                    weakSelf.choiceImagesView.height = weakSelf.cameraBtn.maxY+10;
                                    //
                                    i=-1;
                                }
                            }
                        }
                    }
                    [UIView commitAnimations];
                    [weakSelf choiceImagesViewDidUpdateFrame];
                };
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };

            //
            delBtn.tapAction = ^(YQButton *sender) {
                [UIView beginAnimations:nil context:nil];
                YQButton *btn = (YQButton *)[sender.superview viewWithTag:1];
                [weakSelf.photosBtnArr removeObject:btn];
                [btn.superview removeFromSuperview];
                NSLog(@"weakSelf.photosBtnArr.count = %ld",(long)weakSelf.photosBtnArr.count);
                for (NSInteger i=0; i<weakSelf.photosBtnArr.count; i++) {
                    weakSelf.photosBtnArr[i].superview.x = 12 + i%5*72;
                    weakSelf.photosBtnArr[i].superview.y = (i-i%5)/5*72;
                }
                weakSelf.cameraBtn.x = 12 + weakSelf.photosBtnArr.count%5*72;
                weakSelf.cameraBtn.y = (weakSelf.photosBtnArr.count-weakSelf.photosBtnArr.count%5)/5*72+12;
                weakSelf.choiceImagesView.height = weakSelf.cameraBtn.maxY+10;
                [UIView commitAnimations];
                [weakSelf choiceImagesViewDidUpdateFrame];
            };
        }
        else {
            NSLog(@"Warning: 最多只能选5张图片");
        }
    }];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}



@end
