//
//  AddReportImgCell.m
//  CSCECProject
//
//  Created by 刘成 on 16/4/28.
//  Copyright © 2016年 WaterBearStudio. All rights reserved.
//

#import "AddReportImgCell.h"
#import "AddImgCollectionViewCell.h"
#import "AddReportImgModel.h"

#define kAddReuse @"addReuse"

@interface AddReportImgCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AddImgCollectionViewCellDelegate>

@property (nonatomic,weak) UICollectionView *colletionView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation AddReportImgCell

- (void)creatSubviews
{
    self.maxCount = 6;  //default is 6
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(kAddCellW , kAddCellH);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.bounces = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.scrollEnabled = NO;
    [collectionView registerClass:[AddImgCollectionViewCell class] forCellWithReuseIdentifier:kAddReuse];
    [self addSubview:collectionView];
    self.colletionView = collectionView;
}

- (void)setImgsArr:(NSMutableArray *)imgsArr
{
    _imgsArr = imgsArr;
    
    [self.dataSource removeAllObjects];
    
    [self.dataSource addObjectsFromArray:_imgsArr];
    
    if (_imgsArr.count < self.maxCount) {
        AddReportImgModel *model = [[AddReportImgModel alloc] init];
        model.last = YES;
        [self.dataSource addObject:model];
    }

    [self.colletionView reloadData];
}

- (void)collectionViewCell:(AddImgCollectionViewCell *)cell deleteModel:(AddReportImgModel *)model
{
    NSIndexPath *indexP = [self.colletionView indexPathForCell:cell];
    if ([self.delegate respondsToSelector:@selector(addReportImgCell:deleteIndex:)]) {
        [self.delegate addReportImgCell:self deleteIndex:indexP.row];
    }
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
    AddImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAddReuse forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kAddCellW , kAddCellH);
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
        if ([self.delegate respondsToSelector:@selector(addReportImgCell:addPicture:)]) {
            [self.delegate addReportImgCell:self addPicture:self.imgsArr];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.colletionView.frame = CGRectMake(0, 0, KScreenWidth, self.height);
}

@end
