//
//  LCPlaceHolderTextView.h
//  CSCECProject
//
//  Created by 刘成 on 16/4/28.
//  Copyright © 2016年 WaterBearStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCPlaceHolderTextView : UITextView

/**
 *  设置placeholder
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 *  设置placeholderColor
 */
@property (nonatomic, strong) UIColor *placeHolderColor;

/**
 *  设置placeholderFont
 */
@property (nonatomic,strong) UIFont *placeHolderFont;

@end
