//
//  InPutview.m
//  HXAXProject
//
//  Created by 苏荷 on 15/7/6.
//  Copyright (c) 2015年 BlueMobi. All rights reserved.
//

#import "LoginInPutview.h"

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
        [self addSubview:self.underLine];
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
    
    switch (_type) {
        case LoginInPutTypeUserName_Line:
        {
            [self.underLine setBackgroundColor:[UIColor whiteColor]];
            [self.backGroundImageView setBackgroundColor:[UIColor clearColor]];
            self.textField.returnKeyType = UIReturnKeyNext;
        }
            break;
        case LoginInPutTypePassWord_Line:
        {
            [self.underLine setBackgroundColor:[UIColor whiteColor]];
            [self.backGroundImageView setBackgroundColor:[UIColor clearColor]];
            self.textField.returnKeyType = UIReturnKeyDone;
            self.textField.secureTextEntry = YES;
        }
            break;
        case LoginInPutTypeUserName_BackGroundImage:
        {
            [self.underLine setBackgroundColor:[UIColor clearColor]];
            [self.backGroundImageView setImage:[UIImage imageNamed:self.backGroundImgString]];
            self.textField.returnKeyType = UIReturnKeyNext;
        }
            break;
        case LoginInPutTypePassWord_BackGroundImage:
        {
            [self.underLine setBackgroundColor:[UIColor whiteColor]];
            [self.backGroundImageView setImage:[UIImage imageNamed:self.backGroundImgString]];
             self.textField.returnKeyType = UIReturnKeyDone;
            self.textField.secureTextEntry = YES;
        }
            break;
            
        default:
            break;
    }
}

- (void)setBackGroundImgString:(NSString *)backGroundImgString
{
    _backGroundImgString = backGroundImgString;
    [self.backGroundImageView setImage:[UIImage imageNamed:_backGroundImgString]];
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    self.textField.keyboardType = keyboardType;
}

- (void)setImageString:(NSString *)imageString
{
    _imageString = imageString;
    [self.leftImageView setImage:[UIImage imageNamed:_imageString]];
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    self.textField.placeholder = _placeHolder;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    self.textField.font = _font;
    self.textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeHolder attributes:@{NSFontAttributeName:_font}];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textField.textColor = _textColor;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    self.textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeHolder attributes:@{NSForegroundColorAttributeName:_placeHolderColor}];
}

#pragma mark - 设置frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backGroundImageView.frame = self.bounds;

    CGFloat upMargin = (self.height - self.leftImageView.image.size.height)*0.5;
    self.leftImageView.frame = CGRectMake(LOGIN_LEFT_MARGIN + 10, upMargin, self.leftImageView.image.size.width, self.leftImageView.image.size.height);
    self.underLine.frame = CGRectMake(LOGIN_LEFT_MARGIN, self.height - 1, self.width - LOGIN_LEFT_MARGIN * 2, 1);
    self.textField.frame = CGRectMake(CGRectGetMaxX(self.leftImageView.frame) + 5, 0, self.width - LOGIN_LEFT_MARGIN * 3 - self.leftImageView.size.width - 5, self.height);
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
        _backGroundImageView.userInteractionEnabled = YES;
    }
    return _backGroundImageView;
}

- (BOOL)becomeFirstResponder
{
    [self.textField becomeFirstResponder];
    return YES;
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
