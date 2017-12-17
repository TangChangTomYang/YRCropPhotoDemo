//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.

#import "UIScrollView+Extension.h"

@implementation UIScrollView (Extension)


-(CGFloat)contentOffsetX{
    return self.contentOffset.x;
}

-(CGFloat)contentOffsetY{
    
    return self.contentOffset.y;
}

- (void)setContentOffsetY:(CGFloat)offsetY{
    
    CGPoint contentOffset = self.contentOffset;
    contentOffset.y = offsetY;
    self.contentOffset = contentOffset;
}

- (void)setContentOffsetX:(CGFloat)offsetX{
    CGPoint contentOffset = self.contentOffset;
    contentOffset.x = offsetX;
    self.contentOffset = contentOffset;
}

-(void)setContentOffsetX:(CGFloat)offsetX animated:(BOOL)animated{
    CGPoint contentOffset = self.contentOffset;
    contentOffset.x = offsetX;
    [self setContentOffset:contentOffset animated:animated];
}

-(void)setContentOffsetY:(CGFloat)offsetY animated:(BOOL)animated{
    CGPoint contentOffset = self.contentOffset;
    contentOffset.y = offsetY;
    [self setContentOffset:contentOffset animated:animated];
}

@end
