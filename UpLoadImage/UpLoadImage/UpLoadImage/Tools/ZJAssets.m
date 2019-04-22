//
//  ZJAssets.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/22.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJAssets.h"

@interface ZJAssets (){
    PHAsset *_phAsset;
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

@end
