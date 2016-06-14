//
//  MeetingMemberView.m
//  CSCECProject
//
//  Created by 刘成 on 16/5/4.
//  Copyright © 2016年 WaterBearStudio. All rights reserved.
//

#import "MeetingMemberView.h"
#import "MeetingMemberCollectionViewCell.h"

@interface MeetingMemberView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) UIImageView *imgView;

@property (nonatomic,weak) UILabel *promtLabel;

@property (nonatomic,weak) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation MeetingMemberView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    //leftLine
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView setBackgroundColor:DEF_COLOR(54, 124, 206)];
    [self addSubview:imgView];
    self.imgView = imgView;
    
    //promtLabel
    UILabel *promt = [[UILabel alloc] init];
    promt.textColor = DEF_COLOR(90, 90, 90);
    promt.font = [UIFont systemFontOfSize:13.0f];
    promt.text = @"参会人员";
    [self addSubview:promt];
    self.promtLabel = promt;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(kCellW , kCellH);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.bounces = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.scrollEnabled = NO;
    [collectionView registerClass:[MeetingMemberCollectionViewCell class] forCellWithReuseIdentifier:kCellReuse];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

- (void)setMembers:(NSArray *)members
{
    _members = members;
 
    self.dataSource = [NSMutableArray arrayWithArray:_members];
    
    ContactPerson *model = [[ContactPerson alloc] init];
    model.add = YES;
    [self.dataSource addObject:model];
    [self.collectionView reloadData];
}

- (void)setPromt:(NSString *)promt
{
    _promt = promt;
    self.promtLabel.text = promt;
}

#pragma mark - UICollectionView Delegate
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MeetingMemberCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuse forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCellW , kCellH);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0f;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataSource.count - 1) {
        if ([self.delegate respondsToSelector:@selector(memberView:oldMembers:)]) {
            [self.delegate memberView:self oldMembers:self.members];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(10, 5.5, 4, 14);
    self.promtLabel.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) + 3, 0, KScreenWidth * 0.5, 25);
    self.collectionView.frame = CGRectMake(10, CGRectGetMaxY(self.promtLabel.frame), KScreenWidth - 20, self.height - CGRectGetMaxY(self.promtLabel.frame));
}

@end
