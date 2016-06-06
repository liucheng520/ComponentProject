//
//  AFNHttpTool.m
//  武汉二部iOS基础框架
//
//  Created by 苏荷 on 15/9/23.
//  Copyright (c) 2015年 BlueMobi. All rights reserved.
//

#import "AFNHttpTool.h"

@implementation AFNHttpTool

+ (NSURLSessionDataTask *)POSTWithMethod:(NSString *)method
                Params:(NSDictionary *)param
               success:(void (^)(BOOL isSuc,id json))success
               failure:(void (^)(NSError *error))failure
{
    
    NSString *url=[NSString stringWithFormat:@"%@%@",Base_URL,method];

    return [[self httpManger] POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            NSLog(@"%@",responseObject);
            
            //如果数据请求成功，并且flag为yes，则返回YES，反之，返回NO
            if ([Common checkNSNull:responseObject]) {
                BOOL isSuc = [responseObject[kFlag] boolValue];
                success(isSuc,responseObject);
            }else{
                success(NO,responseObject);
            }
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (NSURLSessionDataTask *)POSTWithMethod:(NSString *)method
                Params:(NSDictionary *)param
            heardImage:(UIImage *)heardImage
          imageKeyName:(NSString *)keyName
              progress:(void (^)(NSProgress * uploadProgress))progress
               success:(void (^)(BOOL isSuc,id json))success
               failure:(void (^)(NSError *))failure;
{
    
    NSString *url=[NSString stringWithFormat:@"%@%@",Base_URL,method];
    
    //修改图片上传超时时间
    AFHTTPSessionManager *manger = [self httpManger];
    manger.requestSerializer.timeoutInterval = 60.0f;
    
    return [manger POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(heardImage,0.8);
        //图片data拼接
        [formData appendPartWithFileData:imageData name:keyName fileName:@"headImg.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //返回上传进度
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            //如果数据请求成功，并且flag为yes，则返回YES，反之，返回NO
            if ([Common checkNSNull:responseObject]) {
                BOOL isSuc = [responseObject[kFlag] boolValue];
                success(isSuc,responseObject);
            }else{
                success(NO,responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (NSURLSessionDataTask *)POSTWithMethod:(NSString *)method
                Params:(NSDictionary *)param
               picName:(NSString *)name
                  pics:(NSArray *)picArr
              progress:(void (^)(NSProgress * uploadProgress))progress
               success:(void (^)(BOOL isSuc,id json))success
               failure:(void (^)(NSError *))failure
{
    
    NSString *url=[NSString stringWithFormat:@"%@%@",Base_URL,method];
    
    //修改图片上传超时时间
    AFHTTPSessionManager *manger = [self httpManger];
    manger.requestSerializer.timeoutInterval = 60.0f;
    
    return [manger POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i= 0; i<picArr.count; i++) {
            NSData *data = [self imageCompressForWidth:picArr[i]];
            [formData appendPartWithFileData:data name:name fileName:[NSString stringWithFormat:@"%d.jpg",i] mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //返回上传进度
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            //如果数据请求成功，并且flag为yes，则返回YES，反之，返回NO
            if ([Common checkNSNull:responseObject]) {
                BOOL isSuc = [responseObject[kFlag] boolValue];
                success(isSuc,responseObject);
            }else{
                success(NO,responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//压缩图片
+ (NSData *)imageCompressForWidth:(UIImage *)sourceImage
{
    CGSize imageSize = sourceImage.size;
    CGFloat defineWidth = imageSize.width;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    //变更可修改图片大小
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImagePNGRepresentation(newImage);
}

+ (NSURLSessionDataTask *)GETWithMethod:(NSString *)method
               Params:(NSDictionary *)param
              success:(void (^)(id json))success
              failure:(void (^)(NSError *error))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_URL,method];
   return [[self httpManger] GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       if (success) {
         success(responseObject);
       }
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       if (failure) {
           failure(error);
       }
   }];
}

+ (AFHTTPSessionManager *)httpManger
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer.timeoutInterval = 10.0f;
    manger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html" , nil];
    return manger;
}
@end
