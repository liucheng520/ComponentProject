//
//  TestModel.h
//  ComponentProject
//
//  Created by 刘成 on 16/7/4.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject

@property (nonatomic,copy) NSString *content;

@property (nonatomic,assign) NSInteger status;

@property (nonatomic,assign) CGFloat height;

+ (NSArray *)getTheShowData;

@end
