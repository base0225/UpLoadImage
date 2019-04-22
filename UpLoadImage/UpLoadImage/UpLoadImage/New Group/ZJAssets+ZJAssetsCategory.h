//
//  ZJAssets+ZJAssetsCategory.h
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/22.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJAssets.h"
#import <Photos/PHCollection.h>
#import <photos/PHFetchOptions.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJAssets (ZJAssetsCategory)

//获取系统相册
+ (NSArray<PHAssetCollection *> *)fetchAllAlbumWithType:(NSInteger)type showEmptyAlbum:(BOOL)showEmptyAlbum showSmartAlbum:(BOOL)showSmartAlbum;

//+ (PHFetchOptions *)createFetchOptionWithAlbumType:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
