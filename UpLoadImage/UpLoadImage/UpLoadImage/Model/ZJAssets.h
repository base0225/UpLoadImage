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

- (instancetype)initWithPHAsset:(PHAsset *)phAsset;

@property (nonatomic, strong ,readonly) PHAsset *phAsset;

- (NSInteger)requestThumbnailImageWithSize:(CGSize)size completion:(void(^)(UIImage *result,NSDictionary<NSString *, id> *info))completion;


@end

NS_ASSUME_NONNULL_END
