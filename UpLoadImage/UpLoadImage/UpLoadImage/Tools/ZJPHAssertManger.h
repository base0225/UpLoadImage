//
//  ZJPHAssertManger.h
//  UpLoadImage
//
//  Created by zhujia on 2019/4/20.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/PHImageManager.h>

@class ZJAssertCollection;

typedef NS_ENUM(NSInteger, ZJAssetAuthorizationStatus) {
    ZJAssetAuthorizationStatusNotDetermined,
    ZJAssetAuthorizationStatusAuthorized,
    ZJAssetAuthorizationStatusNotAuthorized
};

NS_ASSUME_NONNULL_BEGIN

@interface ZJPHAssertManger : NSObject

+ (instancetype)shareInstance;

+ (ZJAssetAuthorizationStatus)authorizationStatus;

- (PHCachingImageManager *)phCachingImageManager;

+ (void)requestAuthorization:(void(^)(ZJAssetAuthorizationStatus stauts))handler;

- (void)enumberateAllAlbumsWithType:(NSInteger)type showEmptyAlbum:(BOOL)showEmptyAlbum showSmartAlbum:(BOOL)showSmartAlbum block:(void(^)(ZJAssertCollection *))block;

@end

NS_ASSUME_NONNULL_END
