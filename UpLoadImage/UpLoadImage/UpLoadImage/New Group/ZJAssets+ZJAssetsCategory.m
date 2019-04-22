//
//  ZJAssets+ZJAssetsCategory.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/22.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJAssets+ZJAssetsCategory.h"

@implementation ZJAssets (ZJAssetsCategory)

//获取系统相册
+ (NSArray<PHAssetCollection *> *)fetchAllAlbumWithType:(NSInteger)type showEmptyAlbum:(BOOL)showEmptyAlbum showSmartAlbum:(BOOL)showSmartAlbum
{
 
    PHFetchOptions *options = [PHFetchOptions new];
    if(type == 1){
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %i", PHAssetMediaTypeImage];
    }
    NSMutableArray *tempAlbumArray = [NSMutableArray array];
    //系统相册
    PHFetchResult *fetchResult;
    if(showSmartAlbum){
        fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
    }else{
        fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    }
    
    for(PHAssetCollection *collection in fetchResult){
        if([collection isKindOfClass:[PHAssetCollection class]]){
            PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:options];
            if(result.count > 0 || showEmptyAlbum){
                //如果是相机，放在最前面
                if(collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary){
                    [tempAlbumArray insertObject:collection atIndex:0];
                }else{
                    [tempAlbumArray addObject:collection];
                }
            }else{
                NSAssert(NO, @"fetch collection err:%@",collection);
            }
        }
    }
    
    //用户创建相册
    PHFetchResult *userCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    for (PHAssetCollection *collection in userCollections) {
        if([collection isKindOfClass:[PHAssetCollection class]]){
            
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            if(showEmptyAlbum){
                [tempAlbumArray addObject:assetCollection];
            }else{
                PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
                if(result.count > 0){
                    [tempAlbumArray addObject:assetCollection];
                }
            }
        }else{
            NSAssert(NO, @"fetch collection err: %@",collection);
        }
    }
    
    NSArray *resultArray = [tempAlbumArray copy];
    return resultArray;
}

@end
