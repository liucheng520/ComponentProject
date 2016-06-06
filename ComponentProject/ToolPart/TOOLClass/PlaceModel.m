//
//  PlaceModel.m
//  HXAXProject
//
//  Created by 苏荷 on 15/8/12.
//  Copyright (c) 2015年 BlueMobi. All rights reserved.
//

#import "PlaceModel.h"

@implementation PlaceModel

+ (PlaceModel *)sharedManager
{
    static PlaceModel *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (void)getLocationWithSuccess:(successBlock)success
{
    _success = success;
    
    // 1） 实例化定位管理器
    _locationManager = [[CLLocationManager alloc]init];
    
    // 2) 设置定位管理器的代理
    [_locationManager setDelegate:self];
    
    // 3) 设置定位管理器的精度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyKilometer];
    
    // 4) 实例化geocoder
    _geocoder = [[CLGeocoder alloc]init];
    
    
    if (![CLLocationManager locationServicesEnabled]) {
        
        _success(@"定位服务已被关闭，请前往设置页面打开!",self);
        
    }else if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){//如果没有授权则请求用户授权
        
        [_locationManager requestWhenInUseAuthorization];
        
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
    
        // 5) 开启用户定位功能
        [_locationManager startUpdatingLocation];
        
    } else {
        _success(@"没有开启定位服务",self);
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (locations[0]) {
        [manager stopUpdatingLocation];
        CLLocation *location = locations[0];
        GeogerChange *geo = [GeogerChange bd_encryptggLat:location.coordinate.latitude ggLon:location.coordinate.longitude];
        self.longitude = geo.bd_lon;
        self.latitude = geo.bd_lat;
    }
    
    [_geocoder reverseGeocodeLocation:locations[0] completionHandler:^(NSArray *placemarks, NSError *error) {
        
        // placemarks 地点、地标
        CLPlacemark *placemark = placemarks[0];
        self.province = placemark.administrativeArea;
        self.city = placemark.locality;
        self.area = placemark.subLocality;
        self.addressName = placemark.thoroughfare;
        if(!error){
            _success(@"",self);
        }else{
            _success(@"定位解析地址失败",self);
        }

    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    _success(@"定位失败",self);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [_locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusNotDetermined:
            [_locationManager requestWhenInUseAuthorization];
        default:
            break;
    }
}


- (BOOL)hasLocatedSuccess
{
    return (self.province.length > 0 && self.city.length > 0);
}

@end
