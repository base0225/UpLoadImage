//
//  ZJAssets.h
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/22.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/PHAsset.h>
#import <Photos/PHImageManager.h>


typedef NS_ENUM(NSUInteger, ZJAssetType) {
    ZJAssetTypeUnknow,
    ZJAssetTypeImage,
    ZJAssetTypeVideo,
};

typedef NS_ENUM(NSUInteger, ZJAssetSubType) {
    ZJAssetSubTypeUnknow,
    ZJAssetSubTypeImage,
    ZJAssetSubTypeVideo,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZJAssets : NSObject

@property (nonatomic, assign ,readonly) ZJAssetType assetType;
@property (nonatomic, assign, readonly) ZJAssetSubType assetSubType;
@property (nonatomic, strong ,readonly) PHAsset *phAsset;
@property (nonatomic, copy, readonly) NSString *identifier;

- (instancetype)initWithPHAsset:(PHAsset *)phAsset;

- (void)requestThumbnailImageWithSize:(CGSize)size completion:(void(^)(UIImage *result,NSDictionary<NSString *, id> *info))completion;

- (void)requestPreviewImageWithCompletion:(void (^)(UIImage *result, NSDictionary<NSString *, id> *info))completion withProgressHandler:(PHAssetImageProgressHandler)phProgressHandler;

@end

NS_ASSUME_NONNULL_END
