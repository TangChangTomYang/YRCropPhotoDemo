//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.

#import "UIView+circleCover.h"

@implementation UIView (circleCover)


/// 裁剪框背景的处理
- (void)addClipOverlayAtRect:(CGRect)cropRect
              needCircleCrop:(BOOL)needCircleCrop {
    
  
    
    
    UIBezierPath *path= [UIBezierPath bezierPathWithRect:[UIScreen mainScreen].bounds];
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    if (needCircleCrop) { // 圆形裁剪框
        
        CGPoint circleCenter =  CGPointMake(cropRect.origin.x + cropRect.size.width * 0.5, cropRect.origin.y + cropRect.size.height * 0.5);
        CGFloat circleRadius = MIN(cropRect.size.width * 0.5, cropRect.size.height * 0.5);
        
        
        [path appendPath:[UIBezierPath bezierPathWithArcCenter:circleCenter radius:circleRadius startAngle:0 endAngle: 2 * M_PI clockwise:NO]];
    }
    else { // 矩形裁剪框
        [path appendPath:[UIBezierPath bezierPathWithRect:cropRect]];
    }
    
    
    layer.path = path.CGPath;
    layer.fillRule = kCAFillRuleEvenOdd;
    layer.fillColor = [[UIColor blackColor] CGColor];
    layer.opacity = 0.5;
    [self.layer addSublayer:layer];
}
@end
