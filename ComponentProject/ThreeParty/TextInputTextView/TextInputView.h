//
//  TextInputView.h
//  YBKProject
//
//  Created by 刘成 on 16/5/18.
//  Copyright © 2016年 bluemobi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kNotificationTextHeightChange @"textHeightChange"
#define kNotificaitonBecomeFirstResposer @"becomeFirstresponse"
#define kNotificaitonResigsterFirstResposer @"ResigsterFirstresponse"

typedef void(^SendButtonBlock)(NSString *text);

@interface TextInputView : UIView

/**
 *  create the textInputView
 *
 *  @return TextInputView
 */
+ (TextInputView *)textInputView;

/**
 *  get the text write on the textView
 */
@property (nonatomic,copy) NSString *text;

/**
 *  set sendButton message by yourself
 */
@property (nonatomic,strong) UIButton *sendButton;

/**
 *  cilck the send button block
 */
@property (nonatomic,copy) SendButtonBlock buttonClickBlock;

/**
 *  textView PlaceHolder,normal is nil
 */
@property (nonatomic,copy) NSString *placeHolder;

/**
 *  set text Color,normal is r:50 g:50 b:50
 */
@property (nonatomic,strong) UIColor *textColor;

/**
 *  set placeHolder Color,normal is grayColor
 */
@property (nonatomic,strong) UIColor *placeHolderColor;

/**
 *  set textView BackgroundImage, normal is lightgray color
 */
@property (nonatomic,copy) NSString *backGroundImg;

/**
 *  set textInputView BackgroundImage, normal is white color
 */
@property (nonatomic,copy) NSString *viewBackGroundImg;

@end

