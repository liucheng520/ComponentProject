//
//  BaseViewController.m
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:DEF_COLOR_A(245, 245, 245, 1)];
    
    [self createContentView];
    [self setNavigationItem];
}

- (void)createContentView
{
    
}

- (void)setNavigationItem
{
    
}

- (void)setNavigationBarTransparent
{
    [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor navColor] colorWithAlphaComponent:0]];
}

- (void)resetNavigationBar
{
    [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor navColor] colorWithAlphaComponent:1]];
}

@end
