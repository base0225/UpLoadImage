//
//  ZJAssetGridViewController.h
//  UpLoadImage
//
//  Created by zhujia on 2019/4/20.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJAssertCollection.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJAssetGridViewController : UINavigationController

- (void)refreshpPage:(ZJAssertCollection *)collection;

@end

NS_ASSUME_NONNULL_END
