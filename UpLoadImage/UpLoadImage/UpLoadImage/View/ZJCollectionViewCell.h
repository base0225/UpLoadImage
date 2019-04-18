//
//  ZJCollectionViewCell.h
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/12.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJCollectionViewCell : UICollectionViewCell

- (void)bindModel:(UIImage *)image andText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
