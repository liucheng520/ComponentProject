//
//  FirstViewController.m
//  ComponentProject
//
//  Created by 刘成 on 16/7/4.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "FirstViewController.h"
#import "LCMenuBar.h"
#import "TestCell.h"

@interface FirstViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) LCMenuBar *menuBar;

@property (nonatomic,strong) UITableView *showTableView;

@property (nonatomic,strong) NSMutableArray *tableViews;

@property (nonatomic,strong) NSMutableArray *showDataSource;

@property (nonatomic,strong) NSMutableArray *allDataSource;

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)createContentView
{
    NSArray *titles = @[@"全部",@"待付款",@"待服务",@"待录档",@"待评价"];
    LCMenuBar *menuBar = [[LCMenuBar alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 35) numberOfTab:titles.count];
    self.menuBar = menuBar;
    
    //添加展示的view到contain
    for (NSInteger i = 0; i < titles.count; i++) {
        
        [menuBar setTitle:titles[i] img:nil atIndex:i];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(KScreenWidth * i, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
        tableView.tag = 10 + i;
        tableView.contentInset = UIEdgeInsetsMake(35, 0, 59, 0);
        [tableView setBackgroundColor:DEF_COLOR(233, 233, 233)];
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        [menuBar.containView addSubview:tableView];
        if (i == 0) {
            self.showTableView = tableView;
        }
        [self.tableViews addObject:tableView];
    }
    [self dealWithTheData];
    
    [self.menuBar setBadgeValue:3 atIndex:1];
    [self.menuBar setBadgeValue:66 atIndex:2];
    [self.menuBar setBadgeValue:200 atIndex:3];
    [self.menuBar setBadgeValue:3 atIndex:4];
    
    //展示
    __weak FirstViewController *weakSelf = self;
    [menuBar showMenuBarOnView:self.view menuBarChange:^(NSInteger index) {
        weakSelf.showTableView = weakSelf.tableViews[index];
        [weakSelf dealWithTheData];
        
        [weakSelf.menuBar setBadgeValue:0 atIndex:index];
    }];
}

- (void)dealWithTheData
{
    [self.showDataSource removeAllObjects];

    if (self.showTableView.tag == 10) {
        [self.showDataSource addObjectsFromArray:self.allDataSource];
    }else{
        for (TestModel *model in self.allDataSource) {
            if (model.status == self.showTableView.tag - 8) {
                [self.showDataSource addObject:model];
            }
        }
    }
    [self.showTableView reloadData];
    
}

- (NSMutableArray *)tableViews
{
    if(!_tableViews){
        _tableViews = [NSMutableArray array];
    }
    return _tableViews;
}

- (NSMutableArray *)allDataSource
{
    if (_allDataSource == nil) {
        _allDataSource = [NSMutableArray arrayWithArray:[TestModel getTheShowData]];
    }
    return _allDataSource;
}

- (NSMutableArray *)showDataSource
{
    if(!_showDataSource){
        _showDataSource = [NSMutableArray array];
    }
    return _showDataSource;
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.showDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestCell *cell = [TestCell cellWithTableView:tableView];
    cell.model = self.showDataSource[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestModel *model = self.showDataSource[indexPath.section];
    return model.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}


@end
