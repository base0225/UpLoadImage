//
//  ZJDynamicImageAddCell.m
//  UpLoadImage
//
//  Created by zhujia on 2019/4/18.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJDynamicImageAddCell.h"

@interface ZJDynamicImageAddCell()

@property (nonatomic, strong) UIImageView *addIcomImageView;
@property (nonatomic, strong) UILabel *addLabel;

@end

@implementation ZJDynamicImageAddCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.addIcomImageView];
        [self.contentView addSubview:self.addLabel];

        [self.addIcomImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.addIcomImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:25.0f];
        [self.addIcomImageView autoSetDimensionsToSize:self.addIcomImageView.image.size];
        
        [self.addLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.addIcomImageView withOffset:10];
        [self.addLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:2.0];
        [self.addLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:2.0];
    }
    return self;
}


- (void)bindmodelwithstr:(NSString *)str{
    self.addLabel.text = str;
}

#pragma mark -- lazy init
- (UIImageView *)addIcomImageView
{
    if (!_addIcomImageView) {
        _addIcomImageView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zj_community_add_cricle_icon"]];
    }
    return _addIcomImageView;
}

- (UILabel *)addLabel
{
    if (!_addLabel) {
        _addLabel = [[UILabel alloc] init];
        _addLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
        _addLabel.text = @"添加照片";
        _addLabel.textAlignment = NSTextAlignmentCenter;
        _addLabel.numberOfLines = 0;
    }
    return _addLabel;
}


@end
