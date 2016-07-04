//
//  TestModel.m
//  ComponentProject
//
//  Created by 刘成 on 16/7/4.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (CGFloat)height
{
    if (!_height) {
        _height = [self.content heightWithFont:[UIFont systemFontOfSize:15.0f] width:KScreenWidth - 20];
    }
    return _height;
}

+ (NSArray *)getTheShowData
{
    NSMutableArray *arr = [NSMutableArray array];

    NSArray *content = @[@"这里是测试内容",@"这里是测试内容这里是测试内容这里是测试内容这里是测试内容这里是测试内容这里是测试内容这里是测试内容这里是测试内容这里是测试内容",@"这里是测试内容这里是测试内容这里是测试内容",@"这里是测试内容这里是测试内容这里是测试内容这里是测试内容这里是测试内容这里是测试内容这里是测试内容",@"这里是测试内容这里是测试内容这里是测试内容这里是测试内容这里是测试内容这里是测试内容",@"这里是测试这里是测试内容这里是测试内容这里是测试内容内容"];
    for (NSInteger i = 0; i < 6; i++) {
        TestModel *model = [[TestModel alloc] init];
        model.status = i + 1;
        model.content = content[i];
        [arr addObject:model];
    }
    return [arr copy];
}
@end
