//
//  ZJStartADView.m
//  ZJBuildingProject
//
//  Created by Scott on 16/3/31.
//  Copyright © 2016年 bluemobi. All rights reserved.
//

#import "AdvertImageShowView.h"

#define kShowSecond 3
#define kTimeLabelWidth 60

@interface AdvertImageShowView ()

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIImageView *AdImageView;

@property (nonatomic, strong) NSTimer *AdTimer;

@property (nonatomic, assign) NSInteger second;     //倒计时

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIButton *advButton;

@end

@implementation AdvertImageShowView

+ (void)startAdvertViewOnContainer:(UIView *)containerView
{
    //有网络 则去请求
    [[AdvertImageManger sharedManager] updateAdvertImage];
    
    //如果有广告页  则显示
    if([[AdvertImageManger sharedManager] avaliableAdvertImage])
    {
        AdvertImageShowView *startAdView = [[AdvertImageShowView alloc] initWithContainer:containerView];
        [startAdView show];
    }
}


- (instancetype)initWithContainer:(UIView *)containerView
{
    self = [super initWithFrame:containerView.bounds];
    if(self)
    {
        self.containerView = containerView;
        [self createStartAdView];
    }
    return self;
}

//创建启动广告页的View
- (void)createStartAdView
{
    self.second = kShowSecond;
    
    //获取缓存中的广告图片
    UIImageView *AdImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    AdImageView.contentMode = UIViewContentModeScaleAspectFill;
    [AdImageView setImage:[[AdvertImageManger sharedManager] avaliableAdvertImage]];
    [self addSubview:AdImageView];
    self.AdImageView = AdImageView;
    
    //时间显示label
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 20 - kTimeLabelWidth, 20, kTimeLabelWidth, 40)];
    self.timeLabel.userInteractionEnabled = YES;
    self.timeLabel.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    self.timeLabel.font = [UIFont systemFontOfSize:16];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.layer.cornerRadius = 8.f;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.text = [NSString stringWithFormat:@"跳过 %@",@(_second)];
    self.timeLabel.clipsToBounds = YES;
    [self addSubview:self.timeLabel];
    
    //根据具体情况，此处可添加广告按钮
    [self addSubview:self.advButton];
    
    //Add Gesture
    [self.timeLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAdImageView)]];
    
    [self startTimer];
    
}

- (UIButton *)advButton
{
    if (!_advButton) {
        _advButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_advButton setBackgroundColor:DEF_COLOR_A(150, 150, 150, 0.4)];
        [_advButton setTitle:[[AdvertImageManger sharedManager] advertTitle] forState:UIControlStateNormal];
        [_advButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        _advButton.frame = CGRectMake(0, 0, KScreenWidth, 60);
        _advButton.center = CGPointMake(KScreenWidth * 0.5, KScreenHeight - 120);
        [_advButton addTarget:self action:@selector(advButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _advButton;
}

#pragma mark - 图片链接跳转(自行添加)
- (void)advButtonClick
{
    //跳转路径
    NSString *jumpUrl = [[AdvertImageManger sharedManager] advertUrl].absolutePath;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.AdImageView setFrame:self.bounds];
    [self.timeLabel setFrame:CGRectMake(self.width - 20 - kTimeLabelWidth, 20, kTimeLabelWidth, 40)];
}


//开始倒计时
- (void)startTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [loop addTimer:timer forMode:NSRunLoopCommonModes];
    self.AdTimer = timer;
}

//每秒触发一次事件
- (void)timerAction
{
    self.second--;
    self.timeLabel.text = [NSString stringWithFormat:@"跳过 %@",@(_second)];
    if (self.second == 0)
    {
        [self stopTimmer];
        
        [self removeAdImageView];
    }
}

//结束倒计时
- (void)stopTimmer
{
    [self.AdTimer invalidate];
}

- (void)show
{
    self.frame = self.containerView.bounds;
    [self.containerView addSubview:self];
    [self.containerView bringSubviewToFront:self];
}

//移除广告页
- (void)removeAdImageView
{
    [self stopTimmer];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
         [self removeFromSuperview];
    }];
}

@end
