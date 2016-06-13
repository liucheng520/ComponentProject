//
//  UIImage+Extention.h
//  A01-QQ聊天
//
//  Created by Steve Xiaohu Zhao on 14-11-29.
//  Copyright (c) 2014年 Steve Xiaohu Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extention)

- (UIImage *)circleImage;

/**
 *  图片拉伸
 */
+ (UIImage *)resizeImage:(NSString *)imgName;

/**
 *  icon        要裁剪的图片
 *  borderWith  头像边框的宽度
 *  borderColor 边框的颜色
 */
+ (instancetype)image:(UIImage *)image borderWith:(CGFloat)borderWith borderColor:(UIColor *)borderColor;

/**
 *  缓存图片
 */
+ (void)writeImageToFileWithImage:(UIImage *)image fileName:(NSString *)fileName;

/**
 *  取图片
 */
+ (UIImage *)getImageFromFileWithFileName:(NSString *)fileName;

/**
 *  图片缩放
 */
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
