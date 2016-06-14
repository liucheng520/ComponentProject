//
//  LCMenuBar.m
//  YBKProject
//
//  Created by 刘成 on 16/5/11.
//  Copyright © 2016年 bluemobi. All rights reserved.
//

#import "LCMenuBar.h"

@interface LCMenuBar()<UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray *buttons;

@property (nonatomic,strong) UIImageView *hoverView;

@property (nonatomic,strong) menuBarButton *selectBtn;

@property (nonatomic,copy) SelectIndex block;

@end

@implementation LCMenuBar

- (instancetype)initWithFrame:(CGRect)frame numberOfTab:(NSInteger)numberOfTab
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self createSubViewsWithNumber:numberOfTab];
    }
    return self;
}

- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)createSubViewsWithNumber:(NSInteger)num
{
    for (NSInteger i = 0; i < num; i++) {
        menuBarButton *button = [[menuBarButton alloc] init];
        button.tag = 10 + i;
        [button addTarget:self action:@selector(menuBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:DEF_COLOR(48, 138, 225) forState:UIControlStateDisabled];
        [button setTitleColor:DEF_COLOR(90, 90, 90) forState:UIControlStateNormal];
        [self addSubview:button];
        [self.buttons addObject:button];
        if (i == 0) {
            [button setEnabled:NO];
            self.selectBtn = button;
        }
    }
    
    // orange hover
    UIImageView *hover = [[UIImageView alloc] init];
    hover.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [hover setBackgroundColor:DEF_COLOR(48, 138, 225)];
    hover.height = 2;
    hover.y = self.height - hover.height;
    [self addSubview:hover];
    self.hoverView = hover;
}

- (void)setTitle:(NSString *)title img:(NSString *)imgName atIndex:(NSInteger)index
{
    if (index < self.buttons.count) {
        menuBarButton *btn = self.buttons[index];
        [btn setTitle:title forState:UIControlStateNormal];
        if(imgName.length){
           [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        }
        [btn.titleLabel sizeToFit];
        
        if (index == 0) {
            [btn.titleLabel sizeToFit];
            CGFloat btnW = KScreenWidth / self.buttons.count;
            self.hoverView.width = btn.titleLabel.width;
            self.hoverView.centerX = btnW * 0.5;
        }
    }
}

- (void)setOrinalSeletAtIndex:(NSInteger)index
{
    if (index < self.buttons.count) {
        
        menuBarButton *chooseBtn = self.buttons[index];
        
        [self.selectBtn setEnabled:YES];
        [chooseBtn setEnabled:NO];
        self.selectBtn = chooseBtn;
        
        CGFloat btnW = KScreenWidth / self.buttons.count;
        
        self.hoverView.width = chooseBtn.titleLabel.width;
        self.hoverView.centerX = btnW * index + btnW * 0.5;
        
        // 滚动
        CGPoint offset = self.containView.contentOffset;
        offset.x = (chooseBtn.tag - 10) * self.containView.width;
        [self.containView setContentOffset:offset animated:YES];
    }
}

- (void)setBadgeValue:(NSInteger)badge atIndex:(NSInteger)index
{
    if (index < self.buttons.count) {
        menuBarButton *btn = self.buttons[index];
        [btn setBadgeValue:badge];
    }
}

- (UIScrollView *)containView
{
    if (!_containView) {
        _containView = [[UIScrollView alloc] init];
        _containView.showsHorizontalScrollIndicator = NO;
        _containView.showsVerticalScrollIndicator = NO;
        _containView.delegate = self;
        _containView.pagingEnabled = YES;
        _containView.bounces = NO;
    }
    return _containView;
}

- (void)showMenuBarOnView:(UIView *)view menuBarChange:(void (^)(NSInteger))selectIndex
{
    [view addSubview:self];
    self.containView.frame = view.bounds;
    self.containView.contentSize = CGSizeMake(self.buttons.count * view.width, 0);
    [view insertSubview:self.containView atIndex:0];
    _block = selectIndex;
}

- (void)menuBarButtonClick:(menuBarButton *)btn
{
    [self.selectBtn setEnabled:YES];
    [btn setEnabled:NO];
    self.selectBtn = btn;
    
    [btn setBadgeValue:0];
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.hoverView.width = btn.titleLabel.width;
        self.hoverView.centerX = btn.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.containView.contentOffset;
    offset.x = (btn.tag - 10) * self.containView.width;
    [self.containView setContentOffset:offset animated:YES];
    
    _block(btn.tag - 10);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self menuBarButtonClick:self.buttons[index]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnY = 0;
    CGFloat btnW = KScreenWidth / self.buttons.count;
    CGFloat btnH = self.height;
    for (NSInteger i = 0; i < self.buttons.count; i++) {
        menuBarButton *btn = self.buttons[i];
        btn.frame = CGRectMake(btnW * i, btnY, btnW, btnH);
    }
}

@end

@interface menuBarButton()

@property (nonatomic,weak) UILabel *badgeLabel;

@end

@implementation menuBarButton

- (instancetype)init
{
    if (self = [super init]) {
        
        [self.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *badgeLabel = [[UILabel alloc] init];
        [badgeLabel setBackgroundColor:[UIColor redColor]];
        [badgeLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [badgeLabel setTextAlignment:NSTextAlignmentCenter];
        [badgeLabel setTextColor:[UIColor whiteColor]];
        badgeLabel.hidden = YES;
        [self addSubview:badgeLabel];
        self.badgeLabel = badgeLabel;
    }
    return self;
}

- (void)setBadgeValue:(NSInteger)badgeValue
{
    _badgeValue = badgeValue;
    if (_badgeValue <= 0 ) {
        self.badgeLabel.hidden = YES;
    }else{
        self.badgeLabel.text = [NSString stringWithFormat:@"%ld",_badgeValue];
        self.badgeLabel.hidden = NO;
    }
}
/**
 *  delete the [btn setBadgeValue:0] on line 121
 *  when enable show，unenable dismiss, the badge only can dismiss by
 *  - (void)setBadgeValue:(NSInteger)badge atIndex:(NSInteger)index;
 */

//- (void)setEnabled:(BOOL)enabled
//{
//    [super setEnabled:enabled];
//  
//    if (enabled) { //取消
//        if (self.badgeValue > 0) {
//            self.badgeLabel.hidden = NO;
//        }
//    }else{ //点击
//        self.badgeLabel.hidden = YES;
//    }
//   
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.badgeLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) - 2.5, 2.5, 15, 15);
    self.badgeLabel.layer.cornerRadius = 7.5f;
    self.badgeLabel.layer.masksToBounds = YES;
}

@end
