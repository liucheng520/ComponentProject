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
#import "AddPictureViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

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
    //1
    [self addChildContrllerWith:@"FirstViewController" title:@"First" imageName:@"tab_consult" selectImageName:@"tab_consult_select"];
    
    //2
    [self addChildContrllerWith:@"SecondViewController" title:@"Second" imageName:@"tab_homePage" selectImageName:@"tab_homePage_select"];
    
    //3
    [self addChildContrllerWith:@"ThirdViewController" title:@"Third" imageName:@"tab_myCenter" selectImageName:@"tab_myCenter_select"];
    
    //4
    [self addChildContrllerWith:@"FourthViewController" title:@"Fourth" imageName:@"tab_order" selectImageName:@"tab_order_select"];
}

- (void)addChildContrllerWith:(NSString *)controllerName title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImgName
{
    Class cls = NSClassFromString(controllerName);
    BaseViewController *controller = [[cls alloc] init];
    self.tabBar.tintColor = [UIColor blackColor];
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.title = title;
    
    controller.title = title;
    BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:navi];
}



@end
