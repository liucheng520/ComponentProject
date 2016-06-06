//
//  BaseNavigationController.m
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIPanGestureRecognizer *popRecognizer;

@end

@implementation BaseNavigationController

- (instancetype)init
{
    if (self = [super init]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    return self;
}
/**
 *  当导航控制器的view创建完毕就调用
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}
/**
 *  当第一次使用这个类的时候调用1次
 */
+ (void)initialize
{
    // 设置UINavigationBarTheme的主
    [self setupNavigationBarTheme];
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    appearance.translucent = YES;
    [appearance lt_setBackgroundColor:[UIColor navColor]];
    [appearance setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [appearance setShadowImage:[[UIImage alloc] init]];
    
    //改变导航条上的标题的颜色和字体。
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.0f], NSFontAttributeName,nil]];
    
    // 设置标题文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:17.0];
    [appearance setTitleTextAttributes:attrs];
    
    // 2.设置BarButtonItem的主题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置文字颜色
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14.0f];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    item.tintColor = [UIColor whiteColor];
    
    //可选
    [self setTableViewCellSeperatorStyle];
}

/**
 *  设置table分割线统一样式
 */
+ (void)setTableViewCellSeperatorStyle
{
    //tableViewCell 的分隔线统一设置
    //ios 7:
    [[UITableView appearance] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [[UITableView appearance] setSeparatorInset:UIEdgeInsetsZero];
    
    [[UITableViewCell appearance] setSeparatorInset:UIEdgeInsetsZero];
    
    // iOS 8:
    if ([UITableView instancesRespondToSelector:@selector(setLayoutMargins:)]) {
        
        [[UITableView appearance] setLayoutMargins:UIEdgeInsetsZero];
        [[UITableViewCell appearance] setLayoutMargins:UIEdgeInsetsZero];
        [[UITableViewCell appearance] setPreservesSuperviewLayoutMargins:NO];
    }
}

/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置文字属性
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        backButton.frame =  CGRectMake(0, 0, 45, 30);
        backButton.backgroundColor = [UIColor clearColor];
        [backButton setImage:[UIImage imageNamed:@"navigationBack"]  forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationBack"]  forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.navigationItem.leftBarButtonItem = leftBarButton;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)backButtonClick
{
    [self popViewControllerAnimated:YES];
}

@end
