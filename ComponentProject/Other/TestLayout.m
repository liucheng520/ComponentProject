//
//  TestLayout.m
//  ComponentProject
//
//  Created by 刘成 on 16/6/16.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "TestLayout.h"

@implementation TestLayout
SINGLETON_M(layout)

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

/**
 *  每一个UICollectionViewLayoutAttributes对应一个cell
 *
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *arr  = [super layoutAttributesForElementsInRect:rect];
    
    return  arr;
}

/**
 *  当collectionview的显示范围发生改变的时候，是否需要重新刷新布局，一旦重新刷新，就会再次调上面的方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  返回值决定了collectionview停止滚动时的偏移量，手松开的那一刻调用
 *  拿出每一个UICollectionViewLayoutAttributes 在计算偏移量
 *  proposedContentOffset本来的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    return CGPointZero;
}
@end
