//
//  AppDelegate.h
//  YRCropPhotoTool
//
//  Created by yangrui on 2017/12/17.
//  Copyright © 2017年 yangrui. All rights reserved.

#import "YRPhotoScrollView.h"


@interface YRPhotoScrollView ()
@property (nonatomic, strong) UIImage *image;
@end


@implementation YRPhotoScrollView

-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image{
    
    self = [super initWithFrame:frame];
    if(self){
        self.image = image;
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 5.0;
        
        self.bounces = YES;
        self.layer.anchorPoint = CGPointMake(0.5, 0.5);
        self.alwaysBounceVertical = YES;
        self.alwaysBounceHorizontal = YES;
        
        self.minimumZoomScale = 1;
        self.maximumZoomScale = 10;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.clipsToBounds = NO;

        CGRect photoContentFrame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
        self. photoContentView =  [[YRPhotoContentView alloc] initWithFrame:photoContentFrame image:image];
        [self addSubview: self. photoContentView];
        
    }
    return self;
}



-(void)setImage:(UIImage *)image{
    _image = image;
    
    CGFloat imageLenWidthRate  =  image.size.height /image.size.width ;
    CGFloat imageWidthLenRate  =  image.size.width / image.size.height ;
    CGFloat scrollViewLenWidthRate  =  self.height /self.width ;
    
    CGFloat contentSizeHeight = self.height;
    CGFloat contentSizeWidth  = self.width;
    
    if (imageLenWidthRate > scrollViewLenWidthRate) { // scrollView 高度增加
        contentSizeHeight = imageLenWidthRate *  self.width ;
    }
    else if(imageLenWidthRate < scrollViewLenWidthRate) {// 宽度增加
        contentSizeWidth =  imageWidthLenRate  * self.height ;
    }
    self.contentSize = CGSizeMake(contentSizeWidth, contentSizeHeight);
    
    if (contentSizeWidth > self.width ) {
        self.contentOffset = CGPointMake((contentSizeWidth - self.width) * 0.5, 0);
    }
    else if (contentSizeHeight > self.height){
        self.contentOffset = CGPointMake(0 , (contentSizeHeight - self.height)* 0.5);
    }
    
}


- (CGFloat)zoomScaleToBound{
    
    CGFloat scaleW = self.bounds.size.width / self.photoContentView.bounds.size.width;
    CGFloat scaleH = self.bounds.size.height / self.photoContentView.bounds.size.height;
    CGFloat max = MAX(scaleW, scaleH);
    
    return max;
}

@end
