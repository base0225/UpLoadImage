//
//  ZJAssets.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/22.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJAssets.h"
#import "ZJPHAssertManger.h"

@interface ZJAssets (){
    PHAsset *_phAsset;
    NSString *_identifier;
}

@property (nonatomic, copy) NSDictionary *phAssetInfo;
@property (nonatomic, assign) CGFloat imageSize;
@property (nonatomic, strong) NSString *localIdentifier;

@end

@implementation ZJAssets

- (instancetype)initWithPHAsset:(PHAsset *)phAsset{
    if(self = [super init]){
        _phAsset = phAsset;
        _localIdentifier = phAsset.localIdentifier;
        switch (phAsset.mediaType) {
            case PHAssetMediaTypeImage:
                _assetType = ZJAssetTypeImage;
                break;
            case PHAssetMediaTypeVideo:
                _assetType = ZJAssetTypeVideo;
            default:
                _assetType = ZJAssetTypeUnknow;
                break;
        }
    }
    return self;
}

- (NSString *)identifier{
    return _phAsset.localIdentifier;
}

- (NSInteger)requestThumbnailImageWithSize:(CGSize)size completion:(void(^)(UIImage *result,NSDictionary<NSString *, id> *info))completion{
    PHImageRequestOptions *imageRequestions = [[PHImageRequestOptions alloc] init];
    imageRequestions.resizeMode = PHImageRequestOptionsResizeModeFast;
    return [[[ZJPHAssertManger shareInstance] phCachingImageManager] requestImageForAsset:_phAsset targetSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) contentMode:PHImageContentModeAspectFill options:imageRequestions resultHandler:^(UIImage *result, NSDictionary *info) {
        if(completion){
            completion(result,info);
        }
    }];
}

@end
