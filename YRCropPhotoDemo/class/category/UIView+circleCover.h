//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIView (circleCover)


/// 裁剪框背景的处理
- (void)addClipOverlayAtRect:(CGRect)cropRect
              needCircleCrop:(BOOL)needCircleCrop;
@end
