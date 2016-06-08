//
//  YCImageViewController.h
//  俄官方的方式提供撒
//
//  Created by Scott on 15/12/25.
//  Copyright © 2015年 bluemobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCPhotoView.h"

@interface YCImageViewController : UIViewController

@property (nonatomic, assign) NSInteger index;


- (instancetype)initWithPhoto:(PhotoItem *)photo;


- (UIView *)viewForTransition;

@end
