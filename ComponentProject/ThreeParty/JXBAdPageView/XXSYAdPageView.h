//
//  XXSYAdPageView.h
//  XXSYProject
//
//  Created by suyl on 16/3/15.
//  Copyright © 2016年 BlueMobi. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XXSYAdPageView;
typedef void (^XXSYAdPageCallback)(NSInteger clickIndex);

@protocol XXSYAdPageViewDelegate <NSObject>
/**
 *  加载网络图片使用回调自行调用SDImage
 *
 *  @param imgView
 *  @param imgUrl
 */
//- (void)setWebImage:(UIImageView*)imgView imgUrl:(NSString*)imgUrl;

- (void)pageView:(XXSYAdPageView *)pageView clickPageIndex:(NSInteger)index;

@end

@interface XXSYAdPageView : UIView

@property(nonatomic,assign)NSTimeInterval                iDisplayTime; //广告图片轮播时停留的时间，默认0秒不会轮播
@property (nonatomic,strong)NSTimer                 *myTimer;
@property(nonatomic,assign)BOOL                     bWebImage; //设置是否为网络图片
@property(nonatomic,strong)UIPageControl            *pageControl;
@property(nonatomic,weak)id<XXSYAdPageViewDelegate>  delegate;

/**
 *  启动函数
 *
 *  @param imageArray 设置图片数组
 *
 */
 
-(void)startAdsWithMoneys:(NSArray *)moneyArray tipArray:(NSArray *)tipArray timerInterval:(NSTimeInterval)interval;

@end
