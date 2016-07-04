//
//  HXMenuTableView.h
//  HXAXProject
//
//  Created by Scott on 15/11/26.
//  Copyright © 2015年 刘成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MenuStatus)
{
    MenuStatusNone  = 0,   /**<正常的默认状态*/
    MenuStatusSelected ,   /**<选中状态*/
    MenuStatusSpecial      /**<特殊状态*/
};

@interface MenuItem : NSObject

@property (nonatomic, copy) NSString *menuTitle;

@property (nonatomic, assign) MenuStatus status;


- (UIColor *)getTitleColor;

@end


@class HXMenuTableView;

@protocol HXMenuTableViewDelegate <NSObject>

- (void)menuTableView:(HXMenuTableView *)menueTableView didSelectRowAtIndex:(NSUInteger)index;

@end

@interface HXMenuTableView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) CGFloat tableRowHeight;

@property (nonatomic, weak) id<HXMenuTableViewDelegate> delegate;

- (void)reloadData;

@end





