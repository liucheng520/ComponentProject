//
//  UIImageView+Extention.h
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UIImageView (Extention)

#pragma mark - 包装SDWebImage
- (void)lc_setImageWithURL:(NSURL *)url;

- (void)lc_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

@end