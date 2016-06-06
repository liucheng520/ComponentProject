//
//  GeogerChange.m
//  HXAXProject
//
//  Created by 苏荷 on 15/10/22.
//  Copyright (c) 2015年 BlueMobi. All rights reserved.
//

#import "GeogerChange.h"

@implementation GeogerChange

const double x_pi = 3.14159265358979324 * 3000.0 / 180.0;

+ (GeogerChange *)bd_encryptggLat:(double) gg_lat ggLon:(double)gg_lon
{
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    GeogerChange *geo = [[GeogerChange alloc]init];
    geo.bd_lon = z * cos(theta) + 0.0065;
    geo.bd_lat = z * sin(theta) + 0.006;
    return geo;
}

+ (GeogerChange *)bd_decryptbdLat:(double)bd_lat bdLon:(double)bd_lon
{
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    GeogerChange *geo = [[GeogerChange alloc]init];
    geo.gg_lon = z * cos(theta);
    geo.gg_lat = z * sin(theta);
    return geo;
}
@end
