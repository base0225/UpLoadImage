//
//  ZJPHAssertManger.h
//  UpLoadImage
//
//  Created by zhujia on 2019/4/20.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, ZJAssetAuthorizationStatus) {
    ZJAssetAuthorizationStatusNotDetermined,
    ZJAssetAuthorizationStatusAuthorized,
    ZJAssetAuthorizationStatusNotAuthorized
};

NS_ASSUME_NONNULL_BEGIN

@interface ZJPHAssertManger : NSObject

+ (ZJAssetAuthorizationStatus)authorizationStatus;

+ (void)requestAuthorization:(void(^)(ZJAssetAuthorizationStatus stauts))handler;

@end

NS_ASSUME_NONNULL_END
