//
//  MainTabBarController.m
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseViewController.h"
#import "BaseNavigationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addChildViewControllers];
}

- (void)addChildViewControllers
{
    //日常
    [self addChildContrllerWith:@"CSDailyController" title:@"日常" imageName:@"tabbar_daily_unSelect" selectImageName:@"tabbar_daily_select"];
    //通讯录
    [self addChildContrllerWith:@"CSAddressListController" title:@"通讯录" imageName:@"tabbar_addList_unSelect" selectImageName:@"tabbar_addList_select"];
    //我
    [self addChildContrllerWith:@"CSPersonalController" title:@"我" imageName:@"tabbar_self_unSelect" selectImageName:@"tabbar_self_select"];
}

- (void)addChildContrllerWith:(NSString *)controllerName title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImgName
{
    Class cls = NSClassFromString(controllerName);
    BaseViewController *controller = [[cls alloc] init];
    self.tabBar.tintColor = [UIColor blackColor];
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.title = title;
    
    BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:navi];
}



@end
