//
//  LCMenuBar.h
//  YBKProject
//
//  Created by 刘成 on 16/5/11.
//  Copyright © 2016年 bluemobi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectIndex)(NSInteger);

@interface LCMenuBar : UIView

/**
 *  Create the menuBar
 *
 *  @param  frame menuFrame number of Tab
 *
 *  @return menuBar
 */
- (instancetype)initWithFrame:(CGRect)frame numberOfTab:(NSInteger)numberOfTab;
/**
 *  set the menu message
 *
 *  @param  title menuTitle, imgName imageName
 */
- (void)setTitle:(NSString *)title img:(NSString *)imgName atIndex:(NSInteger)index;
/**
 *  you can choose the second or third index
 *
 *  @param select the index
 */
- (void)setOrinalSeletAtIndex:(NSInteger)index;
/**
 *  show the menuBar
 */
- (void)showMenuBarOnView:(UIView *)view menuBarChange:(void (^) (NSInteger index))selectIndex;
/**
 *  the containView hold the show view
 */
@property (nonatomic,strong) UIScrollView *containView;
/**
 *  set badgeValue on the index
 */
- (void)setBadgeValue:(NSInteger)badge atIndex:(NSInteger)index;

@end

@interface menuBarButton : UIButton

@property (nonatomic,assign) NSInteger badgeValue;

@end