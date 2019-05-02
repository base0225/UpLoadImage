//
//  ZJDynamicImageCell.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/17.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJDynamicImageCell.h"
#import "ZJAssets.h"

@interface ZJDynamicImageCell ()

@property (nonatomic, strong) UIImageView *zjImageView;
@property (nonatomic, strong) ZJAssets *tempAssets;

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

- (void)bindMode:(ZJAssets *)assets{
    _tempAssets = assets;
    [_tempAssets requestPreviewImageWithCompletion:^(UIImage * _Nonnull result, NSDictionary<NSString *,id> * _Nonnull info) {
        if(result){
            dispatch_async(dispatch_get_main_queue(), ^{
                //                CGFloat imageWidth = [UIScreen mainScreen].bounds.size.width;
                //                CGFloat imageHeight = [UIScreen mainScreen].bounds.size.height;
                //                self.imgView.width = imageWidth;
                //                self.imgView.height = imageHeight;
                self.zjImageView.image = result;
                //                self.scrollView.contentSize = CGSizeMake(self.imgView.width, self.imgView.height);
                //                self.imgView.center = [self centerOfScrollViewContent:_scrollView];
            });
        }
    } withProgressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
        
    }];
}


@end
