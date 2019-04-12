//
//  UIView+Position.h
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/12.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Position)


@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;
/** View's width */
@property (nonatomic, assign) CGFloat width;
/** View's height */
@property (nonatomic, assign) CGFloat height;

/**
 Centers the view to its parent view (if exists)
 */
-(void) centerToParent;

@end

NS_ASSUME_NONNULL_END
