//
//  ZJAlbumTableViewCell.h
//  UpLoadImage
//
//  Created by zhujia on 2019/4/23.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJAlbumTableViewCell : UITableViewCell

- (void)bindmodel:(NSString *)text andimage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
