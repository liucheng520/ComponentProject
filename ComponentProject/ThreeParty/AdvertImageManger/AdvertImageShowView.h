//
//  ZJStartADView.h
//  ZJBuildingProject
//
//  Created by Scott on 16/3/31.
//  Copyright © 2016年 bluemobi. All rights reserved.
//  启动广告UIView

#import <UIKit/UIKit.h>
#import "AdvertImageManger.h"

@interface AdvertImageShowView : UIView

/**
 *  显示缓存的图片
 */
+ (void)startAdvertViewOnContainer:(UIView *)containerView;

@end
