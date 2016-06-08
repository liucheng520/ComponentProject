//
//  YCImageViewController.m
//  俄官方的方式提供撒
//
//  Created by Scott on 15/12/25.
//  Copyright © 2015年 bluemobi. All rights reserved.
//

#import "YCImageViewController.h"

@interface YCImageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) PhotoItem *photo;

@property (nonatomic, strong) YCPhotoView *photoView;

@end

@implementation YCImageViewController


- (instancetype)initWithPhoto:(PhotoItem *)photo
{
    self = [super init];
    if(self)
    {
        self.photo = photo;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.photoView = [[YCPhotoView alloc] initWithFrame:self.view.bounds];
    self.photoView.autoresizingMask = (1 << 6) -1;
    self.photoView.photo = self.photo;
    
    
    [self.view addSubview:self.photoView];
}


- (UIView *)viewForTransition
{
    return  [self.photoView transitionForImageView];
}


@end
