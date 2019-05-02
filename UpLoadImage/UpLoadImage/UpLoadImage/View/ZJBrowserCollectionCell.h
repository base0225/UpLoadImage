//
//  ZJBrowserCollectionCell.h
//  UpLoadImage
//
//  Created by zhujia on 2019/5/1.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJAssets;

NS_ASSUME_NONNULL_BEGIN

@interface ZJBrowserCollectionCell : UICollectionViewCell

- (void)bindMode:(ZJAssets *)assets;

@end

NS_ASSUME_NONNULL_END
