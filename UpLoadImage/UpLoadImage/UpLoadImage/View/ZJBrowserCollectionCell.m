//
//  ZJBrowserCollectionCell.m
//  UpLoadImage
//
//  Created by zhujia on 2019/5/1.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJBrowserCollectionCell.h"
#import "ZJAssets.h"

@interface ZJBrowserCollectionCell ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;

@property (nonatomic, strong) ZJAssets *tempAssets;

@end

@implementation ZJBrowserCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self constructView];
    }
    return self;
}

- (void)constructView{
 
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, self.width, self.height);
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.showsHorizontalScrollIndicator = false;
    _scrollView.showsVerticalScrollIndicator = false;
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _scrollView.minimumZoomScale = 1.0f;
    _scrollView.maximumZoomScale = 3.0f;
    _scrollView.zoomScale = 1.0f;
    _scrollView.contentOffset = CGPointZero;
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.bouncesZoom = YES;
    _scrollView.multipleTouchEnabled = YES;
    _scrollView.scrollsToTop = NO;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.delaysContentTouches = NO;
    _scrollView.canCancelContentTouches = YES;
    [self addSubview:_scrollView];
    
    _imgView = [[UIImageView alloc] init];
    _imgView.clipsToBounds = YES;
    [_scrollView addSubview:_imgView];
    
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView {
    
    CGFloat offsetX = ([UIScreen mainScreen].bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,scrollView.contentSize.height * 0.5 + offsetY);
    
    return center;
}

- (void)bindMode:(ZJAssets *)assets{
    
    _tempAssets = assets;
    [_tempAssets requestPreviewImageWithCompletion:^(UIImage *result, NSDictionary<NSString *,id> * info) {
        if(result){
            dispatch_async(dispatch_get_main_queue(), ^{
                CGFloat imageWidth = [UIScreen mainScreen].bounds.size.width;
                CGFloat imageHeight = result.size.height * imageWidth / result.size.width;
                self->_imgView.width = imageWidth;
                self->_imgView.height = imageHeight;
                self->_imgView.image = result;
                self->_scrollView.contentSize = self->_imgView.size;
                self->_imgView.center = [self centerOfScrollViewContent:self->_scrollView];
            });
        }
    } withProgressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
        
    }];
    
}


- (void)onSingleTap:(UIGestureRecognizer *)gesture{
    NSLog(@"点按了屏幕");
}

- (void)onDoubleTap:(UIGestureRecognizer *)gesture{
    NSLog(@"双击了屏幕");
}


- (UITapGestureRecognizer *)singleTap {
    
    if (!_singleTap) {
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
        _singleTap.numberOfTapsRequired = 1;
        _singleTap.numberOfTouchesRequired = 1;
        [_singleTap requireGestureRecognizerToFail:self.doubleTap];
    }
    return _singleTap;
}

- (UITapGestureRecognizer *)doubleTap {
    
    if (!_doubleTap) {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleTap:)];
        _doubleTap.numberOfTapsRequired = 2;
        _doubleTap.numberOfTouchesRequired = 1;
    }
    return _doubleTap;
}

@end
