//
//  ZJAssertCollection.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/22.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJAssertCollection.h"

@interface ZJAssertCollection ()

@property (nonatomic, strong) PHAssetCollection *phCollection;

@end

@implementation ZJAssertCollection

- (instancetype)initWithPHCollection:(PHAssetCollection *)phCollection fetchOption:(PHFetchOptions *)options{
    if(self = [super init]){
        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:phCollection options:options];
        self.phCollection = phCollection;
    }
    return self;
}

- (NSString *)name{
    return self.phCollection.localizedTitle;
}

@end
