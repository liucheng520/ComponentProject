//
//  BaseTableViewCell.m
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

+ (BaseTableViewCell *)cellWithTableView:(UITableView *)tableview
{
    NSString *identifier = NSStringFromClass([self class]);
    
    BaseTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 去除cell的默认背景色
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self creatSubviews];
    }
    return self;
}

- (void)creatSubviews
{
    
}

@end
