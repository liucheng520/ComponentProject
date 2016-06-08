//
//  PhotoItem.h
//  俄官方的方式提供撒
//
//  Created by Scott on 15/12/25.
//  Copyright © 2015年 bluemobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoItem : NSObject

@property (nonatomic, copy) NSString *url;   /**<图片链接*/
@property (nonatomic, copy) NSString *imageName;   /**<图片名称*/
@property (nonatomic, strong) UIImage *image;         /**<图片对象*/
@property (nonatomic, copy) NSString *placeHolderImage;   /**<默认显示图片名称*/




@end
