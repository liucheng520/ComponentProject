//
//  ZoomTransition.h
//  俄官方的方式提供撒
//
//  Created by Scott on 15/12/28.
//  Copyright © 2015年 bluemobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ZoomTransitionProtocol <NSObject>

- (UIView *)viewForTransition;

@optional
- (BOOL)shouldApplyZoomOutAnimation;

@end

@interface ZoomTransition : NSObject<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end
