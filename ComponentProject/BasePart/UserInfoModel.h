//
//  UserInfoModel.h
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject<NSCoding>

@property (nonatomic,copy) NSString *userId;

#pragma mark - 个人信息处理
+ (UserInfoModel *)sharedInstance;

+ (void)saveUserInfo:(UserInfoModel *)userInfo;

+ (UserInfoModel *)getUserInfo;

+ (UserInfoModel *)setActiveUser:(UserInfoModel *)user;

- (BOOL)isLoggedIn;

- (void)updateInfoToLocal;

- (void)updateInfoFromLocal;

- (void)logoutAndClearnUserInfo;

@end
