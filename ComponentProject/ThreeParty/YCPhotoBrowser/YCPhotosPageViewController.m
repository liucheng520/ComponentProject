//
//  YCImagePagesViewController.m
//  俄官方的方式提供撒
//
//  Created by Scott on 15/12/25.
//  Copyright © 2015年 bluemobi. All rights reserved.
//

#import "YCPhotosPageViewController.h"


@interface YCPhotosPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIGestureRecognizerDelegate>

@property (assign, nonatomic) NSUInteger startIndex;
@property (assign, nonatomic) NSUInteger currentIndex;

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, assign) BOOL isStatusbarHiden;
@property (nonatomic, weak) YCImageViewController *currentViewController;

@end

@implementation YCPhotosPageViewController

- (instancetype)initWithPhotos:(NSArray *)photos currentIndex:(NSInteger)curIndex
{
    self = [super init];
    if(self)
    {
        self.photos = [NSMutableArray arrayWithArray:photos];
        self.currentIndex = curIndex;
    }
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)prefersStatusBarHidden
{
    return self.isStatusbarHiden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return  UIStatusBarAnimationSlide;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = _isStatusbarHiden?[UIColor blackColor]:[UIColor whiteColor];

    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{ UIPageViewControllerOptionInterPageSpacingKey:[NSNumber numberWithFloat:20]}];
    self.pageController.delegate = self;
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:self.view.bounds];
    
    YCImageViewController *initialViewController = [self imageViewControllerAtIndex:_currentIndex];
    self.currentViewController = initialViewController;
    
    [self.pageController setViewControllers:@[initialViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
    
    if(self.needsShowToolBar)
    {
        [self.view addSubview:self.toolbar];
    }
    
    [self refreshNavigationTitle];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapNotifiaction:) name:YCPhotoSingleTapNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageViewDidScalling:) name:YCPhotoScallingNotification object:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    if(self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.isStatusbarHiden = NO;
        [self setNeedsStatusBarAppearanceUpdate];
    }
}


- (void)refreshNavigationTitle
{
    self.navigationItem.title = [NSString stringWithFormat:@"%@ / %@",@(_currentIndex + 1),@(_photos.count)];
}

#pragma mark - UIGesture  Action
- (void)tapNotifiaction:(NSNotification *)noti
{
    self.isStatusbarHiden = !self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:_isStatusbarHiden animated:NO];
    [self setNeedsStatusBarAppearanceUpdate];
    [self setToolbarHidden:_isStatusbarHiden animation:YES];
    [UIView animateWithDuration:0.2 animations:^{
        self.view.backgroundColor = _isStatusbarHiden?[UIColor blackColor]:[UIColor whiteColor];
    }];
}

- (void)imageViewDidScalling:(NSNotification *)noti
{
    if(self.isStatusbarHiden) return;
    [self tapNotifiaction:nil];
}


- (void)setToolbarHidden:(BOOL)hidden animation:(BOOL)animated
{
    if(!self.needsShowToolBar) return;
    
    CGRect newRect = self.toolbar.frame;
    newRect.origin.y = (hidden)?self.view.bounds.size.height:self.view.bounds.size.height - self.toolbar.frame.size.height;
    if(animated){
        [UIView animateWithDuration:0.2 animations:^{
            self.toolbar.frame = newRect;
        }];
    }else{
        self.toolbar.frame = newRect;
    }
}


#pragma mark - ZoomTransitionProtocol
- (UIView *)viewForTransition
{
    UIView *v = [self.currentViewController viewForTransition];
    
    return v;
}


- (BOOL)shouldApplyZoomOutAnimation
{
    return  (self.photos.count > 0)? YES:NO;
}


#pragma mark - UIPageViewController Delegate
- (YCImageViewController *)imageViewControllerAtIndex:(NSInteger)index
{

    YCImageViewController *childImageViewController = [[YCImageViewController alloc] initWithPhoto:[self.photos objectAtIndex:index]];
    childImageViewController.index = index;
    
    return childImageViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [(YCImageViewController *)viewController index];
    if(index == 0)
    {
        return nil;
    }
    index --;
    
    return [self imageViewControllerAtIndex:index];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
 
    NSUInteger index = [(YCImageViewController *)viewController index];
    
    index++;
    if (self.photos && index==[self.photos count]) {
        return nil;
    }
    return [self imageViewControllerAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed)
    {
        self.currentViewController = [pageViewController.viewControllers lastObject];
        self.currentIndex = [_currentViewController index];
        [self refreshNavigationTitle];
        
        if([self.delegate respondsToSelector:@selector(PhotosPageViewControlller:didChangedIndex:)])
        {
            [self.delegate PhotosPageViewControlller:self didChangedIndex:self.currentIndex];
        }
        
    }
}


#pragma mark - lazy load
- (UIToolbar *)toolbar
{
    if(!_toolbar)
    {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44)];
        
    }
    return _toolbar;
}


@end
