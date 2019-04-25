//
//  ZJAssetGridViewController.m
//  UpLoadImage
//
//  Created by zhujia on 2019/4/20.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJAssetGridViewController.h"
#import "ZJGridCollectionCell.h"
#import "ZJPostViewController.h"

static CGFloat kZJAssetGridCellEdgeInset = 2;

@interface ZJAssetGridViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *topBarView;

@property (nonatomic, strong) ZJAssertCollection *collection;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;

@end

@implementation ZJAssetGridViewController

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


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZJGridCollectionCell *gridCollectionCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ZJGridCollectionCell" forIndexPath:indexPath];
    if(indexPath.row % 2 == 0){
        gridCollectionCell.backgroundColor = [UIColor redColor];
    }else{
        gridCollectionCell.backgroundColor = [UIColor greenColor];
    }
    return gridCollectionCell;
}


#pragma mark -- UIEvent
- (void)cancel:(id)sender{
    //回到特定的控制器
    UIViewController *presentingVc = self.presentingViewController;
    while (presentingVc.presentingViewController) {
        presentingVc = presentingVc.presentingViewController;
        if([presentingVc isKindOfClass:[ZJPostViewController class]]){
            break;
        }
    }
    if(presentingVc){
        //发送一个通知回去
        [[NSNotificationCenter defaultCenter] postNotificationName:@"zjgridArray" object:@{@"array":@[@"1111"]}];
        [presentingVc dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)dismissViewController:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark -- UI

- (void)constructCollectionView{
    _collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionViewLayout.sectionInset = UIEdgeInsetsMake(kZJAssetGridCellEdgeInset, kZJAssetGridCellEdgeInset, kZJAssetGridCellEdgeInset, kZJAssetGridCellEdgeInset);
    _collectionViewLayout.minimumLineSpacing = kZJAssetGridCellEdgeInset;
    _collectionViewLayout.minimumInteritemSpacing = kZJAssetGridCellEdgeInset;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_collectionViewLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollsToTop = NO;
    [_collectionView registerClass:[ZJGridCollectionCell class] forCellWithReuseIdentifier:@"ZJGridCollectionCell"];
    [self.view addSubview:self.collectionView];
    [_collectionView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_collectionView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_collectionView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topBarView];
    [_collectionView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
}

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
        
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.text = @"相机胶卷";
        [_topBarView addSubview:titleLable];
        [titleLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [titleLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.translatesAutoresizingMaskIntoConstraints = NO;
        [rightButton setTitle:@"取消" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [_topBarView addSubview:rightButton];
        [rightButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.0f];
        [rightButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
    }
    return _topBarView;
}

- (void)refreshpPage:(ZJAssertCollection *)collection
{
    _collection = collection;
}

@end
