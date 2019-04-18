//
//  ZJDynamicImageCell.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/17.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJDynamicImageCell.h"

@implementation ZJDynamicImageCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self constructView];
    }
    return self;
}


- (void)constructView{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:button];
    
    [button autoSetDimensionsToSize:CGSizeMake(50, 50)];
    [button autoPinEdgesToSuperviewEdges];
    
    
}

@end
