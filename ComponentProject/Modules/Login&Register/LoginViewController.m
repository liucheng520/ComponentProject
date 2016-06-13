//
//  LoginViewController.m
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginInPutview.h"
#import "MainTabBarController.h"
#import "TPKeyboardAvoidingScrollView.h"

//0,默认不选中，1 默认旋踵
#define kRememberButtonTag 1

#define LOGIN_FONT [UIFont systemFontOfSize:15.0f]

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic,weak) LoginInPutview *userName;

@property (nonatomic,weak) LoginInPutview *passWord;

@property (nonatomic,strong) UIButton *loginButton;

@property (nonatomic,strong) UIButton *rememberButton;

@property (nonatomic,strong) UIButton *forgetPassWordButton;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

#pragma mark - 登录按钮点击
- (void)loginBtnClick
{
    [self.view endEditing:YES];

    NSString *first = [self.userName getTheInputString];
    NSString *second = [self.passWord getTheInputString];
    
    // 1.判断账号，密码是否输入
    if(first.length && second.length){
        
        if ([Check checkPhone:first]) {
            
            //TODO：登录接口
            [UIApplication sharedApplication].keyWindow.rootViewController = [[MainTabBarController alloc] init];
        }else{
            [SVProgressHUD showErrorWithStatus:InPutTheWrongPhoneNumberPromt];
        }
        
    }else{
        
        if (!first.length) {
            
            [SVProgressHUD showErrorWithStatus:NoInputAccountPromt];
            return;
        }
        if (!second.length) {
            
            [SVProgressHUD showErrorWithStatus:NoInputPassWordPromt];
            return;
        }
    }
}

#pragma mark - 记住密码按钮点击
- (void)rememberButtonClick:(UIButton *)btn
{
    [self.view endEditing:YES];
    NSString *imageName = ((btn.tag = !btn.tag) == 0) ? @"remember_unSelect" : @"remember_select";
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

#pragma mark - 忘记密码点击
- (void)forgetButtonClick
{
    [self.view endEditing:YES];
    //TODO:
}

#pragma mark - 注册按钮点击
- (void)registerButtonClick
{
    
}

#pragma mark - 主视图创建
- (void)createContentView
{
    self.title = @"登录";
    
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, KScreenWidth, KScreenHeight)];
    imagev.userInteractionEnabled = YES;
    [imagev setImage:[UIImage imageNamed:@"backGround"]];
    self.view = imagev;
    
    TPKeyboardAvoidingScrollView *bgScrollview = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: bgScrollview];
    
    //用户名
    self.userName = [LoginInPutview inputViewWithContainer:bgScrollview delegate:self];
    self.userName.frame = CGRectMake(0, 100, KScreenWidth, 60);
    self.userName.placeHolder = @"请输入手机号";
    self.userName.imageString = @"login_phone";
    self.userName.font = LOGIN_FONT;
    self.userName.placeHolderColor = [UIColor whiteColor];
    self.userName.textColor = [UIColor whiteColor];
    self.userName.type = LoginInPutTypeUserName_Line;
    self.userName.keyboardType = UIKeyboardTypeNumberPad;
    
    //用户名
    self.passWord = [LoginInPutview inputViewWithContainer:bgScrollview delegate:self];
    self.passWord.frame = CGRectMake(0, CGRectGetMaxY(self.userName.frame), KScreenWidth, 60);
    self.passWord.placeHolder = @"请输入密码(6-16个字符)";
    self.passWord.imageString = @"login_password";
    self.passWord.font = LOGIN_FONT;
    self.passWord.placeHolderColor = [UIColor whiteColor];
    self.passWord.textColor = [UIColor whiteColor];
    self.passWord.type = LoginInPutTypePassWord_Line;
    
    //记住密码按钮
    [bgScrollview addSubview:self.rememberButton];
    
    //忘记密码按钮
    [bgScrollview addSubview:self.forgetPassWordButton];
    
    //登录按钮
    [bgScrollview addSubview:self.loginButton];
}

- (void)setNavigationItem
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rightItemWithTitle:@"注册" target:self action:@selector(registerButtonClick)];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyNext) {
        [self.passWord becomeFirstResponder];
    }else{
        [self.view endEditing:YES];
        [self loginButton];
    }
    return YES;
}

#pragma mark - layz UI
- (UIButton *)rememberButton
{
    if (!_rememberButton) {
        _rememberButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rememberButton setTitle:@"  记住密码" forState:UIControlStateNormal];
        [_rememberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rememberButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_rememberButton.titleLabel setFont:LOGIN_FONT];
        [_rememberButton.imageView sizeToFit];
        [_rememberButton setImage:[UIImage imageNamed:kRememberButtonTag ?@"remember_select":@"remember_unSelect"] forState:UIControlStateNormal];
        _rememberButton.tag = kRememberButtonTag;
        _rememberButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _rememberButton.frame = CGRectMake(LOGIN_LEFT_MARGIN, CGRectGetMaxY(self.passWord.frame) + 10, KScreenWidth * 0.5 - 15, 40);
        [_rememberButton addTarget:self action:@selector(rememberButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _rememberButton;
}

- (UIButton *)forgetPassWordButton
{
    if (!_forgetPassWordButton) {
        _forgetPassWordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetPassWordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        [_forgetPassWordButton.titleLabel setFont:LOGIN_FONT];
        NSString *title = @"忘记密码？";
        
        //直接设置
        [_forgetPassWordButton setTitle:title forState:UIControlStateNormal];
        [_forgetPassWordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //增加下划线
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:title];
        [attri addAttribute:NSUnderlineStyleAttributeName value:@1 range:NSMakeRange(0, title.length)];
        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, title.length)];
        [_forgetPassWordButton setAttributedTitle:attri forState:UIControlStateNormal];
        
        _forgetPassWordButton.frame = CGRectMake(KScreenWidth * 0.5, CGRectGetMaxY(self.passWord.frame) + 10, KScreenWidth * 0.5 - 15, 40);
        
        [_forgetPassWordButton addTarget:self action:@selector(forgetButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPassWordButton;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_button_background"] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.frame = CGRectMake(60, CGRectGetMaxY(self.passWord.frame) + 120, KScreenWidth - 120, 45);
    }
    return _loginButton;
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
