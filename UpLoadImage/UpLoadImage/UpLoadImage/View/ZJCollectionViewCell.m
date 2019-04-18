//
//  ZJCollectionViewCell.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/12.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJCollectionViewCell.h"
#import "PureLayout.h"

@interface ZJCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZJCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subtitleLabel];
        
        [self setViewContraints];
    }
    return self;
}

- (void)setViewContraints{
    [self.imageView autoSetDimensionsToSize:CGSizeMake(70, 70)];
    [self.imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10.0f];
    
    [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.imageView withOffset:10.0f];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:15];
    
    [self.subtitleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.subtitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:10.0f];
    [self.subtitleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.subtitleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.subtitleLabel autoSetDimension:ALDimensionHeight toSize:12];
    
}


- (void)bindModel:(UIImage *)image andText:(NSString *)text{
    
    [self.imageView setImage:image];
    self.titleLabel.text = text;
    
}

#pragma makr -- UI

- (UIImageView *)imageView{
    if (!_imageView){
        _imageView=[[UIImageView alloc] init];
    }
    return  _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel=[UILabel new];
        _titleLabel.textAlignment =  NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    }
    return  _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel){
        _subtitleLabel=[UILabel new];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        _subtitleLabel.textColor = [UIColor grayColor];
        _subtitleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    }
    return  _subtitleLabel;
}

@end
