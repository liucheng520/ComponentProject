//
//  AddReportImgCell.h
//  CSCECProject
//
//  Created by 刘成 on 16/4/28.
//  Copyright © 2016年 WaterBearStudio. All rights reserved.
//

#import "CSBaseTableViewCell.h"
@class AddReportImgCell;

#define kAddImgNum  4
#define kAddCellW (KScreenWidth - 20 - (kAddImgNum + 2) * 10) / kAddImgNum
#define kAddCellH kAddCellW
#define kAddCellHeight(num) ((num / kAddImgNum) + 1) * (kAddCellH + 5) + 5

@protocol AddReportImgCellDelegate <NSObject>

- (void)addReportImgCell:(AddReportImgCell *)cell addPicture:(NSArray *)oldImgs;

- (void)addReportImgCell:(AddReportImgCell *)cell deleteIndex:(NSInteger)number;

@end

@interface AddReportImgCell : CSBaseTableViewCell

//最大图片数量  默认是6
@property (nonatomic, assign) NSUInteger maxCount;

@property (nonatomic,strong) NSMutableArray *imgsArr;

@property (nonatomic,weak) id<AddReportImgCellDelegate> delegate;

@end
