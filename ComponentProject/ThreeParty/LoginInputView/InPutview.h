//
//  InPutview.h
//  HXAXProject
//
//  Created by 苏荷 on 15/7/6.
//  Copyright (c) 2015年 BlueMobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InPutview : UIView

- (instancetype)initWithFrame:(CGRect)frame leftImage:(NSString *)imageName placeHolder:(NSString *)placeHolder;

- (instancetype)initWithFrame:(CGRect)frame upString:(NSString *)upStr placeHolder:(NSString *)placeHolder bgImg:(NSString *)imageName;

@property (nonatomic,weak) UITextField *textField;

@end
