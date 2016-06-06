//
//  BaseManger.m
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "BaseManger.h"
#import "GuideViewController.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import "MainTabBarController.h"

@implementation BaseManger

+ (void)setTheRootviewController
{
    //判断是否第一次启动
    NSNumber *launch = [[NSUserDefaults standardUserDefaults] objectForKey:@"launch"];
    
    //包含游客模式
    if (!launch) {
        
        //第一次登陆显示引导页面，并记录已经显示过引导页
        [[UIApplication sharedApplication].keyWindow setRootViewController:[[GuideViewController alloc] init]];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:1] forKey:@"launch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        
        //确定非一次登录 RootviewController
        if ([[UserInfoModel sharedInstance] isLoggedIn]) {
            
            [[UIApplication sharedApplication].keyWindow setRootViewController:[[MainTabBarController alloc] init]];
        }else{
            //显示状态栏
            LoginViewController *login = [[LoginViewController alloc] init];
            [[UIApplication sharedApplication].keyWindow setRootViewController:login];
        }
    }
}

/**
 *  自己添加设置，类似 SVProgressHUD等相关设置
 */
+ (void)setGenericProperties
{
    
}

@end
