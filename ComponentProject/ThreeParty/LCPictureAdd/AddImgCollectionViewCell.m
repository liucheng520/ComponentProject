//
//  AddImgCollectionViewCell.m
//  CSCECProject
//
//  Created by 刘成 on 16/5/4.
//  Copyright © 2016年 WaterBearStudio. All rights reserved.
//

#import "AddImgCollectionViewCell.h"
#import "AddReportImgModel.h"

@interface AddImgCollectionViewCell()

@property (nonatomic,weak) UIImageView *iconImg;

@property (nonatomic,weak) UIImageView *deleteImg;

@end

@implementation AddImgCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *iconImg = [[UIImageView alloc]init];
        iconImg.userInteractionEnabled = YES;
        iconImg.contentMode = UIViewContentModeScaleAspectFill;
        iconImg.clipsToBounds = YES;
        [self addSubview:iconImg];
        self.iconImg = iconImg;
        
        UIImageView *deleteImg = [[UIImageView alloc]init];
        deleteImg.userInteractionEnabled = YES;
        [deleteImg setImage:[UIImage imageNamed:@"circle_delete"]];
        [self addSubview:deleteImg];
        self.deleteImg = deleteImg;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteImgTapped)];
        [deleteImg addGestureRecognizer:tap];
    }
    return self;
}

- (void)deleteImgTapped
{
    if ([self.delegate respondsToSelector:@selector(collectionViewCell:deleteModel:)]) {
        [self.delegate collectionViewCell:self deleteModel:self.model];
    }
}

- (void)setModel:(AddReportImgModel *)model
{
    _model = model;
    if (_model.isLast) {
        self.iconImg.image = [UIImage imageNamed:@"addReport_addImg"];
        self.deleteImg.hidden = YES;
    }else{
        if (model.isHTTPImg) {
           [self.iconImg yy_setImageWithURL:[NSURL URLWithString:[_model.imgUrl addBaseUrl]] placeholder:[UIImage imageNamed:PLaceHolder_square]];
        }else{
           self.iconImg.image = _model.image;
        }
        self.deleteImg.hidden = NO;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconImg.frame = CGRectMake(7.5, 7.5, self.width - 15, self.width - 15);
    self.deleteImg.frame = CGRectMake(self.width - 15, 0, 15, 15);
}

@end
