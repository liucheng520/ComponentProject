//
//  XXSYAdPageView.m
//  XXSYProject
//
//  Created by suyl on 16/3/15.
//  Copyright © 2016年 BlueMobi. All rights reserved.
//

#import "XXSYAdPageView.h"

@interface XXSYAdPageView()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic,assign)NSInteger           indexShow;
@property (nonatomic,copy)NSArray               *arrImage;
@property (nonatomic,copy)NSArray               *arrTip;
@property (nonatomic,strong)UIScrollView        *scView;
@property (nonatomic,strong)UIImageView         *imgPrev;
@property (nonatomic,strong)UIImageView         *imgCurrent;
@property (nonatomic,strong)UIImageView         *imgNext;
@property (nonatomic,strong)UIImageView         *imgFour;

@property (nonatomic,assign)XXSYAdPageCallback   myBlock;

@end

@implementation XXSYAdPageView
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initUI];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    _scView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scView.delegate = self;
    _scView.pagingEnabled = YES;
    _scView.bounces = NO;
    _scView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    _scView.showsHorizontalScrollIndicator = NO;
    _scView.showsVerticalScrollIndicator = NO;
    [_scView setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self addSubview:_scView];
    
    _imgPrev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _imgPrev.contentMode = UIViewContentModeScaleAspectFill;
    _imgPrev.clipsToBounds = YES;
    _imgPrev.backgroundColor = [UIColor clearColor];
    _imgCurrent = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _imgCurrent.contentMode = UIViewContentModeScaleAspectFill;
    _imgCurrent.clipsToBounds = YES;
    _imgCurrent.backgroundColor = [UIColor clearColor];
    _imgNext = [[UIImageView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _imgNext.contentMode = UIViewContentModeScaleAspectFill;
    _imgNext.clipsToBounds = YES;
    _imgNext.backgroundColor = [UIColor clearColor];
    
    
    _imgFour = [[UIImageView alloc] initWithFrame:CGRectMake(3*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _imgFour.contentMode = UIViewContentModeScaleAspectFill;
    _imgFour.clipsToBounds = YES;
    _imgFour.backgroundColor = [UIColor clearColor];

    [_scView addSubview:_imgPrev];
    [_scView addSubview:_imgCurrent];
    [_scView addSubview:_imgNext];
    [_scView addSubview:_imgFour];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 10  , self.frame.size.width, 5)];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.hidesForSinglePage = YES;
    [self addSubview:_pageControl];
    [self bringSubviewToFront:_pageControl];
    
    // tap手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAds)];
    [_scView addGestureRecognizer:tap];
    
    // 长按手势
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAds:)];
    [_scView addGestureRecognizer:press];
    
}

- (void)layoutSubviews
{
    _scView.frame = self.bounds;
    
    [_imgPrev setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_imgCurrent setFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [_imgNext setFrame:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [_imgFour setFrame:CGRectMake(3*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];

    [self bringSubviewToFront:_pageControl];
}

/**
 *  启动函数
 *
 *  @param imageArray 图片数组
 *
 */

- (void)startAdsWithMoneys:(NSArray *)moneyArray tipArray:(NSArray *)tipArray timerInterval:(NSTimeInterval)interval{
    if(moneyArray.count <= 1)
        _scView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _pageControl.numberOfPages = moneyArray.count;
    _arrImage = moneyArray;
    _arrTip = tipArray;
    _iDisplayTime = (moneyArray.count > 1)? interval:0;
    
    [self stopTimer];
    [self reloadImages];
}
/**
 *  点击广告
 */
- (void)tapAds
{
    if(_delegate && [_delegate respondsToSelector:@selector(pageView:clickPageIndex:)])
    {
        [_delegate pageView:self clickPageIndex:_indexShow];
    }
}

/**
 *  长按广告
 */
- (void)longPressAds:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self stopTimer];
    }else if (gesture.state == UIGestureRecognizerStateEnded) {
        [self startTimer];
    }
}


/**
 *  加载图片顺序
 */
- (void)reloadImages {
    if (_indexShow >= (NSInteger)_arrImage.count)
        _indexShow = 0;
    if (_indexShow < 0)
        _indexShow = _arrImage.count - 1;
    NSInteger prev = _indexShow - 1;
    if (prev < 0)
        prev = (int)_arrImage.count - 1;
    NSInteger next = _indexShow + 1;
    if (next > _arrImage.count - 1)
        next = 0;
    NSInteger four = _indexShow + 2;
    if (four > _arrImage.count - 1)
        four = 0;
    _pageControl.currentPage = _indexShow;
    NSString* prevImage = [_arrImage objectAtIndex:prev];
    NSString* curImage = [_arrImage objectAtIndex:_indexShow];
    NSString* nextImage = [_arrImage objectAtIndex:next];
     NSString* fourImage = [_arrImage objectAtIndex:four];

    [_scView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    
    if (_iDisplayTime > 0)
    {
        [self startTimer];
    }
    [self bringSubviewToFront:_pageControl];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

/**
 *  切换图片完毕事件
 *
 *  @param scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self stopTimer];
    
    if (scrollView.contentOffset.x >=self.frame.size.width*2)
        _indexShow++;
    else if (scrollView.contentOffset.x < self.frame.size.width)
        _indexShow--;
    [self reloadImages];
}


/**
 *  轮播图片
 */
- (void)doImageGoDisplay {
    [_scView scrollRectToVisible:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height) animated:YES];
    _indexShow++;
    [self performSelector:@selector(reloadImages) withObject:nil afterDelay:0.3];
}

- (void)setWebImage:(UIImageView *)imgView imgUrl:(NSString *)imgUrl
{
    [imgView lc_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"common_default_ads"]];
}

- (void)startTimer
{
    if(!_myTimer){
        _myTimer = [NSTimer timerWithTimeInterval:_iDisplayTime target:self selector:@selector(doImageGoDisplay) userInfo:nil repeats:YES];
        NSRunLoop *loop = [NSRunLoop currentRunLoop];
        [loop addTimer:_myTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer
{
    // 停止计时器
    if (_myTimer){
        [_myTimer invalidate];
        self.myTimer = nil;
    }
}

@end
