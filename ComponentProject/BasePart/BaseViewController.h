//
//  BaseViewController.h
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  添加主视图方法
 */
- (void)createContentView;

/**
 *  设置导航栏按钮内容
 */
- (void)setNavigationItem;

/**
 *  导航栏透明
 */
- (void)setNavigationBarTransparent;

/**
 *  恢复导航栏颜色
 */
- (void)resetNavigationBar;

@end
