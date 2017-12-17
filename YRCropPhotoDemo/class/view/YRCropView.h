//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.
#import <UIKit/UIKit.h>
#import "YRCropDefine.h"
@class YRCropView;

@protocol CropViewDelegate <NSObject>

- (void)cropEnded:(YRCropView *)cropView;
- (void)cropMoved:(YRCropView *)cropView;
@end

@interface YRCropView : UIView
@property (nonatomic, weak) id<CropViewDelegate> delegate;

- (void)dismissCropLines;
- (void)updateGridLines:(BOOL)animate;
- (void)dismissGridLines;
@end
