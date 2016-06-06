//
//  Common.h
//  YMProject
//
//  Created by sam.l on 14-10-27.
//  Copyright (c) 2014年 bluemobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

+ (UIViewController *)getCurrentVC;

//根据颜色生产图片
+ (UIImage *)createImageByColor:(UIColor *)color;

//check NSNULL返回id
+(id)checkNSNull:(id)obj;

//check NSNULL返回BOOL
+ (BOOL)checkNull:(id)obj;

//计算文本长度
+(float)getNSStringWidth:(NSString*)str font:(UIFont*)theFont;

//拼接请求字符串
+(NSString*)getURLParamstring:(NSString*)json;

//时间戳转换为时间格式
+(NSDate *)NSDateFromNSString:(NSString *)date;

//时间戳转换为字符串格式
+(NSString *)yearFromAPIDate:(NSString*)date;

+(NSString *)dataFromAPIDate:(NSString*)date;

//根据模式获取时间的字符串形式
+ (NSString *)getDateStringWithDate:(NSDate *)targetDate dateFormatter:(NSString *)dateFormatter;

//根据模式将字符串生成Date
+ (NSDate *)getDateFromString:(NSString *)dateString dateFormatter:(NSString *)dateFormatter;

+ (NSString *)getDateStringWithString:(NSString *)dateString inputDateFormatter:(NSString *)inDateFormatter outputDateFormatter:(NSString *)outDateFormatter;

//MD5加密，用于登录和服务器同步加密
+(NSString*)encodeMD5:(NSString*)stringmd5;

//错误信息
+ (NSString *)errorInfo:(NSString *)errorId;

//提示成功提问 成功收藏 成功点赞
+ (void)tipWith:(NSString *)title;

// 对图片压缩处理
+(UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage*)image;

//  文字改变字体大小
//+(NSMutableAttributedString *)
//  文字改变字体颜色

//  格式话小数 四舍五入类型
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV;


//在view里找到对应的viewcontroller
+ (UIViewController*)viewController:(UIView *)view;

//计算字符的长度 包含中文
+(float)getLengthWithChinese:(NSString *)str;


//实名认证的状态string
+ (NSString *)getIndentifyStringByIndentify:(NSInteger)tag;


//银行卡号判断
+ (NSInteger )CardIndex:(NSString *)bankName;

+ (NSString *)BankNameArray:(NSInteger )bindex;

@end
