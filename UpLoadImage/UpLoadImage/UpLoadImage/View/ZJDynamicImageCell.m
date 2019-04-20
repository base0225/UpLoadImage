//
//  ZJDynamicImageCell.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/17.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJDynamicImageCell.h"

@interface ZJDynamicImageCell ()

@property (nonatomic, strong) UIImageView *zjImageView;

@end

@implementation ZJDynamicImageCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self constructView];
    }
    return self;
}


- (void)constructView{
    self.zjImageView = [[UIImageView alloc] initWithImage:nil];
    self.zjImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.zjImageView];
    
    [self.zjImageView autoPinEdgesToSuperviewEdges];
    
}


@end
