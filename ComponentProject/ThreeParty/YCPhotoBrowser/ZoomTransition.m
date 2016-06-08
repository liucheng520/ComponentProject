//
//  ZoomTransition.m
//  俄官方的方式提供撒
//
//  Created by Scott on 15/12/28.
//  Copyright © 2015年 bluemobi. All rights reserved.
//

#import "ZoomTransition.h"


@interface ZoomTransition ()

@property (nonatomic, strong) UINavigationController *navigationController;

@property (assign, nonatomic) id<UIViewControllerContextTransitioning> transitionContext;
@property (weak, nonatomic) UIView *fromView;
@property (weak, nonatomic) UIView *toView;
@property (assign, nonatomic) CGRect fromFrame;
@property (assign, nonatomic) CGRect toFrame;
@property (strong, nonatomic) UIView *transitionView;
@property (weak, nonatomic) UIViewController *fromViewController;
@property (weak, nonatomic) UIViewController *toViewController;
@property (assign, nonatomic) BOOL isPresenting;

@end


@implementation ZoomTransition

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController
{
    self = [super init];
    if(self){
        _isPresenting = YES;
        _navigationController = navigationController;
        _navigationController.delegate = self;
    }
    return self;
}


- (void)dealloc {
    _navigationController.interactivePopGestureRecognizer.delegate = nil;
    _navigationController.delegate = nil;
    _navigationController = nil;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //持有上下文，并从上下文中获取Viewcontroller
    self.transitionContext = transitionContext;
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //判断是否遵循协议，并获取需要动画的View
    if([_fromViewController conformsToProtocol:@protocol(ZoomTransitionProtocol)])
    {
        self.fromView = [_fromViewController performSelector:@selector(viewForTransition)];
    }
    
    if([_toViewController conformsToProtocol:@protocol(ZoomTransitionProtocol)])
    {
        self.toView = [_toViewController performSelector:@selector(viewForTransition)];
    }
    
    //确保 toViewController 已经布局完成
    _toViewController.view.frame = [_transitionContext finalFrameForViewController:_toViewController];
    [_toViewController updateViewConstraints];
    
    NSAssert(_fromView != nil && _toView != nil, @"fromView and toView need to be set,can't be nil");
    
    //获取上下文容器,在容器里面进行动画
    UIView *container = [self.transitionContext containerView];
    if (_isPresenting) {
        [container addSubview:_toViewController.view];
    } else {
        [container insertSubview:_toViewController.view belowSubview:_fromViewController.view];
    }

    [_toViewController.view layoutIfNeeded];
    
    //坐标转换
    _toFrame = [container convertRect:_toView.bounds fromView:_toView];
    _fromFrame = [container convertRect:_fromView.bounds fromView:_fromView];
    
    if([_fromView isKindOfClass:[UIImageView class]]){
        _transitionView = [[UIImageView alloc] initWithImage:((UIImageView *)_fromView).image];
    }else{
        _transitionView = [_fromView snapshotViewAfterScreenUpdates:NO];
    }
    
    UIView *tView = _transitionView;
    tView.clipsToBounds = YES;
    tView.frame = _fromFrame;
    tView.contentMode = _fromView.contentMode;
    [container addSubview:tView];
    
    if (_isPresenting) {
        [self animatateZoomInTransition];
    } else {
        [self animatateZoomOutTransition];
    }

}


- (void)animatateZoomInTransition
{
    _toViewController.view.alpha = 0;
    _toView.hidden = YES;
    _fromView.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:_transitionContext] delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        self.fromViewController.view.alpha = 0;
        self.toViewController.view.alpha = 1;
        self.transitionView.frame = self.toFrame;
    } completion:^(BOOL finished) {
        [self.transitionView removeFromSuperview];
        self.fromViewController.view.alpha = 1;
        self.toView.hidden = NO;
        self.fromView.alpha = 1;
        
        if([self.transitionContext transitionWasCancelled]){
            [self.toViewController.view removeFromSuperview];
            self.isPresenting = YES;
            [self.transitionContext completeTransition:NO];
        }else{
            self.isPresenting = NO;
            [self.transitionContext completeTransition:YES];
        }
    }];
}

- (void)animatateZoomOutTransition
{
    _transitionView.contentMode = _toView.contentMode;
    _toViewController.view.alpha = 1;
    _toView.hidden = YES;
    _fromView.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:_transitionContext] delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
        self.fromViewController.view.alpha = 0;
        self.transitionView.frame = self.toFrame;
    } completion:^(BOOL finished) {
        [self zoomOutTransitionComplete];
    }];
}


- (void)zoomOutTransitionComplete
{
    self.fromViewController.view.alpha = 1;
    self.toView.hidden = NO;
    self.fromView.alpha = 1;
    [self.transitionView removeFromSuperview];
    
    if([self.transitionContext transitionWasCancelled])
    {
        [self.toViewController.view removeFromSuperview];
        self.isPresenting = NO;
        [self.transitionContext completeTransition:NO];
    }else{
        self.isPresenting = YES;
        [self.transitionContext completeTransition:YES];
    }
}

#pragma mark - UINavigationController Delegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if(([fromVC conformsToProtocol:@protocol(ZoomTransitionProtocol)] && [toVC conformsToProtocol:@protocol(ZoomTransitionProtocol)]))
    {
        BOOL isApply =
        (![fromVC respondsToSelector:@selector(shouldApplyZoomOutAnimation)] ||
         [fromVC performSelector:@selector(shouldApplyZoomOutAnimation)]) &&
        (![toVC respondsToSelector:@selector(shouldApplyZoomOutAnimation)] ||
         [toVC performSelector:@selector(shouldApplyZoomOutAnimation)]);
        
        return (isApply)? self:nil;
    }
    
    return nil;
}


@end
