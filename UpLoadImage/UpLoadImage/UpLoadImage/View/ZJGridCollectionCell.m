//
//  ZJGridCollectionCell.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/24.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJGridCollectionCell.h"

@interface ZJGridCollectionCell ()

@property (nonatomic, strong) UIImageView *contentImageView;

@end

@implementation ZJGridCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self constructView];
    }
    return self;
}

- (void)constructView{
    self.contentImageView = [[UIImageView alloc] init];
    self.contentImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.contentImageView];
    
    [self.contentImageView autoPinEdgesToSuperviewEdges];
}

- (void)bindMode:(UIImage *)image{
    [self.contentImageView setImage:image];
}

@end
