//
//  BaseTableViewCell.h
//  ComponentProject
//
//  Created by 刘成 on 16/6/6.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

/**
 *  实例方法创建cell
 *
 *  @param tableview tableView
 *
 *  @return 返回创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableview;

/**
 *  cell上子控件创建方法
 */
- (void)creatSubviews;

@end
