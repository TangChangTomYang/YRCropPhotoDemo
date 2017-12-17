//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.

#import <UIKit/UIKit.h>

@interface YRPhotoContentView : UIView

-(instancetype)initWithImage:(UIImage *)image;

-(instancetype)initWithFrame:(CGRect)frame  image:(UIImage *)image;
@end
