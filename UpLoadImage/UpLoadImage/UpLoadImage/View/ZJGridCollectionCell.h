//
//  ZJGridCollectionCell.h
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/24.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJGridCollectionCell : UICollectionViewCell

@property(nonatomic, copy) NSString *assetIdentifier;

@property (nonatomic, strong) UIButton *checkBoxButton;

- (void)bindMode:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
