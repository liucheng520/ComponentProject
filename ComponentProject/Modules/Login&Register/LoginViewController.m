//
//  LoginViewController.m
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginInPutview.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic,weak) LoginInPutview *userName;

@property (nonatomic,weak) LoginInPutview *passWord;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)createContentView
{
    //用户名
    self.userName = [LoginInPutview inputViewWithContainer:self.view delegate:self];
    self.userName.frame = CGRectMake(0, 200, KScreenWidth, 60);
    self.userName.placeHolder = @"请输入手机号";
    self.userName.imageString = @"login_phone";
    self.userName.type = LoginInPutTypeUserName_Line;
    
    //用户名
    self.passWord = [LoginInPutview inputViewWithContainer:self.view delegate:self];
    self.passWord.frame = CGRectMake(0, CGRectGetMaxY(self.userName.frame), KScreenWidth, 60);
    self.passWord.placeHolder = @"请输入密码(6-16个字符)";
    self.passWord.imageString = @"login_password";
    self.passWord.type = LoginInPutTypePassWord_Line;
}

#pragma mark - 控制导航栏的显示和隐藏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarTransparent];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self resetNavigationBar];
}

@end
