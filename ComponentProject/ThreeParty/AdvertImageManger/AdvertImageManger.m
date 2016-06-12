//
//  AdImageManger.m
//  ZJBuildingProject
//
//  Created by Scott on 16/4/5.
//  Copyright © 2016年 bluemobi. All rights reserved.
//

#import "AdvertImageManger.h"
#import "AFNHttpTool.h"

#define KADIMAGE_KEY      @"ADIMAGE_KEY"      //保存广告页图片的key
#define KADIMAGE_KEY_ID   @"ADIMAGE_KEY_ID"   //保存广告页的ID 判断是否需要更新
#define KADIMAGE_KEY_ADVERTURL @"KADIMAGE_KEY_advertUrl"  //保存广告对应的跳转路径
#define KADIMAGE_KEY_ADVERTTITLE @"KADIMAGE_KEY_ADVERTTITLE" //保存广告Title


@implementation AdvertImageManger

/**
 *  单例
 */
+ (instancetype)sharedManager
{
    static AdvertImageManger *sg_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sg_manager = [AdvertImageManger new];
    });
    return sg_manager;
}

/**
 *  更新
 */
- (void)updateAdvertImage
{
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
            
            //网络请求新的广告
            [self queryForNewAdvertImage];
        }
    }];
    [manger startMonitoring];
}

/**
 *  请求是否有新的广告页面 , 更换为新的网络图片方法
 */
- (void)queryForNewAdvertImage
{
    //TODO:请求是否有新的广告页，如果有则下载，然后存储
    [AdvertImgTool getAdvertImageWithSuccess:^(BOOL isSuc, id json) {
        if (isSuc) {
            
#warning 一下数据解析根据具体项目进行修改
            NSArray *adList = [AdvertModel mj_objectArrayWithKeyValuesArray:json[@"data"][@"list"]];
            if(adList.count > 0)
            {
                AdvertModel *ad = [adList firstObject];
                
                //比对图片ID，如果后台图片url变换，可直接用图片url做key
                NSString *oldAdId = [NSString getStringWithKey:KADIMAGE_KEY_ID];
                
                if(![ad.ADId isEqualToString:oldAdId])
                {
                    //下载并存储图片
                    NSURL *imageUrl = [NSURL URLWithString:ad.imgurl.absolutePath];
                    [self downloadAdImageWithURL:imageUrl inAdvertModel:ad];
                }
            }

        }
    }];
}


/**
 *  下载图片
 *
 *  @param imageURL   下载URL
 *  @param saveModel  model
 */
- (void)downloadAdImageWithURL:(NSURL *)imageURL inAdvertModel:(AdvertModel *)saveModel
{
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:imageURL
                             options:SDWebImageDownloaderContinueInBackground
                            progress:nil
                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished){
         
         //图片下载成功，进行缓存
         if(image)[self storeAdImageWithImage:image forSaveAdvertModel:saveModel];
     }];
}

/**
 *  存储启动广告页，以备下次使用
 */
- (void)storeAdImageWithImage:(UIImage *)image forSaveAdvertModel:(AdvertModel *)model
{
    SDImageCache *cacheManger = [SDImageCache sharedImageCache];
    
    [cacheManger removeImageForKey:KADIMAGE_KEY withCompletion:^{
        
        [cacheManger storeImage:image forKey:KADIMAGE_KEY toDisk:YES];
        //存储图片ID
        [NSString saveString:model.ADId Key:KADIMAGE_KEY_ID];
        //存储广告跳转路径
        [NSString saveString:model.ADUrl Key:KADIMAGE_KEY_ADVERTURL];
        //存储广告title
        [NSString saveString:model.ADTitle Key:KADIMAGE_KEY_ADVERTURL];
    }];
    
}

//是否有可用的启动广告页
- (UIImage *)avaliableAdvertImage
{
    SDImageCache *cacheManger = [SDImageCache sharedImageCache];
    
    UIImage *startAdImage = [cacheManger imageFromDiskCacheForKey:KADIMAGE_KEY];
    
    return startAdImage;
}

- (NSString *)advertTitle
{
    return [NSString getStringWithKey:KADIMAGE_KEY_ADVERTTITLE];
}

- (NSString *)advertUrl
{
    return [NSString getStringWithKey:KADIMAGE_KEY_ADVERTURL];
}

@end

@implementation AdvertModel

@end

@implementation AdvertImgTool

/**
 *  需要自己添加请求参数
 */
+ (void)getAdvertImageWithSuccess:(void (^)(BOOL, id))success
{
    NSString *method = [NSString stringWithFormat:@"%@%@",Base_URL,AdvertImgMethod];
    NSDictionary *param = @{};
    [AFNHttpTool POSTWithMethod:method Params:param success:^(BOOL isSuc, id json) {
        if (success) success(isSuc,json);
    } failure:^(NSError *error) {}];
}

@end
