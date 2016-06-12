//
//  NSString+Extention.m
//  A01-QQ聊天
//
//  Created by Steve Xiaohu Zhao on 14-11-29.
//  Copyright (c) 2014年 Steve Xiaohu Zhao. All rights reserved.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)

- (NSString *)addBaseUrl
{
    NSString *string = [NSString stringWithFormat:@"%@/%@",Base_URL,self];
    
    return [string stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
}

- (NSString *)cutwhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//计算文本的大小
- (CGSize)sizeOfMaxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}
- (CGSize)sizeOfMaxSize:(CGSize)maxSize font:(UIFont *)font
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}
- (NSInteger)heightWithFont:(UIFont* )font width:(CGFloat)width {
    
    CGRect bounds = CGRectZero;
    bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceilf(bounds.size.height);
}

- (NSInteger)widthWithFont:(UIFont *)font height:(CGFloat)height
{
    CGRect bounds = CGRectZero;
    
    bounds = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return ceilf(bounds.size.width);
}

+ (void)saveString:(NSString *)string Key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getStringWithKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)stringToBeUnderlineWithRange:(NSRange)range button:(UIButton *)btn lineColor:(UIColor *)color
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:btn.titleLabel.text];
    [str addAttribute:NSUnderlineColorAttributeName value:color range:range];
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    [btn setAttributedTitle:str forState:UIControlStateNormal];
}

+ (void)stringToBeUnderlineWithRange:(NSRange)range button:(UIButton *)btn lineColor:(UIColor *)color controlstate:(UIControlState)state
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:btn.titleLabel.text];
    [str addAttribute:NSUnderlineColorAttributeName value:color range:range];
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    [btn setAttributedTitle:str forState:state];
}

+ (NSString *)stringChangeNumberToText:(NSInteger)number
{
    NSString *str = [NSString stringWithFormat:@"%ld", (long)number];
    
    NSRange range;
    range.length = 1;
    
    NSString *finalStr = [NSString string];
    
    for (NSUInteger i = 0; i < [str length]; i++) {
        range.location = i;
        NSString *subStr = [str substringWithRange:range];
        NSInteger subNum = [subStr integerValue];
        
        switch (subNum) {
            case 0:
                subStr = [NSString checkString:@"零" range:range str:str];
                break;
            case 1:
                subStr = [NSString checkString:@"一" range:range str:str];
                break;
            case 2:
                subStr = [NSString checkString:@"二" range:range str:str];
                break;
            case 3:
                subStr = [NSString checkString:@"三" range:range str:str];
                break;
            case 4:
                subStr = [NSString checkString:@"四" range:range str:str];
                break;
            case 5:
                subStr = [NSString checkString:@"五" range:range str:str];
                break;
            case 6:
                subStr = [NSString checkString:@"六" range:range str:str];
                break;
            case 7:
                subStr = [NSString checkString:@"七" range:range str:str];
                break;
            case 8:
                subStr = [NSString checkString:@"八" range:range str:str];
                break;
            case 9:
                subStr = [NSString checkString:@"九" range:range str:str];
                break;
            default:
                break;
        }
        
        finalStr = [finalStr stringByAppendingString:subStr];
    }
    
    
    return finalStr;
}

+ (NSString *)checkString:(NSString *)string range:(NSRange)range str:(NSString *)str
{
    NSString *subStr;
    
    if (str.length == 1) {
        subStr = string;
    } else if (str.length == 2) {
        if (range.location == 0) {
            subStr = [NSString stringWithFormat:@"%@十", string];
        } else if (range.location == 1){
            subStr = string;
        }
    } else if (str.length == 3) {
        if (range.location == 0) {
            subStr = [NSString stringWithFormat:@"%@百", string];
        } else if (range.location == 1){
            subStr = [NSString stringWithFormat:@"%@十", string];
        } else if (range.location == 2){
            subStr = string;
        }
    }
    return subStr;
}

- (id)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (NSString *)absolutePath
{
    if (![self hasPrefix:@"http"]) {
        NSString *fullUrl =  [NSString stringWithFormat:@"%@%@",Base_URL,self];
        return fullUrl;
    }
    return self;
}

@end
