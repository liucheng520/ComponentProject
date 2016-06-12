//
//  InPutview.m
//  HXAXProject
//
//  Created by 苏荷 on 15/7/6.
//  Copyright (c) 2015年 BlueMobi. All rights reserved.
//

#import "LoginInPutview.h"

#define kLoginfont [UIFont systemFontOfSize:15.0f]

@interface LoginInPutview()

//the TextField
@property (nonatomic,strong) UITextField *textField;

//左侧提示图片
@property (nonatomic,strong) UIImageView *leftImageView;

//背景图片
@property (nonatomic,strong) UIImageView *backGroundImageView;

//下划线
@property (nonatomic,strong) UIImageView *underLine;

@end

@implementation LoginInPutview

+ (LoginInPutview *)inputViewWithContainer:(UIView *)container delegate:(id<UITextFieldDelegate>)delegate
{
    LoginInPutview *inputView = [[LoginInPutview alloc] init];
    inputView.textField.delegate = delegate;
    [container addSubview:inputView];
    return inputView;
}

#pragma mark - 添加子视图
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.backGroundImageView];
        [self.backGroundImageView addSubview:self.textField];
        [self.backGroundImageView addSubview:self.leftImageView];
    }
    return self;
}

- (NSString *)getTheInputString
{
    return [self.textField.text cutwhitespace];
}

- (void)setType:(LoginInPutType)type
{
    _type = type;
}

#pragma mark - 设置frame
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - lazy UI
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        UIImageView *leftSpace = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _textField.leftView = leftSpace;
        _textField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}

- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftImageView;
}

- (UIImageView *)backGroundImageView
{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc]init];
        _backGroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _backGroundImageView;
}

- (UIImageView *)underLine
{
    if (!_underLine) {
        _underLine = [[UIImageView alloc]init];
        _underLine.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _underLine;
}

@end
