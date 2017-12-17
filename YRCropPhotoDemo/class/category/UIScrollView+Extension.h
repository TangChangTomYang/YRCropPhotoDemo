//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIScrollView (Extension)



@property(nonatomic, assign)CGFloat contentOffsetY;
@property(nonatomic, assign)CGFloat contentOffsetX;

- (void)setContentOffsetY:(CGFloat)offsetY animated:(BOOL)animated;
- (void)setContentOffsetX:(CGFloat)offsetX animated:(BOOL)animated;

@end
