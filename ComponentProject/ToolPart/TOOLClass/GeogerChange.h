//
//  GeogerChange.h
//  HXAXProject
//
//  Created by 苏荷 on 15/10/22.
//  Copyright (c) 2015年 BlueMobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeogerChange : NSObject

//百度经纬度
@property (nonatomic,assign) double bd_lon;

@property (nonatomic,assign) double bd_lat;

//高德经纬度
@property (nonatomic,assign) double gg_lon;

@property (nonatomic,assign) double gg_lat;

//高德 －》百度
+ (GeogerChange *)bd_encryptggLat:(double) gg_lat ggLon:(double)gg_lon;

//百度－》高德
+ (GeogerChange *)bd_decryptbdLat:(double)bd_lat bdLon:(double)bd_lon;

@end
