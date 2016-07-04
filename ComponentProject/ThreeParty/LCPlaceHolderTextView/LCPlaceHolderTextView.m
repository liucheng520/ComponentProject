//
//  LCPlaceHolderTextView.m
//  CSCECProject
//
//  Created by 刘成 on 16/4/28.
//  Copyright © 2016年 WaterBearStudio. All rights reserved.
//

#import "LCPlaceHolderTextView.h"

@interface LCPlaceHolderTextView()

@property (nonatomic,weak) UILabel *placeHolderLabel;

@end

@implementation LCPlaceHolderTextView


- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.textContainerInset = UIEdgeInsetsMake(5, 8, 5, 5);
        [self setNotification];
        
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.font = [UIFont systemFontOfSize:13.0f];
        placeHolderLabel.backgroundColor = [UIColor clearColor];
        placeHolderLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:placeHolderLabel];
        placeHolderLabel.userInteractionEnabled = NO;
        self.placeHolderLabel = placeHolderLabel;

        [self setNotification];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    self.placeHolderLabel.hidden = (text.length > 0);
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeHolderLabel.text = placeholder;
    self.placeHolderLabel.hidden = (self.text.length > 0);
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    self.placeHolderLabel.textColor = _placeHolderColor;
}

- (void)setPlaceHolderFont:(UIFont *)placeHolderFont
{
    _placeHolderFont = placeHolderFont;
    self.placeHolderLabel.font = _placeHolderFont;
}

- (void)setNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editing:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)editing:(NSNotification*)notification
{
    self.placeHolderLabel.hidden = (self.text.length > 0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeHolderLabel.frame = CGRectMake(self.textContainerInset.left + 4, self.textContainerInset.top, self.width - self.textContainerInset.left * 2, 15);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
