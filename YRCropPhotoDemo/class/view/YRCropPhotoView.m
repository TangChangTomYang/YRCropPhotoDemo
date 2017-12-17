//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.

#import "YRCropPhotoView.h"




@interface YRCropPhotoView () <UIScrollViewDelegate, CropViewDelegate>

@property (nonatomic, strong) YRCropView *cropView;

@property (nonatomic, strong) UIImage  *image;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UIButton *resetBtn;
@property (nonatomic, assign) CGSize   originalCanvasMaxSize;//原始画布最大的尺寸
@property (nonatomic, assign) CGFloat  originCanvasCenterY;  //原始画布Y中心

@property (nonatomic, assign) CGFloat  angle;

@property (nonatomic, assign) BOOL manualZoomed;

// masks
@property (nonatomic, strong) UIView *topMask;
@property (nonatomic, strong) UIView *leftMask;
@property (nonatomic, strong) UIView *bottomMask;
@property (nonatomic, strong) UIView *rightMask;

@property (nonatomic, assign) CGFloat maxRotationAngle;


/**scrollView  和图片的原始 */
@property(nonatomic, assign)CGFloat originMaxScale;

@end

@implementation YRCropPhotoView


@synthesize cropView = _cropView;
-(YRCropView *)cropView{
    if (!_cropView) {
        _cropView = [[YRCropView alloc] initWithFrame:self.scrollView.frame];
        _cropView.center = self.scrollView.center;
        _cropView.delegate = self;
    }
    return _cropView;
}




-(UISlider *)slider{
    if (!_slider) {
        
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 260, 20)];
        _slider.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) - 135);
        _slider.minimumValue = -self.maxRotationAngle;
        _slider.maximumValue = self.maxRotationAngle;
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(sliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_slider];
    }
    return _slider;
}

-(UIButton *)resetBtn{
    if (!_resetBtn) {
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _resetBtn.frame = CGRectMake(0, 0, 60, 20);
        _resetBtn.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) - 95);
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_resetBtn setTitleColor:[UIColor resetButtonColor] forState:UIControlStateNormal];
        [_resetBtn setTitleColor:[UIColor resetButtonHighlightedColor] forState:UIControlStateHighlighted];
        [_resetBtn setTitle:NSLocalizedStringFromTable(@"RESET", @"PhotoTweaks", nil) forState:UIControlStateNormal];
        [_resetBtn addTarget:self action:@selector(resetBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_resetBtn];
    }
    return _resetBtn;
}

-(void)setupScrollViewWithFrame:(CGRect)frame image:(UIImage *)image{
    
   _scrollView  = [[YRPhotoScrollView alloc] initWithFrame:frame image:image];
    [self addSubview:_scrollView];
    _scrollView.delegate = self;
}

-(void)setupTopLeftBottomRightMaskView{
    _topMask = [self addMaskView];
    _leftMask = [self addMaskView];
    _bottomMask = [self addMaskView];
    _rightMask = [self addMaskView];
}

-(UIView *)addMaskView{
    UIView *maskView = [UIView new];
    maskView.backgroundColor = [UIColor maskColor];
    [self addSubview:maskView];
    return maskView;
}

- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
             maxRotationAngle:(CGFloat)maxRotationAngle
                     cropSize:(CGSize)cropSize{
    
  
    if (self = [super initWithFrame:frame]) {
        
        self.image = image;
        self.maxRotationAngle = maxRotationAngle;
        // frame
        _originalCanvasMaxSize = cropSize;
        if (CGSizeEqualToSize(cropSize, CGSizeZero)) {
            _originalCanvasMaxSize = CGSizeMake(kMaximumCanvasWidth, kMaximumCanvasHeight );
            _originCanvasCenterY = self.centerY;//kMaximumCanvasHeight / 2.0 + kCanvasHeaderHeigth;
        }
          CGRect scrollViewFrame = CGRectMake((self.width - _originalCanvasMaxSize.width) * 0.5 , (self.height - _originalCanvasMaxSize.height) * 0.5, _originalCanvasMaxSize.width, _originalCanvasMaxSize.height);
        
        
        [self setupScrollViewWithFrame:scrollViewFrame image:image];
        
        [self addSubview:self.cropView];
        
        [self addClipOverlayAtRect:self.scrollView.frame needCircleCrop:YES];
        
        [self setupTopLeftBottomRightMaskView];
        [self updateMasks:NO];
        
        [self addSubview:self.slider];
        [self addSubview:self.resetBtn];
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
             maxRotationAngle:(CGFloat)maxRotationAngle{
    
  return   [self initWithFrame:frame image:image maxRotationAngle:maxRotationAngle cropSize: CGSizeZero];
  
}

- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image{
     return  [self initWithFrame:frame image:image maxRotationAngle:kMaxRotationAngle cropSize: CGSizeZero];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (CGRectContainsPoint(self.slider.frame, point)) {
        return self.slider;
    }
    else if (CGRectContainsPoint(self.resetBtn.frame, point)) {
        return self.resetBtn;
   
    }
    
    // 判断是否在热区内
    else if (CGRectContainsPoint(CGRectInset(self.cropView.frame, -kCropViewHotArea, -kCropViewHotArea), point) &&
             !CGRectContainsPoint(CGRectInset(self.cropView.frame, kCropViewHotArea, kCropViewHotArea), point)) {
        return self.cropView;
    }
    return self.scrollView;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.scrollView.photoContentView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    self.manualZoomed = YES;
}

#pragma mark - Crop View Delegate

- (void)cropMoved:(YRCropView *)cropView{
    [self updateMasks:NO];
}

- (void)cropEnded:(YRCropView *)cropView
{
    CGFloat scaleX = self.originalCanvasMaxSize.width / cropView.bounds.size.width;
    CGFloat scaleY = self.originalCanvasMaxSize.height / cropView.bounds.size.height;
    CGFloat scale = MIN(scaleX, scaleY);
    
    // calculate the new bounds of crop view
    CGRect newCropBounds = CGRectMake(0, 0, scale * cropView.frame.size.width, scale * cropView.frame.size.height);
    
    // calculate the new bounds of scroll view
    CGFloat width = fabs(cos(self.angle)) * newCropBounds.size.width + fabs(sin(self.angle)) * newCropBounds.size.height;
    CGFloat height = fabs(sin(self.angle)) * newCropBounds.size.width + fabs(cos(self.angle)) * newCropBounds.size.height;
    
    // calculate the zoom area of scroll view
    CGRect scaleFrame = cropView.frame;
    if (scaleFrame.size.width >= self.scrollView.bounds.size.width) {
        scaleFrame.size.width = self.scrollView.bounds.size.width - 1;
    }
    if (scaleFrame.size.height >= self.scrollView.bounds.size.height) {
        scaleFrame.size.height = self.scrollView.bounds.size.height - 1;
    }
    
    CGPoint contentOffset = self.scrollView.contentOffset;
    CGPoint contentOffsetCenter = CGPointMake(contentOffset.x + self.scrollView.bounds.size.width / 2, contentOffset.y + self.scrollView.bounds.size.height / 2);
    CGRect bounds = self.scrollView.bounds;
    bounds.size.width = width;
    bounds.size.height = height;
    self.scrollView.bounds = CGRectMake(0, 0, width, height);
    CGPoint newContentOffset = CGPointMake(contentOffsetCenter.x - self.scrollView.bounds.size.width / 2, contentOffsetCenter.y - self.scrollView.bounds.size.height / 2);
    self.scrollView.contentOffset = newContentOffset;
    
    [UIView animateWithDuration:0.25 animations:^{
        // animate crop view
        cropView.bounds = CGRectMake(0, 0, newCropBounds.size.width, newCropBounds.size.height);
//        cropView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, self.originCanvasCenterY);
         cropView.center = self.center;
        
        // zoom the specified area of scroll view
        CGRect zoomRect = [self convertRect:scaleFrame toView:self.scrollView.photoContentView];
        [self.scrollView zoomToRect:zoomRect animated:NO];
    }];

    self.manualZoomed = YES;
    
    // update masks
    [self updateMasks:YES];
    
    [self.cropView dismissCropLines];
    
    CGFloat scaleH = self.scrollView.bounds.size.height / self.scrollView.contentSize.height;
    CGFloat scaleW = self.scrollView.bounds.size.width / self.scrollView.contentSize.width;
    __block CGFloat scaleM = MAX(scaleH, scaleW);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (scaleM > 1) {
            scaleM = scaleM * self.scrollView.zoomScale;
            [self.scrollView setZoomScale:scaleM animated:NO];
        }
        [UIView animateWithDuration:0.2 animations:^{
            [self checkScrollViewContentOffset];
        }];
    });
    
    
    
   
}

- (void)updateMasks:(BOOL)animate
{
    void (^animationBlock)(void) = ^(void) {
        self.topMask.frame = CGRectMake(0, 0, self.cropView.frame.origin.x + self.cropView.frame.size.width, self.cropView.frame.origin.y);
        
        self.leftMask.frame = CGRectMake(0, self.cropView.frame.origin.y, self.cropView.frame.origin.x, self.frame.size.height - self.cropView.frame.origin.y);
        
        self.bottomMask.frame = CGRectMake(self.cropView.frame.origin.x, self.cropView.frame.origin.y + self.cropView.frame.size.height, self.frame.size.width - self.cropView.frame.origin.x, self.frame.size.height - (self.cropView.frame.origin.y + self.cropView.frame.size.height));
        
        self.rightMask.frame = CGRectMake(self.cropView.frame.origin.x + self.cropView.frame.size.width, 0, self.frame.size.width - (self.cropView.frame.origin.x + self.cropView.frame.size.width), self.cropView.frame.origin.y + self.cropView.frame.size.height);
    };
    
    if (animate) {
        [UIView animateWithDuration:0.25 animations:animationBlock ];
        
    } else {
        animationBlock();
    }
    

}

- (void)checkScrollViewContentOffset
{
    self.scrollView.contentOffsetX = MAX(self.scrollView.contentOffset.x, 0);
    self.scrollView.contentOffsetY = MAX(self.scrollView.contentOffset.y, 0);
    
    if (self.scrollView.contentSize.height - self.scrollView.contentOffset.y <= self.scrollView.bounds.size.height) {
        self.scrollView.contentOffsetY = self.scrollView.contentSize.height - self.scrollView.bounds.size.height;
    }
    
    if (self.scrollView.contentSize.width - self.scrollView.contentOffset.x <= self.scrollView.bounds.size.width) {
        self.scrollView.contentOffsetX = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
    }
}

- (void)sliderValueChanged:(id)sender{
    // update masks
    [self updateMasks:NO];
    
    // update grids
    [self.cropView updateGridLines:NO];
    
    // rotate scroll view
    self.angle = self.slider.value;
    self.scrollView.transform = CGAffineTransformMakeRotation(self.angle);
    
    // position scroll view
    CGFloat width = fabs(cos(self.angle)) * self.cropView.frame.size.width + fabs(sin(self.angle)) * self.cropView.frame.size.height;
    CGFloat height = fabs(sin(self.angle)) * self.cropView.frame.size.width + fabs(cos(self.angle)) * self.cropView.frame.size.height;
    CGPoint center = self.scrollView.center;
    
    CGPoint contentOffset = self.scrollView.contentOffset;
    CGPoint contentOffsetCenter = CGPointMake(contentOffset.x + self.scrollView.bounds.size.width / 2, contentOffset.y + self.scrollView.bounds.size.height / 2);
    self.scrollView.bounds = CGRectMake(0, 0, width, height);
    CGPoint newContentOffset = CGPointMake(contentOffsetCenter.x - self.scrollView.bounds.size.width / 2, contentOffsetCenter.y - self.scrollView.bounds.size.height / 2);
    self.scrollView.contentOffset = newContentOffset;
    self.scrollView.center = center;
    
    // scale scroll view
    BOOL shouldScale = self.scrollView.contentSize.width / self.scrollView.bounds.size.width <= 1.0 || self.scrollView.contentSize.height / self.scrollView.bounds.size.height <= 1.0;
    if (!self.manualZoomed || shouldScale) {
        [self.scrollView setZoomScale:[self.scrollView zoomScaleToBound] animated:NO];
        self.scrollView.minimumZoomScale = [self.scrollView zoomScaleToBound];

        self.manualZoomed = NO;
    }
    
    [self checkScrollViewContentOffset];
}

- (void)sliderTouchEnded:(id)sender{
    
    [self.cropView dismissGridLines];
}

- (void)resetBtnTapped:(id)sender{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.angle = 0;
        
        self.scrollView.transform = CGAffineTransformIdentity;
        self.scrollView.bounds = CGRectMake(0, 0, self.originalCanvasMaxSize.width, self.originalCanvasMaxSize.height);
//        self.scrollView.center = CGPointMake(self.width / 2, self.originCanvasCenterY);
        self.scrollView.center =self.center;
        
        self.scrollView.minimumZoomScale = 1;
        [self.scrollView setZoomScale:1 animated:NO];
        self.cropView.center = self.scrollView.center;
        [self updateMasks:NO];
        [self.slider setValue:0 animated:YES];
        
    }];
}

//photoContentView 的 偏移位置
- (CGPoint)photoContentViewTranslation{
    
    CGRect rect = [self.scrollView.photoContentView convertRect:self.scrollView.photoContentView.bounds toView:self];
    //photoContentView rect center
    CGPoint point = CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2);
     //cropPhotoView rect center
//    CGPoint zeroPoint = CGPointMake(CGRectGetWidth(self.frame) / 2, self.originCanvasCenterY);
    CGPoint zeroPoint = self.center;
    return CGPointMake(point.x - zeroPoint.x, point.y - zeroPoint.y);
}

@end
