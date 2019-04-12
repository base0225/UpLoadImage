//
//  ZJPublicViewController.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/12.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJPublicViewController.h"
#import "ZJCollectionViewCell.h"
#import "UIView+Position.h"
#import "PureLayout.h"

const static CGFloat iconWidth = 130;
const static CGFloat itemLineSpace = 10;
const static CGFloat bgHeight = 440;
static NSString *cellId = @"cellId";

@interface ZJPublicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *cancleView;

@end

@implementation ZJPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.cancleView];
    [self.view addSubview:self.bgView];
    
    [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    [self.bgView autoSetDimension:ALDimensionHeight toSize:bgHeight];
    
    [self.cancleView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    [self.cancleView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [self.cancleView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    [self.cancleView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.bgView];
    
//    [self.view addSubview:self.collectionView];
    
    
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *collectionCell = [[UICollectionViewCell alloc] init];
    return collectionCell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

#pragma mark -- UIEvent
- (void)hidePublishView{
    
}

#pragma mark -- UIView
- (UICollectionView *)collectionView{
    
    if(_collectionView){
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(iconWidth, iconWidth);
        flowLayout.minimumLineSpacing = itemLineSpace;
        flowLayout.minimumInteritemSpacing = 20;
        CGFloat insetLeft = (self.view.width - 2 * iconWidth - flowLayout.minimumInteritemSpacing)/2;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, insetLeft, 0, insetLeft);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ZJCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        
    }
    return _collectionView;
}

- (UIView *)cancleView{
    if (!_cancleView){
        _cancleView=[UIView new];
        _cancleView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [_cancleView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePublishView)]];
        
    }
    return  _cancleView;
}

- (UIView *)bgView{
    
    if(!_bgView){
        
        _bgView = [[UIView alloc] init];
        _bgView.translatesAutoresizingMaskIntoConstraints = NO;
        _bgView.backgroundColor = [UIColor whiteColor];
        UIBezierPath *maskPath =  [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.view.width, bgHeight)
                                                        byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight
                                                              cornerRadii:CGSizeMake(20, 20)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        //设置大小
        maskLayer.frame = CGRectMake(0, 0, self.view.width ,bgHeight);
        maskLayer.path = maskPath.CGPath;
        _bgView.layer.mask = maskLayer;
        
    }
    return _bgView;
}

@end
