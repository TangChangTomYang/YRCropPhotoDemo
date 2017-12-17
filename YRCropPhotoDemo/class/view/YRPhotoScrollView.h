//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.

#import <UIKit/UIKit.h>
#import "YRCropDefine.h"

@interface YRPhotoScrollView : UIScrollView
@property (nonatomic, strong) YRPhotoContentView *photoContentView;


-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;
- (CGFloat)zoomScaleToBound;
@end
