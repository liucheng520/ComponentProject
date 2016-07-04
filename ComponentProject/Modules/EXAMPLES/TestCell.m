//
//  TestCell.m
//  ComponentProject
//
//  Created by 刘成 on 16/7/4.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell

- (void)creatSubviews
{
    self.textLabel.textColor = [UIColor textNormalColor];
    self.textLabel.numberOfLines = 0;
    self.textLabel.font = [UIFont systemFontOfSize:15.0f];
}

- (void)setModel:(TestModel *)model
{
    _model = model;
    self.textLabel.text = _model.content;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(10, 5, KScreenWidth - 20, self.model.height - 10);
}

@end
