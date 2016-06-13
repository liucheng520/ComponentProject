//
//  UIImage+Extention.m
//  A01-QQ聊天
//
//  Created by Steve Xiaohu Zhao on 14-11-29.
//  Copyright (c) 2014年 Steve Xiaohu Zhao. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)

- (UIImage *)circleImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)resizeImage:(NSString *)imgName
{
    UIImage *img = [UIImage imageNamed:imgName];
    return [img stretchableImageWithLeftCapWidth:img.size.width / 2 topCapHeight:img.size.height / 2];
}


+ (instancetype)image:(UIImage *)image borderWith:(CGFloat)borderWith borderColor:(UIColor *)borderColor
{
    // 1. 创建一个bitmap图形上下文
    CGSize size = CGSizeMake(image.size.height + borderWith, image.size.height + borderWith);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0); //  YES：不透明 NO:透明
    
    // 2. 获得当前的图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 是否开启反锯齿
//    CGContextSetShouldAntialias(ctx, YES);
 
    
    // 3. 绘制大圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, size.width, size.height));
    [borderColor set];
    CGContextFillPath(ctx);
    
    // 4. 绘制小圆
    CGFloat smallX = borderWith;
    CGFloat smallY = borderWith;
    CGFloat smallW = size.width - 2 * borderWith;
    CGFloat smallH = size.height - 2 * borderWith;
    
    CGContextAddEllipseInRect(ctx, CGRectMake(smallX, smallY, smallW, smallH));
    //       CGContextFillPath(ctx);
    // 4.1 指定可以绘图的范围, 这个只会影响后面再绘制的图片
    CGContextClip(ctx);
    
    // 5. 绘制图片
    [image drawInRect:CGRectMake(smallX, smallY, smallW, smallH)];
    
    // 6. 取出yuan图片
    UIImage *lastImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7. 关闭图形上下文
    UIGraphicsEndImageContext();
    
    // 8. 返回
    return lastImage;
}

+ (void)writeImageToFileWithImage:(UIImage *)image fileName:(NSString *)fileName
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data", fileName]];
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
}

+ (UIImage *)getImageFromFileWithFileName:(NSString *)fileName
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data", fileName]];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [UIImage imageWithData:data];
}

+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = width/5.0;
    CGFloat targetHeight = height/5.0;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
