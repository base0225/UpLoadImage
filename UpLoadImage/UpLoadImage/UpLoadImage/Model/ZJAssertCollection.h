//
//  ZJAssertCollection.h
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/22.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/PHCollection.h>
#import <Photos/PHAsset.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJAssertCollection : NSObject

@property (nonatomic, strong, readonly) PHAssetCollection *phCollection;

- (instancetype)initWithPHCollection:(PHAssetCollection *)phCollection fetchOption:(PHFetchOptions *)options;

//相册名
- (NSString *)name;

@end

NS_ASSUME_NONNULL_END
