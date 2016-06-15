//
//  PictureAddCollectionViewCell.m
//  ComponentProject
//
//  Created by 刘成 on 16/6/15.
//  Copyright © 2016年 liucheng. All rights reserved.
//

#import "PictureAddCollectionViewCell.h"
#import "PictureAddModel.h"

@interface PictureAddCollectionViewCell()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,weak) UIImageView *imageView;

@property (nonatomic,strong) UIButton *deleteButton;

@end

@implementation PictureAddCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //图片
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        //删除按钮
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setImage:[UIImage imageNamed:@"circle_delete"] forState:UIControlStateNormal];
        [self.contentView addSubview:deleteButton];
        self.deleteButton = deleteButton;
    }
    return self;
}

- (void)setModel:(PictureAddModel *)model
{
    _model = model;
    if (model.title.length) {
        self.titleLabel.text = _model.title;
    }
    if (_model.isHttpImage) {
        [self.imageView lc_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:PLACEHOLDER_IMAGE]];
    }else{
        self.imageView.image = [UIImage imageNamed:_model.imageName];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.width - 7.5;
    CGFloat height = self.height - 7.5;
    if (self.model.title.length) { //图片，文字都有
        if(self.model.imageUrl.length || self.model.imageUrl.length){
            
            CGFloat WH = (height - 17 > width) ? width : (height - 17);
            
            self.imageView.frame = CGRectMake((width - WH) * 0.5, 7.5, WH, WH);
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.frame = CGRectMake(0, self.height - 17, width, 17);
        }else{
            self.titleLabel.frame = CGRectMake(0, 7.5, self.width - 7.5, self.height - 7.5);
        }
        
    }else{
       self.imageView.frame = CGRectMake(0, 7.5, self.width - 7.5, self.height - 7.5);
    }
    
    self.deleteButton.frame = CGRectMake(self.width - 15, 0, 15, 15);
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        //文字显示按钮
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.textColor = [UIColor textNormalColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
