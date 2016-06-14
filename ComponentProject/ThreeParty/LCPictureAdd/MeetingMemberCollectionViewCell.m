//
//  MeetingMemberCollectionViewCell.m
//  CSCECProject
//
//  Created by 刘成 on 16/5/4.
//  Copyright © 2016年 WaterBearStudio. All rights reserved.
//

#import "MeetingMemberCollectionViewCell.h"

@interface MeetingMemberCollectionViewCell()

@property (nonatomic,weak) UIImageView *iconImg;

@property (nonatomic,weak) UILabel *nameLabel;

@end

@implementation MeetingMemberCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:11.0f];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textColor = DEF_COLOR(90, 90, 90);
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UIImageView *iconImg = [[UIImageView alloc]init];
        [iconImg setImage:[UIImage imageNamed:@"meeting_choose"]];
        [self addSubview:iconImg];
        self.iconImg = iconImg;
    }
    return self;
}

- (void)setModel:(ContactPerson *)model
{
    _model = model;
    
    if (_model.isAdd) {
        self.iconImg.image = [UIImage imageNamed:@"addReport_addImg"];
        self.nameLabel.hidden = YES;
    }else{
        [self.iconImg yy_setImageWithURL:[NSURL URLWithString:[_model.picture addBaseUrl]] placeholder:[UIImage imageNamed:PLaceHolder_userIcon]];
        self.nameLabel.text = _model.name;
        self.nameLabel.hidden = NO;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconImg.frame = CGRectMake(0, 0, self.width, self.width);
    self.nameLabel.frame = CGRectMake(0, self.width, self.width, self.width * 0.5);
}

@end
