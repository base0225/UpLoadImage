//
//  ZJDynamicImageCell.h
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/17.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJAssets;

NS_ASSUME_NONNULL_BEGIN

@interface ZJDynamicImageCell : UICollectionViewCell

- (void)bindMode:(ZJAssets *)assets;

@end

NS_ASSUME_NONNULL_END
