//
//  VIPhotoView.m
//  VIPhotoViewDemo
//
//  Created by Vito on 1/7/15.
//  Copyright (c) 2015 vito. All rights reserved.
//

#import "YCPhotoView.h"

NSString * const YCPhotoSingleTapNotification = @"PhotoSingleTapNotification";
NSString * const YCPhotoScallingNotification =  @"PhotoScallingNotification";

@interface YCPhotoView () <UIScrollViewDelegate>
{
    BOOL _zoomByDoubleTap;
}

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic) BOOL rotating;
@property (nonatomic) CGSize minSize;

@end

@implementation YCPhotoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        // 图片
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        // 属性
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        // 监听点击
        [self setupGestureRecognizer];
        
    }
    
    return self;
}

- (void)setPhoto:(PhotoItem *)photo
{
    _photo = photo;
    
    [self showImage];
}


- (UIView *)transitionForImageView
{
    return self.imageView;
}

- (void)showImage
{
    if(_photo.image)
    {
        _imageView.image = _photo.image;
    }
    else if(_photo.imageName)
    {
        UIImage *image = [UIImage imageNamed:_photo.imageName];
        if(image)
        {
            self.photo.image = image;
            _imageView.image = _photo.image;
        }
        else
        {
            NSLog(@"图片不存在，或图片名不正确");
        }
    }
    else
    {
        //网络图片加载  需要SDWebImage支持
        _imageView.image = [UIImage imageNamed:_photo.placeHolderImage];
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_photo.url] placeholderImage:[UIImage imageNamed:_photo.placeHolderImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             if(image)
             {
                 _imageView.image = image;
                 
                 [self adjustFrame];
             }
         }];

    }
    
    [self adjustFrame];
}


- (void)adjustFrame
{
    if (_imageView.image == nil) return;
    
    CGFloat boundsWidth = self.bounds.size.width;
    CGFloat boundsHeight = self.bounds.size.height;
    CGFloat imageWidth = _imageView.image.size.width;
    CGFloat imageHeight = _imageView.image.size.height;
    
    // 设置伸缩比例
    CGFloat imageScale = boundsWidth / imageWidth;
    CGFloat minScale = MIN(1.0, imageScale);
    
    CGFloat maxScale = 3.0;
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        maxScale = maxScale / [[UIScreen mainScreen] scale];
    }
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;
    self.zoomScale = minScale;
    
    CGRect imageFrame = CGRectMake(0, MAX(0, (boundsHeight- imageHeight*imageScale)/2), boundsWidth, imageHeight *imageScale);
    
    self.contentSize = CGSizeMake(CGRectGetWidth(imageFrame), CGRectGetHeight(imageFrame));
    _imageView.frame = imageFrame;
    
    
    [self centerContent];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 取消请求
    //    [_imageView sd_setImageWithURL:[NSURL URLWithString:@"file:///abc"]];
}


- (void)setupGestureRecognizer
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapHandler:)];
    singleTap.delaysTouchesBegan = YES;
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
}

#pragma mark - GestureRecognizer
- (void)singleTapHandler:(UIGestureRecognizer *)recongnizer
{
    [[NSNotificationCenter defaultCenter] postNotificationName:YCPhotoSingleTapNotification object:recongnizer];
}

- (void)tapHandler:(UITapGestureRecognizer *)recognizer
{
    _zoomByDoubleTap = YES;
    
    if (self.zoomScale == self.maximumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else {
        CGPoint touchPoint = [recognizer locationInView:self];
        CGFloat scale = self.maximumZoomScale/ self.zoomScale;
        CGRect rectTozoom=CGRectMake(touchPoint.x * scale, touchPoint.y * scale, 1, 1);
        [self zoomToRect:rectTozoom animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (_zoomByDoubleTap) {
        CGFloat insetY = (CGRectGetHeight(self.bounds) - CGRectGetHeight(_imageView.frame))/2;
        insetY = MAX(insetY, 0.0);
        if (ABS(_imageView.frame.origin.y - insetY) > 0.5) {
            CGRect imageViewFrame = _imageView.frame;
            imageViewFrame = CGRectMake(imageViewFrame.origin.x, insetY, imageViewFrame.size.width, imageViewFrame.size.height);
            _imageView.frame = imageViewFrame;
        }
    }
    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    _zoomByDoubleTap = NO;
    CGFloat insetY = (CGRectGetHeight(self.bounds) - CGRectGetHeight(_imageView.frame))/2;
    insetY = MAX(insetY, 0.0);
    if (ABS(_imageView.frame.origin.y - insetY) > 0.5) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect imageViewFrame = _imageView.frame;
            imageViewFrame = CGRectMake(imageViewFrame.origin.x, insetY, imageViewFrame.size.width, imageViewFrame.size.height);
            _imageView.frame = imageViewFrame;
        }];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerContent];
    
    if(self.zoomScale > self.minimumZoomScale)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:YCPhotoScallingNotification object:nil];
    }
}

- (void)centerContent
{
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = _imageView.frame;
    
    // Horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    
    // Vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    } else {
        frameToCenter.origin.y = 0;
    }
    
    // Center
    if (!CGRectEqualToRect(_imageView.frame, frameToCenter))
        _imageView.frame = frameToCenter;
}

@end




