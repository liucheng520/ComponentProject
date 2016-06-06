//
//  UIImageView+Extention.m
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "UIImageView+Extention.h"

@implementation UIImageView (Extention)

- (void)lc_setImageWithURL:(NSURL *)url
{
    [self sd_setImageWithURL:url];
}

- (void)lc_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self sd_setImageWithURL:url placeholderImage:placeholder];
}

@end
