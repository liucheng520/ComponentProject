//
//  InPutview.h
//  HXAXProject
//
//  Created by 苏荷 on 15/7/6.
//  Copyright (c) 2015年 BlueMobi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LoginInPutType) {
    LoginInPutTypeUserName_Line = 1, //下滑线
    LoginInPutTypePassWord_Line,
    LoginInPutTypeUserName_BackGroundImage, //背景图片
    LoginInPutTypePassWord_BackGroundImage,
};

@interface LoginInPutview : UIView

/**
 *  create inputView
 *
 *  @return LoginInPutview
 */
+ (LoginInPutview *)inputViewWithContainer:(UIView *)container delegate:(id<UITextFieldDelegate>)delegate;

/**
 *  set the inputType
 */
@property (nonatomic,assign) LoginInPutType type;

/**
 *  set the loginInputView backGroundImage
 */
@property (nonatomic,copy) NSString *backGroundImgString;

/**
 *  set the promt image
 */
@property (nonatomic,copy) NSString *imageString;

/**
 *  set placeHolder
 */
@property (nonatomic,copy) NSString *placeHolder;

/**
 *  set font
 */
@property (nonatomic,strong) UIFont *font;

/**
 *  set the textFild textColor
 */
@property (nonatomic,strong) UIColor *textColor;

/**
 *  set the placeHolder color
 */
@property (nonatomic,strong) UIColor *placeHolderColor;

- (NSString *)getTheInputString;

@end
