//
//  GuideViewController.m
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "GuideViewController.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIButton *entranceButton;

@end

@implementation GuideViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 *  添加主要视图
 */
- (void)createContentView{
    
    //大的scrollView
    CGRect bounds =[UIScreen mainScreen ].bounds;
    
    _scrollView = [ [UIScrollView alloc ] initWithFrame:bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.delaysContentTouches = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加引导也图片
    NSArray *imgs = @[@"guide-1",@"guide-2",@"guide-3",@"guide-4"];
    
    for (NSInteger i = 0; i < imgs.count; i++) {
        
        UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"guide-1"]];
        imgV.frame = CGRectMake(KScreenWidth * i, 0, KScreenWidth, KScreenHeight);
        [_scrollView addSubview:imgV];
    }
    
    //设置scrollView的contentSize
    _scrollView.contentSize = CGSizeMake(KScreenWidth * imgs.count, KScreenHeight);
    
    //添加欢迎体检按钮
    [_scrollView addSubview:self.entranceButton];
    
    [self.view addSubview:_scrollView];
}

/**
 *  登录界面跳转／tabbar跳转
 */
- (void)entranceButtonClick
{
    [[UIApplication sharedApplication].keyWindow setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]]];
}

/**
 *  多手势识别
 */
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return  YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int num = scrollView.contentOffset.x;
    
    if(num>KScreenWidth*2){ //滑动进入
        
      [[UIApplication sharedApplication].keyWindow setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]]];
    }
}

/**
 *  lazy entranceButton
 */
- (UIButton *)entranceButton
{
    if (!_entranceButton) {
        _entranceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_entranceButton setTitle:@"欢迎体验" forState:UIControlStateNormal];
        [_entranceButton addTarget:self action:@selector(entranceButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_entranceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_entranceButton setBackgroundColor:DEF_COLOR(55, 108, 227)];
        [_entranceButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [_entranceButton setFrame:CGRectMake(0, 0, KScreenWidth * 0.45, 44)];
        _entranceButton.layer.cornerRadius = 5.0f;
        _entranceButton.layer.masksToBounds = YES;
        [_entranceButton setCenter:CGPointMake(KScreenWidth * 2.5, KScreenHeight * 0.85)];
    }
    return _entranceButton;
}

@end
