//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.

#ifndef YRCropDefine_h
#define YRCropDefine_h


#endif /* YRCropDefine_h */
typedef NS_ENUM(NSInteger, CropCornerType) {
    CropCornerTypeUpperLeft,
    CropCornerTypeUpperRight,
    CropCornerTypeLowerRight,
    CropCornerTypeLowerLeft
};



#define kMaxRotationAngle             0.5 // pai
#define kMaximumCanvasWidth         200
#define kMaximumCanvasHeight        200
#define kCanvasHeaderHeigth               60 //画布头高



#define kCropLines                     2
#define kGridLines                     9

#define kCropViewHotArea                 16
#define kMinimumCropArea                 60

#define kCropViewCornerLength             22

#import "UIView+Extension.h"
#import "UIColor+Tweak.h"
#import "UIView+circleCover.h"
#import "UIScrollView+Extension.h"


#import "YRMathTool.h"
#import "YRCropCorner.h"
#import "YRCropView.h"
#import "YRPhotoContentView.h"
#import "YRPhotoScrollView.h"
#import "UIView+Extension.h"





























