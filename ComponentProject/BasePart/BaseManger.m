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
#import "UserInfoModel.h"
#import "AdvertImageShowView.h"

@implementation BaseManger

+ (void)setTheRootviewController
{
    NSString *key = @"CFBundleShortVersionString";
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];

    if ([currentVersion isEqualToString:sanboxVersion]) {
        
        if (YES) {
            
            [[UIApplication sharedApplication].keyWindow setRootViewController:[[MainTabBarController alloc] init]];
            
            //展示广告页
            [AdvertImageShowView startAdvertViewOnContainer:[UIApplication sharedApplication].keyWindow.rootViewController.view];
            
        }else{//若包含游客模式 － 此处

            //显示状态栏
            BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
            [[UIApplication sharedApplication].keyWindow setRootViewController:navi];
            
            //登录界面，不需要显示广告页，若没次都要登录，可添加
            [[AdvertImageManger sharedManager] updateAdvertImage];
        }
    }else{
        
         //第一次打开应用，缓存图片，不需要展示
         [[AdvertImageManger sharedManager] updateAdvertImage];
        
        //第一次登陆显示引导页面，并记录已经显示过引导页
        [[UIApplication sharedApplication].keyWindow setRootViewController:[[GuideViewController alloc] init]];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

/**
 *  自己添加设置，类似 SVProgressHUD等相关设置
 */
+ (void)setGenericProperties
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                [SVProgressHUD showImage:nil status:@"未知网络"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                [SVProgressHUD showErrorWithStatus:@"没有网络(断网)"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                //                [SVProgressHUD showSuccessWithStatus:@"手机自带网络"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
        
                //                [SVProgressHUD showSuccessWithStatus:@"WIFI"];
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
}

@end
