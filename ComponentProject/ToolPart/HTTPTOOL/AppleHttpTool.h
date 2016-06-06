//
//  AppleHttpTool.h
//  武汉二部iOS基础框架
//
//  Created by 苏荷 on 15/9/23.
//  Copyright (c) 2015年 BlueMobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPHeader.h"

//返回代码块
typedef void (^ResponseData)(id json);

@interface AppleHttpTool : NSObject<NSURLSessionDelegate>
/**
 *  GET方法
 *
 *  @param method  具体功能对应url
 *  @param param   参数
 *  @param success 成功
 *  @param failure 失败
 */

- (void)GETWithMethod:(NSString *)method param:(NSDictionary *)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/**
 *  POST方法
 *
 *  @param method  具体功能对应url
 *  @param param   参数
 *  @param success 成功
 *  @param failure 失败
 */
- (void)POSTWithMethod:(NSString *)method param:(NSDictionary *)param success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
