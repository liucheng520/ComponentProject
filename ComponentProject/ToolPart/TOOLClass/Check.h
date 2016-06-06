//
//  Check.h
//  MWBProject
//
//  Created by sam.l on 14-9-2.
//  Copyright (c) 2014年 sam.l. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Check : NSObject

//判断设备名
//+(bool)checkDevice:(NSString*)name;

+(bool)checkLenght:(NSString*)strmessage;

//判断文本是否为空，YES:6-16位,NO:反之
+(bool)checkRange:(NSString*)strmessage;

//判断文本是否为空，YES:4-20位,NO:反之
+(bool)checkRange1:(NSString*)strmessage;

//判断文本是否为空，YES:4-16位,NO:反之
+(bool)checkUserRange:(NSString*)strmessage;

//判断用户名是否合法
+(bool)checkName:(NSString*)strphone;

//判断是否为手机号
+(bool)checkPhone:(NSString*)strphone;

//判断重复
+(bool)checkRepeat:(NSString*)strmessage message:(NSString*)strmessage1;

//邮箱验证
+(BOOL) checkEmail:(NSString *)email;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

@end
