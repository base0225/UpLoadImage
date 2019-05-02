//
//  ZJAssetBrowserViewController.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/29.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJAssetBrowserViewController.h"
#import "ZJBrowserCollectionCell.h"

@interface ZJAssetBrowserViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIView *topBarView;

@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayout;

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
    
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, (self.view.height - 180.0f)/2.0f, self.view.width, 180.0f) collectionViewLayout:_collectionLayout];
    _mainCollectionView.pagingEnabled = YES;
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    _mainCollectionView.backgroundColor = [UIColor blackColor];
    _mainCollectionView.showsHorizontalScrollIndicator = NO;
    _mainCollectionView.alwaysBounceVertical = YES;
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
//    if(indexPath.row % 2 == 0){
//        cell.backgroundColor = [UIColor redColor];
//    }else{
//        cell.backgroundColor = [UIColor greenColor];
//    }
    [cell bindMode:asset];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height)/3.0f);
}


#pragma mark -- UIEvent
- (void)dismissViewController:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
