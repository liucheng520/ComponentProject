 //
//  UIBarButtonItem+MJ.m
//  ItcastWeibo
//
//  Created by apple on 14-5-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIBarButtonItem+MJ.h"

@implementation UIBarButtonItem (MJ)

// left
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

// right title
+ (UIBarButtonItem *)rightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button sizeToFit];
    button.frame = (CGRect){CGPointZero, button.frame.size.width, button.frame.size.height};
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

// Left  title
+ (UIBarButtonItem *)leftItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button sizeToFit];
    button.frame = (CGRect){CGPointZero, button.frame.size.width, button.frame.size.height};
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)leftItemWithTitle:(NSString *)title Icon:(NSString *)icon target:(id)target action:(SEL)action
{
    RightImageBtn *button = [[RightImageBtn alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button sizeToFit];
    button.frame = (CGRect){CGPointZero, button.frame.size.width*1.2, button.frame.size.height};
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)leftChangeItemWithTitle:(NSString *)title Icon:(NSString *)icon target:(id)target action:(SEL)action
{
    RightImageBtn *button = [[RightImageBtn alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:DEF_COLOR(220, 33, 43) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button sizeToFit];
    CGSize size = [title sizeOfMaxSize:CGSizeMake(1000, button.frame.size.height) fontSize:14.0f];
    button.frame = (CGRect){CGPointZero, size.width + 25, button.frame.size.height};
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end

@implementation RightImageBtn

- (instancetype)init
{
    if (self = [super init]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

////系统中的设置按钮的标题和图片的坐标的方法
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(0, 0, self.width -25, self.height);
//}
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    return  CGRectMake(self.width -20, 5, 15, 8);
//}

@end

