//
//  ZJAssertCollection.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/22.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJAssertCollection.h"
#import "ZJPHAssertManger.h"
#import "ZJAssets.h"

@interface ZJAssertCollection ()

@property (nonatomic, strong) PHAssetCollection *phCollection;
@property (nonatomic, strong) PHFetchResult *result;

@end

@implementation ZJAssertCollection

- (instancetype)initWithPHCollection:(PHAssetCollection *)phCollection fetchOption:(PHFetchOptions *)options{
    if(self = [super init]){
        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:phCollection options:options];
        self.phCollection = phCollection;
        self.result = result;
    }
    return self;
}

- (NSString *)name{
    return self.phCollection.localizedTitle;
}

- (NSInteger)numberOfAssets{
    return self.result.count;
}

- (UIImage *)thumbnailWithSize:(CGSize)size{
    __block UIImage *resultImage = [UIImage imageNamed:@"zj_live_default"];
    NSInteger count = self.result.count;
    if(count>0){
        PHAsset *asset = self.result[count - 1];
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.synchronous = YES;
        options.resizeMode = PHImageRequestOptionsResizeModeExact;
        [[[ZJPHAssertManger shareInstance] phCachingImageManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            resultImage = result;
        }];
    }
    
    return resultImage;
}

- (void)enumerateAssetsWithOptions:(NSInteger)type usingBlock:(void(^)(ZJAssets *))block{
    NSInteger resultCount = self.result.count;
    if(type == 1){
        for (NSInteger i = resultCount -1; i <= 0; i--) {
            PHAsset *phAsset = self.result[i];
            ZJAssets *asset = [[ZJAssets alloc] initWithPHAsset:phAsset];
            if(block){
                block(asset);
            }
        }
    }else{
        for(NSInteger i = 0; i < resultCount; i++){
            PHAsset *phAsset = self.result[i];
            ZJAssets *asset = [[ZJAssets alloc] initWithPHAsset:phAsset];
            if(block){
                block(asset);
            }
        }
    }
    //结束
    if(block){
        block(nil);
    }
}

@end
