//
//  PlaceModel.h
//  HXAXProject
//
//  Created by 苏荷 on 15/8/12.
//  Copyright (c) 2015年 BlueMobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import "GeogerChange.h"

@class PlaceModel;

typedef void(^successBlock)(NSString *errorMsg,PlaceModel *model);

@interface PlaceModel : NSObject<CLLocationManagerDelegate>

+ (PlaceModel *)sharedManager;

@property (nonatomic,assign) double longitude;

@property (nonatomic,assign) double latitude;

@property (nonatomic,copy) NSString *province;

@property (nonatomic,copy) NSString *city;

@property (nonatomic,copy) NSString *area;

@property (nonatomic,copy) NSString *addressName;

@property (nonatomic,strong) CLLocationManager *locationManager;

@property (nonatomic,strong) CLGeocoder          *geocoder;

@property (nonatomic,copy) successBlock success;

- (void)getLocationWithSuccess:(successBlock)success;

- (BOOL)hasLocatedSuccess;   //是否定位成功

@end
