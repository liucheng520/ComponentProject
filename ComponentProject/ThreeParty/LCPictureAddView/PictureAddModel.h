//
//  PictureAddModel.h
//  ComponentProject
//
//  Created by 刘成 on 16/6/15.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureAddModel : NSObject

/**
 *  如果isHttpImage 为YES
 */
@property (nonatomic,assign) BOOL isHttpImage;

@property (nonatomic,copy) NSString *imageName;

@property (nonatomic,copy) NSString *imageUrl;

@property (nonatomic,copy) NSString *title;

@end

