//
//  AdImageManger.h
//  ZJBuildingProject
//
//  Created by Scott on 16/4/5.
//  Copyright © 2016年 bluemobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertImageManger : NSObject

/**
 *  单例
 */
+ (instancetype)sharedManager;

/**
 *  更新广告图片
 */
- (void)updateAdvertImage;

/**
 *  检查是否有已缓存图片
 */
- (UIImage *)avaliableAdvertImage;

/**
 *  获取缓存title
 */
- (NSString *)advertTitle;

/**
 *  获取缓存url
 */
- (NSString *)advertUrl;

@end


/**
 *  服务器 图片返回model
 */
@interface AdvertModel : NSObject

@property (nonatomic, copy) NSString  *ADId;  /**<广告Id*/
@property (nonatomic, copy) NSString  *state ;  /**<状态*/
@property (nonatomic, copy) NSString  *imgurl ;  /**<图片路径*/

@property (nonatomic,copy) NSString *ADTitle; /**<这一广告对应的广告标题*/
@property (nonatomic, copy) NSString *ADUrl; /**<这一广告对应的广告路径*/

@end

/**
 *  广告图片获取方法
 */
@interface AdvertImgTool : NSObject

+ (void)getAdvertImageWithSuccess:(void (^)(BOOL isSuc,id json))success;

@end
