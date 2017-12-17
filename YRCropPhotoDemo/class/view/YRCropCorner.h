//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.

#import <UIKit/UIKit.h>
#import "YRCropDefine.h"

@interface YRCropCorner : UIView


/** 上下左右 四个角的视图 */
- (instancetype)initWithCornerType:(CropCornerType)type;
@end
