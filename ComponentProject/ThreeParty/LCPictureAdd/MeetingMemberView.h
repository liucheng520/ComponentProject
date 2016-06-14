//
//  MeetingMemberView.h
//  CSCECProject
//
//  Created by 刘成 on 16/5/4.
//  Copyright © 2016年 WaterBearStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeetingMemberView;

#define kCellReuse @"MeetingMemberCell"

@protocol MeetingMemberViewDelegate <NSObject>

- (void)memberView:(MeetingMemberView *)view oldMembers:(NSArray *)oldMembers;

@end

@interface MeetingMemberView : UIView

@property (nonatomic,strong) NSArray *members;

@property (nonatomic,copy) NSString *promt;

@property (nonatomic,weak) id<MeetingMemberViewDelegate> delegate;

@end
