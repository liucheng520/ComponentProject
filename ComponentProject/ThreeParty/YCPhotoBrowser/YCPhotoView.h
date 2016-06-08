//
//  VIPhotoView.h
//  VIPhotoViewDemo
//
//  Created by Vito on 1/7/15.
//  Copyright (c) 2015 vito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoItem.h"


extern NSString * const YCPhotoSingleTapNotification;
extern NSString * const YCPhotoScallingNotification;


@interface YCPhotoView : UIScrollView

@property (nonatomic, strong) PhotoItem *photo;

- (instancetype)initWithFrame:(CGRect)frame;

- (UIView *)transitionForImageView;

@end
