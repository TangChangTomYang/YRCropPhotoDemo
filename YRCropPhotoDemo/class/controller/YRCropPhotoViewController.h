//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.

#import <UIKit/UIKit.h>

@class YRCropPhotoViewController;

@protocol YRCropPhotoViewControllerDelegate <NSObject>

-(void)cropViewController:(YRCropPhotoViewController *)cropViewController didCroppedImage:(UIImage *)newImage;
-(void)cropViewControllerDidClickCancelBtn:(YRCropPhotoViewController *)cropViewController;
@end


@interface YRCropPhotoViewController : UIViewController

@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, assign) BOOL autoSaveToLibray;
@property (nonatomic, assign) CGFloat maxRotationAngle;

@property (nonatomic, weak) id<YRCropPhotoViewControllerDelegate> delegate;




@property (nonatomic, strong) UIColor *saveButtonTitleColor;
@property (nonatomic, strong) UIColor *saveButtonHighlightTitleColor;

@property (nonatomic, strong) UIColor *cancelButtonTitleColor;
@property (nonatomic, strong) UIColor *cancelButtonHighlightTitleColor;

@property (nonatomic, strong) UIColor *resetButtonTitleColor;
@property (nonatomic, strong) UIColor *resetButtonHighlightTitleColor;

@property (nonatomic, strong) UIColor *sliderTintColor;

- (instancetype)initWithImage:(UIImage *)image cropSize:(CGSize)cropSize;

@end


