//
//  ErrorPromt.m
//  XXSYProject
//
//  Created by 刘成 on 16/4/8.
//  Copyright © 2016年 BlueMobi. All rights reserved.
//

#import "ErrorPromt.h"

@implementation ErrorPromt

+ (NSString *)errorPromtWith:(id)json
{
    NSString *orginalString = json[kMessage];
    NSString *backString;
    if (orginalString.length) {
        
        backString = orginalString;
        
        //匹配对应中文
        if ([orginalString isEqualToString:@"trade_password_is_null"]) {
            backString = @"没有设置交易密码，请到个人中心 -> 设置 -> 密码修改 ->修改交易密码,进行交易密码设置";
        }
        if ([orginalString isEqualToString:@"empty"]) {
            backString = @"数据为空";
        }
        
    }else{
        backString = NetWorkWrongPromt;
    }
    
    return backString;
}

@end
