//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.

#import <UIKit/UIKit.h>
#import "YRCropDefine.h"

@interface YRCropPhotoView : UIView

@property (nonatomic, assign, readonly) CGFloat angle;
@property (nonatomic, strong,readonly) YRPhotoScrollView   *scrollView;

/** 是否可以自由裁剪图片 , 默认 不允许*/
@property(nonatomic, assign)BOOL canFreeCrop;
/** 是否可以旋转图片 , 默认 不允许*/
@property(nonatomic, assign)BOOL canRotation;

@property (nonatomic, strong, readonly) UISlider *slider;
@property (nonatomic, strong, readonly) UIButton *resetBtn;

- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
             maxRotationAngle:(CGFloat)maxRotationAngle
                     cropSize:(CGSize)cropSize;



- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
             maxRotationAngle:(CGFloat)maxRotationAngle;

- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image;

- (CGPoint)photoContentViewTranslation;

@end
