//
//  YCImagePagesViewController.h
//  俄官方的方式提供撒
//
//  Created by Scott on 15/12/25.
//  Copyright © 2015年 bluemobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCImageViewController.h"
#import "ZoomTransition.h"

@class YCPhotosPageViewController;

@protocol PhotosPageViewDelegate <NSObject>

- (void)PhotosPageViewControlller:(YCPhotosPageViewController *)photosVC didChangedIndex:(NSInteger)index;

@end



@interface YCPhotosPageViewController : UIViewController<ZoomTransitionProtocol>

@property (nonatomic,weak) id<PhotosPageViewDelegate> delegate;

@property (nonatomic, assign) BOOL needsShowToolBar;   //default is NO

- (instancetype)initWithPhotos:(NSArray *)photos currentIndex:(NSInteger)curIndex;

@end
