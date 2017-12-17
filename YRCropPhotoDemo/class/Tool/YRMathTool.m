//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.

#import "YRMathTool.h"
#import <math.h>
@implementation YRMathTool

+(CGFloat)distanceBetweenPointA:(CGPoint )pointA pointB:(CGPoint)pointB{
    return sqrt(pow(pointB.x - pointA.x, 2) + pow(pointB.y - pointA.y, 2));
}
@end
