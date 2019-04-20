//
//  ZJPHAssertManger.m
//  UpLoadImage
//
//  Created by zhujia on 2019/4/20.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJPHAssertManger.h"
#import <Photos/PHPhotoLibrary.h>

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



@end
