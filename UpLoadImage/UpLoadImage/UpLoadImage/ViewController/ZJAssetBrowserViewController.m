//
//  ZJAssetBrowserViewController.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/29.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJAssetBrowserViewController.h"
#import "ZJBrowserCollectionCell.h"

static CGFloat kMargin = 20.0f;

@interface ZJAssetBrowserViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIView *topBarView;

@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayout;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation ZJAssetBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.topBarView];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:[[UIApplication sharedApplication] statusBarFrame].size.height];
    [self.topBarView autoSetDimension:ALDimensionHeight toSize:44.0f];
    
    [self constructCollectionView];
    
}

- (void)constructCollectionView{
    
    _collectionLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionLayout.minimumLineSpacing = 0;
    _collectionLayout.minimumInteritemSpacing = 0;
    _collectionLayout.itemSize = CGSizeMake(self.view.width + 20.0f, self.view.height - 64.0f);
    
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64.0f, self.view.width + 20.0f, self.view.height - 64.0f) collectionViewLayout:_collectionLayout];
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    _mainCollectionView.backgroundColor = [UIColor blackColor];
    _mainCollectionView.showsHorizontalScrollIndicator = NO;
    _mainCollectionView.alwaysBounceVertical = YES;
    _mainCollectionView.pagingEnabled = YES;
    [_mainCollectionView registerClass:[ZJBrowserCollectionCell class] forCellWithReuseIdentifier:@"ZJBrowserCollectionCell"];
    _mainCollectionView.contentSize = CGSizeMake(self.dataSource.count * (self.view.width + 20.0f), 0);
    [self.view addSubview:_mainCollectionView];
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZJBrowserCollectionCell *cell = [self.mainCollectionView dequeueReusableCellWithReuseIdentifier:@"ZJBrowserCollectionCell" forIndexPath:indexPath];
    ZJAssets *asset = [self.dataSource objectAtIndex:indexPath.row];
    [cell bindMode:asset];
    return cell;
    
}


#pragma mark -- UIEvent
- (void)dismissViewController:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateContentOffset {
    if (_mainCollectionView.contentOffset.x != self.currentIndex * (kMargin + self.view.width)) {
        _mainCollectionView.contentOffset = CGPointMake(self.currentIndex * (kMargin + self.view.width), 0);
    }
}


#pragma mark -- UI

- (UIView *)topBarView{
    if(!_topBarView){
        
        _topBarView = [[UIView alloc] init];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor grayColor];
        [_topBarView addSubview:lineView];
        [lineView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:44.0f];
        [lineView autoSetDimension:ALDimensionHeight toSize:1.0f];
        [lineView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [lineView autoPinEdgeToSuperviewEdge:ALEdgeRight];

        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:[UIImage imageNamed:@"zj_back"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(dismissViewController:) forControlEvents:UIControlEventTouchUpInside];
        [_topBarView addSubview:leftButton];
        [leftButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20.0f];
        [leftButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [leftButton autoSetDimensionsToSize:CGSizeMake(30, 40)];
    }
    return _topBarView;
}

@end
