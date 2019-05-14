//
//  UIView+Position.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/12.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "UIView+Position.h"


@implementation UIView (Position)
@dynamic x,y,width,height;

- (void)setX:(CGFloat)x{
    CGRect r = self.frame;
    r.origin.x = x;
    self.frame = r;
}

- (void)setY:(CGFloat)y{
    CGRect r = self.frame;
    r.origin.y = y;
    self.frame = r;
}

- (void)setWidth:(CGFloat)width{
    CGRect r = self.frame;
    r.size.width = width;
    self.frame = r;
}

-(void)setSize:(CGSize)size{
    self.width      = size.width;
    self.height     = size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect r = self.frame;
    r.size.height = height;
    self.frame = r;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height{
    return self.frame.size.height;
}

-(CGSize)size{
    return CGSizeMake(self.width, self.height);
}

- (void)centerToParent{
    
}

@end
