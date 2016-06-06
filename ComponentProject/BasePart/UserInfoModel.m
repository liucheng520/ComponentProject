//
//  UserInfoModel.m
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "UserInfoModel.h"

/**
 *  个人信息存储路径
 */
#define UserFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userDetail.data"]

static UserInfoModel *g_userInfo = nil;

@implementation UserInfoModel

/**
 *  个人信息单例
 */
+ (UserInfoModel *)sharedInstance
{
    @synchronized(self){
        if(!g_userInfo)
        {
            UserInfoModel *user = [[UserInfoModel alloc]init];
            [UserInfoModel setActiveUser:user];
        }
    }
    return g_userInfo;
}

+ (UserInfoModel *)setActiveUser:(UserInfoModel *)user
{
    if(g_userInfo != user)
    {
        g_userInfo = user;
    }
    return g_userInfo;
}

/**
 *  判断用户是否登录
 */
- (BOOL)isLoggedIn
{
    return ([self.userId length] > 0);
}

/**
 *  NSCoding协议－存
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId forKey:@"userID"];
}
/**
 *  NSCoding协议－取
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userID"];
    }
    return self;
}
/**
 *  归档个人信息
 */
+ (void)saveUserInfo:(UserInfoModel *)userInfo
{
    [NSKeyedArchiver archiveRootObject:userInfo toFile:UserFile];
}
/**
 *  取个人信息
 */
+ (UserInfoModel *)getUserInfo
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:UserFile];
}
/**
 *  更新个人信息到本地
 */
- (void)updateInfoToLocal
{
    [NSKeyedArchiver archiveRootObject:self toFile:UserFile];
}
/**
 *  获取本地更新
 */
- (void)updateInfoFromLocal
{
    UserInfoModel *localUser =[NSKeyedUnarchiver unarchiveObjectWithFile:UserFile];
    [UserInfoModel setActiveUser:localUser];
}
/**
 *  登出，删除本地信息存储
 */
- (void)logoutAndClearnUserInfo
{
    [UserInfoModel setActiveUser:[UserInfoModel new]];
    [NSKeyedArchiver archiveRootObject:[UserInfoModel new] toFile:UserFile];
}

@end
