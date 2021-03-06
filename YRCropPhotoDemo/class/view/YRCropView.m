//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.
#import "YRCropView.h"

@interface YRCropView ()

@property (nonatomic, strong) YRCropCorner *upperLeft;
@property (nonatomic, strong) YRCropCorner *upperRight;
@property (nonatomic, strong) YRCropCorner *lowerRight;
@property (nonatomic, strong) YRCropCorner *lowerLeft;

@property (nonatomic, strong) NSMutableArray *horizontalCropLines;
@property (nonatomic, strong) NSMutableArray *verticalCropLines;

@property (nonatomic, strong) NSMutableArray *horizontalGridLines;
@property (nonatomic, strong) NSMutableArray *verticalGridLines;



@property (nonatomic, assign) BOOL cropLinesDismissed;
@property (nonatomic, assign) BOOL gridLinesDismissed;

@end


@implementation YRCropView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = [UIColor cropLineColor].CGColor;
        self.layer.borderWidth = 1;
//        self.backgroundColor = [UIColor blueColor];
        
        
        _horizontalCropLines = [NSMutableArray array];
        for (int i = 0; i < kCropLines; i++) {
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor cropLineColor];
            [_horizontalCropLines addObject:line];
            [self addSubview:line];
        }
        
        _verticalCropLines = [NSMutableArray array];
        for (int i = 0; i < kCropLines; i++) {
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor cropLineColor];
            [_verticalCropLines addObject:line];
            [self addSubview:line];
        }
        
        _horizontalGridLines = [NSMutableArray array];
        for (int i = 0; i < kGridLines; i++) {
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor gridLineColor];
            [_horizontalGridLines addObject:line];
            [self addSubview:line];
        }
        
        _verticalGridLines = [NSMutableArray array];
        for (int i = 0; i < kGridLines; i++) {
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor gridLineColor];
            [_verticalGridLines addObject:line];
            [self addSubview:line];
        }
        
        _cropLinesDismissed = YES;
        _gridLinesDismissed = YES;
        
        _upperLeft = [[YRCropCorner alloc] initWithCornerType:CropCornerTypeUpperLeft];
        _upperLeft.center = CGPointMake(kCropViewCornerLength / 2, kCropViewCornerLength / 2);
        _upperLeft.autoresizingMask = UIViewAutoresizingNone;
        [self addSubview:_upperLeft];
        
        _upperRight = [[YRCropCorner alloc] initWithCornerType:CropCornerTypeUpperRight];
        _upperRight.center = CGPointMake(self.frame.size.width - kCropViewCornerLength / 2, kCropViewCornerLength / 2);
        _upperRight.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:_upperRight];
        
        _lowerRight = [[YRCropCorner alloc] initWithCornerType:CropCornerTypeLowerRight];
        _lowerRight.center = CGPointMake(self.frame.size.width - kCropViewCornerLength / 2, self.frame.size.height - kCropViewCornerLength / 2);
        _lowerRight.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:_lowerRight];
        
        _lowerLeft = [[YRCropCorner alloc] initWithCornerType:CropCornerTypeLowerLeft];
        _lowerLeft.center = CGPointMake(kCropViewCornerLength / 2, self.frame.size.height - kCropViewCornerLength / 2);
        _lowerLeft.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        
        [self addSubview:_lowerLeft];
        
        
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1) {
        [self updateCropLines:NO];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1) {
        CGPoint location = [[touches anyObject] locationInView:self];
        CGRect frame = self.frame;
        
        CGPoint p0 = CGPointMake(0, 0);
        CGPoint p1 = CGPointMake(self.frame.size.width, 0);
        CGPoint p2 = CGPointMake(0, self.frame.size.height);
        CGPoint p3 = CGPointMake(self.frame.size.width, self.frame.size.height);
        
        BOOL canChangeWidth = frame.size.width > kMinimumCropArea;
        BOOL canChangeHeight = frame.size.height > kMinimumCropArea;
        
        if ([YRMathTool distanceBetweenPointA:location pointB:p0] < kCropViewHotArea) {
            if (canChangeWidth) {
                frame.origin.x += location.x;
                frame.size.width -= location.x;
            }
            if (canChangeHeight) {
                frame.origin.y += location.y;
                frame.size.height -= location.y;
            }
        }
        
        else if ([YRMathTool distanceBetweenPointA:location pointB:p1] < kCropViewHotArea) {
            if (canChangeWidth) {
                frame.size.width = location.x;
            }
            if (canChangeHeight) {
                frame.origin.y += location.y;
                frame.size.height -= location.y;
            }
        }
        
        else if ([YRMathTool distanceBetweenPointA:location pointB:p2] < kCropViewHotArea) {
            if (canChangeWidth) {
                frame.origin.x += location.x;
                frame.size.width -= location.x;
            }
            if (canChangeHeight) {
                frame.size.height = location.y;
            }
        }
        
        else if ([YRMathTool distanceBetweenPointA:location pointB:p3] < kCropViewHotArea) {
            if (canChangeWidth) {
                frame.size.width = location.x;
            }
            if (canChangeHeight) {
                frame.size.height = location.y;
            }
        }
        else if (fabs(location.x - p0.x) < kCropViewHotArea) {
            if (canChangeWidth) {
                frame.origin.x += location.x;
                frame.size.width -= location.x;
            }
        }
        else if (fabs(location.x - p1.x) < kCropViewHotArea) {
            if (canChangeWidth) {
                frame.size.width = location.x;
            }
        }
        else if (fabs(location.y - p0.y) < kCropViewHotArea) {
            if (canChangeHeight) {
                frame.origin.y += location.y;
                frame.size.height -= location.y;
            }
        }
        else if (fabs(location.y - p2.y) < kCropViewHotArea) {
            if (canChangeHeight) {
                frame.size.height = location.y;
            }
        }
        
        self.frame = frame;
        
        // update crop lines
        [self updateCropLines:NO];
        
        if ([self.delegate respondsToSelector:@selector(cropMoved:)]) {
            [self.delegate cropMoved:self];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(cropEnded:)]) {
        [self.delegate cropEnded:self];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)updateCropLines:(BOOL)animate
{
    // show crop lines
    if (self.cropLinesDismissed) {
        [self showCropLines];
    }
    
    void (^animationBlock)(void) = ^(void) {
        [self updateLines:self.horizontalCropLines horizontal:YES];
        [self updateLines:self.verticalCropLines horizontal:NO];
    };
    
    
  if (animate) {
        [UIView animateWithDuration:0.25 animations:animationBlock];
    } else {
        animationBlock();
    }
}

- (void)updateGridLines:(BOOL)animate
{
    // show grid lines
    if (self.gridLinesDismissed) {
        [self showGridLines];
    }
    
    void (^animationBlock)(void) = ^(void) {
        
        [self updateLines:self.horizontalGridLines horizontal:YES];
        [self updateLines:self.verticalGridLines horizontal:NO];
    };
    
    if (animate) {
        [UIView animateWithDuration:0.25 animations:animationBlock];
    } else {
        animationBlock();
    }
}

- (void)updateLines:(NSArray *)lines horizontal:(BOOL)horizontal
{
    [lines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *line = (UIView *)obj;
        if (horizontal) {
            line.frame = CGRectMake(0,
                                    (self.frame.size.height / (lines.count + 1)) * (idx + 1),
                                    self.frame.size.width,
                                    1 / [UIScreen mainScreen].scale);
        } else {
            line.frame = CGRectMake((self.frame.size.width / (lines.count + 1)) * (idx + 1),
                                    0,
                                    1 / [UIScreen mainScreen].scale,
                                    self.frame.size.height);
        }
    }];
}

- (void)dismissCropLines
{
    [UIView animateWithDuration:0.2 animations:^{
        [self dismissLines:self.horizontalCropLines];
        [self dismissLines:self.verticalCropLines];
    } completion:^(BOOL finished) {
        self.cropLinesDismissed = YES;
    }];
}

- (void)dismissGridLines
{
    [UIView animateWithDuration:0.2 animations:^{
        [self dismissLines:self.horizontalGridLines];
        [self dismissLines:self.verticalGridLines];
    } completion:^(BOOL finished) {
        self.gridLinesDismissed = YES;
    }];
}

- (void)dismissLines:(NSArray *)lines
{
    [lines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ((UIView *)obj).alpha = 0.0f;
    }];
}

- (void)showCropLines
{
    self.cropLinesDismissed = NO;
    [UIView animateWithDuration:0.2 animations:^{
        [self showLines:self.horizontalCropLines];
        [self showLines:self.verticalCropLines];
    }];
}

- (void)showGridLines
{
    self.gridLinesDismissed = NO;
    [UIView animateWithDuration:0.2 animations:^{
        [self showLines:self.horizontalGridLines];
        [self showLines:self.verticalGridLines];
    }];
}

- (void)showLines:(NSArray *)lines
{
    [lines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ((UIView *)obj).alpha = 1.0f;
    }];
}

@end
