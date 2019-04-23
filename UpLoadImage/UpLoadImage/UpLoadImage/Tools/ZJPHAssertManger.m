//
//  ZJPHAssertManger.m
//  UpLoadImage
//
//  Created by zhujia on 2019/4/20.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJPHAssertManger.h"
#import <Photos/PHPhotoLibrary.h>
#import "ZJAssertCollection.h"
#import "ZJAssets+ZJAssetsCategory.h"

@interface ZJPHAssertManger()

@property (nonatomic, strong) ZJAssertCollection *firstCollection;
@property (nonatomic, strong) PHCachingImageManager *phCachingImageManager;

@end

@implementation ZJPHAssertManger

+ (instancetype)shareInstance{
    static ZJPHAssertManger *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZJPHAssertManger alloc] init];
    });
    return instance;
}

+ (ZJAssetAuthorizationStatus)authorizationStatus{
    ZJAssetAuthorizationStatus status;
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    if(authorizationStatus == PHAuthorizationStatusRestricted || authorizationStatus == PHAuthorizationStatusDenied){
        status = ZJAssetAuthorizationStatusNotDetermined;
    }else if(authorizationStatus == PHAuthorizationStatusNotDetermined){
        status = ZJAssetAuthorizationStatusNotDetermined;
    }else{
        status = ZJAssetAuthorizationStatusNotDetermined;
    }
    return status;
}

+ (void)requestAuthorization:(void (^)(ZJAssetAuthorizationStatus))handler{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus phStatus) {
        ZJAssetAuthorizationStatus status;
        if(phStatus == PHAuthorizationStatusRestricted || phStatus == PHAuthorizationStatusDenied){
            status = ZJAssetAuthorizationStatusNotAuthorized;
        } else if (phStatus == PHAuthorizationStatusNotDetermined) {
            status = ZJAssetAuthorizationStatusNotDetermined;
        } else {
            status = ZJAssetAuthorizationStatusAuthorized;
        }
        if (handler) {
            handler(status);
        }
    }];
}

- (void)enumberateAllAlbumsWithType:(NSInteger)type showEmptyAlbum:(BOOL)showEmptyAlbum showSmartAlbum:(BOOL)showSmartAlbum block:(void(^)(ZJAssertCollection *))block{
    
    //获取全部相册
    NSArray<PHAssetCollection *> *tempAlbumsArray = [ZJAssets fetchAllAlbumWithType:type showEmptyAlbum:showSmartAlbum showSmartAlbum:showSmartAlbum];
    PHFetchOptions *options = [PHFetchOptions new];
    if(type == 1){
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i", PHAssetMediaTypeImage];
    }
    
    for(PHAssetCollection *collection in tempAlbumsArray){
        ZJAssertCollection *zjCollection = [[ZJAssertCollection alloc] initWithPHCollection:collection fetchOption:options];
        if(collection == [tempAlbumsArray firstObject]){
            _firstCollection = zjCollection;
        }
        if(block){
            block(zjCollection);
        }
    }
    if(block){
        block(nil);
    }
}

- (PHCachingImageManager *)phCachingImageManager{
    if(!_phCachingImageManager){
        _phCachingImageManager = [PHCachingImageManager new];
    }
    return _phCachingImageManager;
}



@end
