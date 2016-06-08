//
//  InPutview.m
//  HXAXProject
//
//  Created by 苏荷 on 15/7/6.
//  Copyright (c) 2015年 BlueMobi. All rights reserved.
//

#import "InPutview.h"

#define kLoginfont [UIFont systemFontOfSize:15.0f]

@interface InPutview()

@property (nonatomic,weak) UIImageView *underLine;

@property (nonatomic,weak) UIImageView *leftImagev;

@property (nonatomic,weak) UILabel *upLabel;

@property (nonatomic,weak) UIImageView *bgImagev;

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,weak) UIImageView *spaceImge;

@end

@implementation InPutview

- (instancetype)initWithFrame:(CGRect)frame leftImage:(NSString *)imageName placeHolder:(NSString *)placeHolder
{
    if (self = [super initWithFrame:frame]) {
        [self creatTheSubviewsWithleftImage:imageName placeHolder:placeHolder upString:nil type:0];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame upString:(NSString *)upStr placeHolder:(NSString *)placeHolder bgImg:(NSString *)imageName
{
    if (self = [super initWithFrame:frame]) {
        [self creatTheSubviewsWithleftImage:imageName placeHolder:placeHolder upString:upStr type:1];
    }
    return self;
}

#pragma mark - 添加子视图
- (void)creatTheSubviewsWithleftImage:(NSString *)imageName placeHolder:(NSString *)placeHolder upString:(NSString *)upStr type:(NSInteger)type
{
    self.type = type;
    if (type) {
        
        //标题
        UILabel *newPwd = [[UILabel alloc]init];
        newPwd.font = [UIFont systemFontOfSize:15.0f];
        newPwd.text = upStr;
        newPwd.textColor = DEF_COLOR(41, 41, 41);
        [self addSubview:newPwd];
        self.upLabel = newPwd;
        
        //背景图片
        UIImageView *bgImagev = [[UIImageView alloc]init];
//        [bgImagev setImage:[UIImage imageNamed:imageName]];
        [bgImagev setBackgroundColor:[UIColor whiteColor]];
        bgImagev.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:bgImagev];
        bgImagev.userInteractionEnabled = YES;
        self.bgImagev = bgImagev;
        
        //textfield
        UITextField *textField = [[UITextField alloc]init];
        [bgImagev addSubview:textField];
        textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:placeHolder attributes:@{NSForegroundColorAttributeName:DEF_COLOR(200, 200, 200)}];
        textField.font = kLoginfont;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        textField.textColor = [UIColor whiteColor];
        UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        textField.leftView = left;
        textField.leftViewMode = UITextFieldViewModeAlways;
        self.textField = textField;
        
        //分割图片
        UIImageView *spaceImge = [[UIImageView alloc]init];
        [spaceImge setImage:[UIImage imageNamed:@"login_findPWD_space"]];
        [bgImagev addSubview:spaceImge];
        spaceImge.userInteractionEnabled = YES;
        self.spaceImge = spaceImge;

    }else{
        //左边图片
        UIImageView *leftImagev = [[UIImageView alloc]init];
        [leftImagev setImage:[UIImage imageNamed:imageName]];
        leftImagev.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:leftImagev];
        self.leftImagev = leftImagev;
        
        //textfield
        UITextField *textField = [[UITextField alloc]init];
        [self addSubview:textField];
        textField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:placeHolder attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        textField.font = kLoginfont;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.textColor = [UIColor whiteColor];
        self.textField = textField;
        
        //背景图片
        UIImageView *underLine = [[UIImageView alloc]init];
        [underLine setImage:[UIImage imageNamed:@"login_textField_underLine"]];
        [self addSubview:underLine];
        self.underLine = underLine;
        
        //分割图片
        UIImageView *spaceImge = [[UIImageView alloc]init];
        [spaceImge setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:spaceImge];
        spaceImge.userInteractionEnabled = YES;
        self.spaceImge = spaceImge;
    }
}

#pragma mark - 设置frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.type) {
        CGFloat leftMargin = 10.0f;
        self.upLabel.frame = CGRectMake(leftMargin, 0, self.width, self.height * 0.33);
        self.bgImagev.frame = CGRectMake(0, CGRectGetMaxY(self.upLabel.frame) + self.height * 0.03, self.width, self.height * 0.64);
        
        self.textField.frame = CGRectMake(0, 0, self.width, self.height * 0.64);
        if ([self.upLabel.text isEqualToString:@"短信验证码："]) {
            self.textField.frame = CGRectMake(0, 0, self.width * 0.65, self.height * 0.64);
            self.spaceImge.frame = CGRectMake(CGRectGetMaxX(self.textField.frame) + 5,self.height * 0.15 , 1.5, self.height * 0.34);
        }
        
    }else{
        CGFloat leftMargin = 15.0f;
        CGFloat upMargin = (self.height - self.leftImagev.image.size.height)*0.5;
        
        self.underLine.frame = CGRectMake(0, self.height - 1, self.width, 1);
        self.leftImagev.frame = CGRectMake(leftMargin, upMargin, self.leftImagev.image.size.width, self.leftImagev.image.size.height);
        
        self.textField.frame = CGRectMake(2 * leftMargin + 16.5, 0, self.width - leftMargin * 2 - self.leftImagev.image.size.width, self.height);
        
        
        if ([self.textField.placeholder isEqualToString:@"请输入短信验证码"]) {
            self.textField.frame = CGRectMake(2 * leftMargin + 16.5, 0, (self.width - leftMargin * 2 - self.leftImagev.image.size.width) * 0.6, self.height);
            
            self.spaceImge.frame = CGRectMake(CGRectGetMaxX(self.textField.frame) + 5,self.height * 0.3 , 1.5, self.height * 0.4);
        }
    }
}

@end
