//
//  LCPictureAddView.h
//  ComponentProject
//
//  Created by 刘成 on 16/6/15.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PictureAddModel;

typedef NS_ENUM(NSInteger,PictureAddType) {
    PictureAddTypeAddButtonAtHearder = 1,
    PictureAddTypeAddButtonAtEnd
};

@interface LCPictureAddView : UIView

/**
 *  create the picture addView
 *
 *  @return LCPictureAddView
 */
+ (instancetype)pictureAddView;

/**
 *  set the addType
 */
@property (nonatomic,assign) PictureAddType type;

/**
 *   how many items in one line
 */
@property (nonatomic,assign) NSInteger lineCount;

/**
 *  添加一个新的item
 */
- (void)addItem:(PictureAddModel *)item;

/**
 *  （getter）获取当前页面所有的item，（setter）数据回填时可用
 */
@property (nonatomic,strong) NSArray<PictureAddModel *> *items;

@end
