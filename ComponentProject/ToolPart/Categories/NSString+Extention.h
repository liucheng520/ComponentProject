//
//  NSString+Extention.h
//  A01-QQ聊天
//
//  Created by Steve Xiaohu Zhao on 14-11-29.
//  Copyright (c) 2014年 Steve Xiaohu Zhao. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSString (Extention)

/**
 *  拼接baseUrl，用于拼接绝对路径
 */
- (NSString *)addBaseUrl;

/**
 *  去除掉text的开头和结尾的空格
 */
- (NSString *)cutwhitespace;

/**
 *  获取文字size
 */
- (CGSize)sizeOfMaxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize;

- (CGSize)sizeOfMaxSize:(CGSize)maxSize font:(UIFont *)font;

/**
 *  计算一个字符串在限定的宽度和字体下的长度
 *
 *  @param font  限定的字体
 *  @param width 限定的宽度
 *
 *  @return 字符串的长度
 */
- (NSInteger)heightWithFont:(UIFont* )font width:(CGFloat)width;

- (NSInteger)widthWithFont:(UIFont *)font height:(CGFloat)height;

/**
 *  偏好设置：存字符串（手势密码）
 */
+ (void)saveString:(NSString *)string Key:(NSString *)key;

/**
 *  偏好设置：取字符串
 */
+ (NSString *)getStringWithKey:(NSString *)key;

/**
 *  给我一个button，让它的文字底部对应的range划线
 */
+ (void)stringToBeUnderlineWithRange:(NSRange)range button:(UIButton *)btn lineColor:(UIColor *)color;
+ (void)stringToBeUnderlineWithRange:(NSRange)range button:(UIButton *)btn lineColor:(UIColor *)color controlstate:(UIControlState)state;

// 提供0-9，转换成0，一->九
+ (NSString *)stringChangeNumberToText:(NSInteger)number;

+ (NSString *)checkString:(NSString *)string range:(NSRange)range str:(NSString *)str;

/**
 *  MD5加密
 */
- (id)MD5;

/**
 *  是否是中文
 */
- (BOOL)isChinese;

/**
 *  绝对露尽
 */
@property (nonatomic,copy) NSString *absolutePath;

@end
