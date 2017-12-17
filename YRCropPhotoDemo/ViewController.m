//
//  ViewController.m
//  YRCropPhotoDemo
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.
//

#import "ViewController.h"
#import "YRCropPhotoViewController.h"
@interface ViewController ()<UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
YRCropPhotoViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.navigationBarHidden = YES;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    YRCropPhotoViewController *photoTweaksViewController = [[YRCropPhotoViewController alloc] initWithImage:image cropSize:CGSizeMake(200, 300)];
    
    photoTweaksViewController.delegate = self;
    photoTweaksViewController.autoSaveToLibray = YES;
    photoTweaksViewController.maxRotationAngle = M_PI_4;
    
    [picker pushViewController:photoTweaksViewController animated:YES];
}


-(void)cropViewController:(YRCropPhotoViewController *)cropViewController didCroppedImage:(UIImage *)newImage{
    [cropViewController.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)cropViewControllerDidClickCancelBtn:(YRCropPhotoViewController *)cropViewController{
    [cropViewController.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
