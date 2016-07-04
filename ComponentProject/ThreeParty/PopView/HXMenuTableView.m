//
//  HXMenuTableView.m
//  HXAXProject
//
//  Created by Scott on 15/11/26.
//  Copyright © 2015年 刘成. All rights reserved.
//

#import "HXMenuTableView.h"

@interface HXMenuTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *menuTableView;


@end

@implementation HXMenuTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.tableRowHeight = 44;
        [self.menuTableView setFrame:self.bounds];
        [self addSubview:self.menuTableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [self.menuTableView setFrame:self.bounds];
}

- (void)reloadData
{
    [self.menuTableView reloadData];
}


#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menuCell"];
        [cell setFrame: CGRectMake(0, 0, self.width,self.tableRowHeight)];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.width - 10, self.tableRowHeight)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        if (IS_IPHONE_4||IS_IPHONE_5) {
            titleLabel.font = [UIFont systemFontOfSize:12.0];
        }else{
            titleLabel.font = [UIFont systemFontOfSize:13.0];
        }
        
        titleLabel.tag = 999;
        
        [cell addSubview:titleLabel];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:999];
    titleLabel.textColor = [UIColor whiteColor];
    
    id item = [self.dataArray objectAtIndex:indexPath.row];
    if([item isKindOfClass:[MenuItem class]])
    {
        MenuItem *menu = (MenuItem *)item;
        titleLabel.text = menu.menuTitle;
        titleLabel.textColor = [menu getTitleColor];
    }
    else
    {
        NSString *title = (NSString *)item;
        titleLabel.text = title;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(menuTableView:didSelectRowAtIndex:)])
    {
        [self.delegate menuTableView:self didSelectRowAtIndex:indexPath.row];
    }
}


#pragma mark - UIFactory
- (UITableView *)menuTableView
{
    if(!_menuTableView)
    {
        _menuTableView = [[UITableView alloc]init];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTableView.backgroundColor = [UIColor clearColor];
//        [_menuTableView
//         registerClass:[UITableViewCell class] forCellReuseIdentifier:@"menuCell"];
    }
    return _menuTableView;
}

@end


@interface MenuItem()

@end


@implementation MenuItem

- (UIColor *)getTitleColor
{
    switch (self.status) {
        case MenuStatusNone:
            return [UIColor whiteColor];
            break;
        case MenuStatusSelected:
            return [UIColor orangeColor];
            break;
        case MenuStatusSpecial:
            return [UIColor greenColor];
            break;
            
        default:
            break;
    }
    
    return [UIColor whiteColor];
}

@end



