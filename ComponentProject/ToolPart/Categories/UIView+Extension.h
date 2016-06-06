//
//  UIView+Extension.h
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;



//add by Scott
/**
 *  画一条虚线
 *
 *  @param lineSpacing 虚线的间隔
 *  @param lineColor   虚线的颜色
 */
- (void)drawDashLineWithLineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

@end
