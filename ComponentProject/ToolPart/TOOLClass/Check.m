//
//  Check.m
//  MWBProject
//
//  Created by sam.l on 14-9-2.
//  Copyright (c) 2014年 sam.l. All rights reserved.
//

#import "Check.h"

@implementation Check
#pragma mark 检测设备名
////判断设备名
//+(bool)checkDevice:(NSString*)name
//{
//    NSString* deviceType = [UIDevice currentDevice].model;
//    
//    NSRange range = [deviceType rangeOfString:name];
//    return range.location != NSNotFound;
//}

//判断文本是否为空，YES不为空，NO为空
+(bool)checkLenght:(NSString*)strmessage
{
    bool isflag = YES;
    strmessage=[strmessage stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(strmessage==nil || strmessage.length<=0)
    {
        isflag=NO;
    }
    return isflag;
}
//判断文本是否为空，YES:4-20位,NO:反之
+(bool)checkRange1:(NSString*)strmessage
{
    bool isflag = YES;
    strmessage=[strmessage stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(strmessage.length<4 || strmessage.length>20)
    {
        isflag=NO;
    }
    
    return isflag;
}
//判断文本是否为空，YES:6-16位,NO:反之
+(bool)checkRange:(NSString*)strmessage
{
    bool isflag = YES;
    strmessage=[strmessage stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(strmessage.length<6 || strmessage.length>16)
    {
        isflag=NO;
    }
    
    return isflag;
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//判断文本是否为空，YES:4-16位,NO:反之
+(bool)checkUserRange:(NSString*)strmessage
{
    bool isflag = YES;
    strmessage=[strmessage stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(strmessage.length>4 || strmessage.length<16)
    {
        isflag=NO;
    }
    return isflag;
}
//判断是否为手机号
+(bool)checkPhone:(NSString*)strphone
{
    bool isflag = YES;
    strphone=[strphone stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *regex = @"^(1([34578][0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    isflag = [pred evaluateWithObject:strphone];
    if (!isflag) {
        return NO;
    }
    return YES;


}

//判断用户名是否合法
+(bool)checkName:(NSString*)strphone
{
    bool isflag = YES;
    strphone=[strphone stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *regex = @"^[a-zA-Z\\xa0-\\xff_][0-9a-zA-Z\\xa0-\\xff_]{3,15}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    isflag = [pred evaluateWithObject:strphone];
    if (!isflag) {
        return NO;
    }
    return YES;
    
    
//    if(strphone==nil ||  strphone.length!=11)
//    {
//        isflag=NO;
//    }
//    return isflag;
    
}

//判断重复
+(bool)checkRepeat:(NSString*)strmessage message:(NSString*)strmessage1
{
    bool isflag = YES;
    
    if(![strmessage isEqualToString:strmessage1])
    {
        isflag=NO;
    }
    return isflag;
}
//
+(BOOL) checkEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
