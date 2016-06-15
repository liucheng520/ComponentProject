//
//  LCPictureAddView.m
//  ComponentProject
//
//  Created by 刘成 on 16/6/15.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "LCPictureAddView.h"
#import "PictureAddModel.h"
#import "PictureAddCollectionViewCell.h"

#define kRESUEIDENTIFIER @"reuseridentifier"
#define kSPACE 5.0f

@interface LCPictureAddView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) CGSize itemSize;

@end

@implementation LCPictureAddView

+ (instancetype)pictureAddView
{
    return [[LCPictureAddView alloc] initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _lineCount = 4;
        _type = PictureAddTypeAddButtonAtHearder;
        _itemSize = CGSizeZero;
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;

        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.bounces = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.scrollEnabled = NO;
        [collectionView registerClass:[PictureAddCollectionViewCell class] forCellWithReuseIdentifier:kRESUEIDENTIFIER];
        [self addSubview:collectionView];
        self.collectionView = collectionView;
    }
    return self;
}

- (void)setType:(PictureAddType)type
{
    _type = type;
}

- (void)setLineCount:(NSInteger)lineCount
{
    _lineCount = lineCount;
}

- (void)setItems:(NSArray<PictureAddModel *> *)items
{
    _items = items;
    
    PictureAddModel *model = [[PictureAddModel alloc] init];
    model.isHttpImage = NO;
    model.imageName = @"addReport_addImg";
    [self.dataSource addObject:model];
    
    //添加按钮在第一个
    if(self.type == PictureAddTypeAddButtonAtHearder){

    }else{
        
    }
    [self.dataSource addObjectsFromArray:_items];
    [self.collectionView reloadData];
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
    PictureAddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRESUEIDENTIFIER forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kSPACE, kSPACE, kSPACE, kSPACE);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kSPACE * 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kSPACE;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataSource.count - 1) {
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.width, self.height);
}

@end
