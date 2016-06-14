//
//  AddImgCollectionViewCell.h
//  CSCECProject
//
//  Created by 刘成 on 16/5/4.
//  Copyright © 2016年 WaterBearStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddImgCollectionViewCell,AddReportImgModel;

@protocol AddImgCollectionViewCellDelegate <NSObject>

- (void)collectionViewCell:(AddImgCollectionViewCell *)cell deleteModel:(AddReportImgModel *)model;

@end

@interface AddImgCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) AddReportImgModel *model;

@property (nonatomic,weak) id<AddImgCollectionViewCellDelegate> delegate;

@end
