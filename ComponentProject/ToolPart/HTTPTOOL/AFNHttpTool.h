//
//  AFNHttpTool.h
//  武汉二部iOS基础框架
//
//  Created by 苏荷 on 15/9/23.
//  Copyright (c) 2015年 BlueMobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNHttpTool : NSObject
/**
 *  POST方法
 *
 *  @param method  具体功能对应url
 *  @param param   参数
 *  @param success 成功
 *  @param failure 失败
 */
+ (NSURLSessionDataTask *)POSTWithMethod:(NSString *)method
                Params:(NSDictionary *)param
               success:(void (^)(BOOL isSuc,id json))success
               failure:(void (^)(NSError *error))failure;
/**
 *  POST 上传头像
 *
 *  @param method        具体功能url
 *  @param param         参数
 *  @param heardImage    图片
 *  @param progress      上传进度
 *  @param success       成功
 *  @param failure       失败
 */

+ (NSURLSessionDataTask *)POSTWithMethod:(NSString *)method
                Params:(NSDictionary *)param
            heardImage:(UIImage *)heardImage
          imageKeyName:(NSString *)keyName
              progress:(void (^)(NSProgress * uploadProgress))progress
               success:(void (^)(BOOL isSuc,id json))success
               failure:(void (^)(NSError *))failure;
/**
 *  POST 上传多张图片
 *
 *  @param method   具体功能url
 *  @param param    参数
 *  @param imageArr 图片(多张)
 *  @param progress      上传进度
 *  @param progress      上传进度
 *  @param success  成功
 *  @param failure  失败
 */
+ (NSURLSessionDataTask *)POSTWithMethod:(NSString *)method
                Params:(NSDictionary *)param
               picName:(NSString *)name
                  pics:(NSArray *)picArr
              progress:(void (^)(NSProgress * uploadProgress))progress
               success:(void (^)(BOOL isSuc,id json))success
               failure:(void (^)(NSError *))failure;
/**
 *  GET方法
 *
 *  @param method  具体功能对应url
 *  @param param   参数
 *  @param success 成功
 *  @param failure 失败
 */
+ (NSURLSessionDataTask *)GETWithMethod:(NSString *)method
                Params:(NSDictionary *)param
               success:(void (^)(id json))success
               failure:(void (^)(NSError *error))failure;


@end
