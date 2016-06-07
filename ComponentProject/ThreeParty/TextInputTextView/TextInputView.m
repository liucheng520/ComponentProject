//
//  TextInputView.m
//  YBKProject
//
//  Created by 刘成 on 16/5/18.
//  Copyright © 2016年 bluemobi. All rights reserved.
//

#import "TextInputView.h"

#define kInputTextViewSpace 10

@interface TextInputView()

@property (nonatomic,strong) UIImageView *viewBackGroundImgv;

@property (nonatomic,strong) UIImageView *backGroudImgv;

@property (nonatomic,strong) UITextView *textView;

@property (nonatomic,strong) UILabel *placeHolderLabel;

@end

@implementation TextInputView

+ (TextInputView *)textInputView
{
    return [[TextInputView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 49)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _textColor = DEF_COLOR(50, 50, 50);
        [self createSubview];
    }
    return self;
}

- (void)createSubview
{
    [self addSubview:self.viewBackGroundImgv];
    [self.viewBackGroundImgv addSubview:self.backGroudImgv];
    [self.backGroudImgv addSubview:self.textView];
    [self.textView addSubview:self.placeHolderLabel];
    [self addSubview:self.sendButton];
    
    [self _freshTheFrameWith:49];

    //监听文本改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
}

//文本修改
- (void)textDidChange:(NSNotification *)notify
{
    //控制placeholder的隐藏
    self.placeHolderLabel.hidden = (self.textView.text.length != 0);
    
    //在text 改变的工程中计算height
    CGFloat height = self.textView.contentSize.height - 8;

    if (height > 18 * 5) {
        height = 18 * 5;
    }
    [self _freshTheFrameWith:31 + height];
    
    //监听文本改变
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTextHeightChange object:@{@"newHeight":@(31 + height)}];
}


- (void)_freshTheFrameWith:(CGFloat)heigth
{
    //frame一定的
    self.viewBackGroundImgv.frame = CGRectMake(0, 0, KScreenWidth, heigth);
    CGFloat buttonWidth = [self.sendButton.currentTitle widthWithFont:self.sendButton.titleLabel.font height:29] + kInputTextViewSpace;
    if(buttonWidth > 80){
        buttonWidth = 80;
    }
    self.sendButton.frame = CGRectMake(0, 0, buttonWidth , 29);
    self.sendButton.center = CGPointMake(KScreenWidth - kInputTextViewSpace - buttonWidth * 0.5, heigth * 0.5);
    
    self.backGroudImgv.frame = CGRectMake(kInputTextViewSpace, kInputTextViewSpace, self.width - 25 - buttonWidth, heigth - 2 * kInputTextViewSpace);
    
    self.textView.frame = CGRectMake(kInputTextViewSpace, 0, self.backGroudImgv.width - kInputTextViewSpace * 2, 18*5 + 8);
    
    self.placeHolderLabel.frame = CGRectMake(kInputTextViewSpace, 0, self.backGroudImgv.width - kInputTextViewSpace * 2, 29);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (NSString *)text
{
    return self.textView.text;
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    self.placeHolderLabel.text = _placeHolder;
}

- (void)setBackGroundImg:(NSString *)backGroundImg
{
    _backGroundImg = backGroundImg;
    self.backGroudImgv.image = [UIImage resizeImage:_backGroundImg];
}

- (void)setViewBackGroundImg:(NSString *)viewBackGroundImg
{
    _viewBackGroundImg = viewBackGroundImg;
    self.viewBackGroundImgv.image = [UIImage resizeImage:_viewBackGroundImg];
}

/**
 *  lazy create all subViews
 */

- (UIImageView *)viewBackGroundImgv
{
    if (!_viewBackGroundImgv) {
        _viewBackGroundImgv = [[UIImageView alloc] init];
        _viewBackGroundImgv.userInteractionEnabled = YES;
    }
    return _viewBackGroundImgv;
}

- (UIImageView *)backGroudImgv
{
    if (!_backGroudImgv) {
        _backGroudImgv = [[UIImageView alloc] init];
        _backGroudImgv.userInteractionEnabled = YES;
    }
    return _backGroudImgv;
}

- (UITextView *)textView
{
    if(!_textView)
    {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont systemFontOfSize:15.0f];
        _textView.textColor = _textColor;
        _textView.textContainerInset = UIEdgeInsetsMake(6, 5, 2, 0);
    }
    return _textView;
}

- (UILabel *)placeHolderLabel
{
    if(!_placeHolderLabel)
    {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.textColor = [UIColor grayColor];
        _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
        _placeHolderLabel.font = [UIFont systemFontOfSize:15.0f];;
    }
    return _placeHolderLabel;
}

- (UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"发布" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"foot_btn_1"] forState:UIControlStateNormal];
        [_sendButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        [_sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (void)sendButtonClick
{
    if (_buttonClickBlock) {
        
        _buttonClickBlock(self.text);
        
        if (self.text.length) {
            self.textView.text = @"";
            self.placeHolderLabel.hidden = NO;
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

