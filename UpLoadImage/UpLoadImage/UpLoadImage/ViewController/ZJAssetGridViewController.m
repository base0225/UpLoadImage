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
#import "ZJAssets.h"

static CGFloat kZJAssetGridCellEdgeInset = 2;

@interface ZJAssetGridViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *topBarView;

@property (nonatomic, strong) ZJAssertCollection *collection;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) UIView *bottomView;


@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) NSMutableArray *assetsDatasource;
@property (nonatomic, strong) NSMutableArray *selectedImageArray;

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
    
    [self.view addSubview:self.bottomView];
    [self constructCollectionView];
    
    [self.bottomView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.bottomView autoSetDimension:ALDimensionHeight toSize:44.0f];
    [self.bottomView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.bottomView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetsDatasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZJGridCollectionCell *gridCollectionCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ZJGridCollectionCell" forIndexPath:indexPath];
    ZJAssets *asset = [self.assetsDatasource objectAtIndex:indexPath.row];
    gridCollectionCell.assetIdentifier = asset.identifier;
    [asset requestThumbnailImageWithSize:CGSizeMake(150, 150) completion:^(UIImage * _Nonnull result, NSDictionary<NSString *,id> * _Nonnull info) {
        if([gridCollectionCell.assetIdentifier isEqualToString:asset.identifier]){
            [gridCollectionCell bindMode:result];
        }
    }];
    [gridCollectionCell.checkBoxButton addTarget:self action:@selector(clickCheckBox:event:) forControlEvents:UIControlEventTouchUpInside];
    return gridCollectionCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-8)/3.0f, ([UIScreen mainScreen].bounds.size.width-8)/3.0f);
}


#pragma mark -- UIEvent

- (void)completionBtn:(id)sender{
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"zjgridArray" object:@{@"array":self.selectedImageArray}];
        [presentingVc dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)prebBrower:(id)sender{
    
}

- (void)clickCheckBox:(UIButton *)button event:(UIEvent *)event{
    button.selected = !button.selected;
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    ZJAssets *asset = [self.assetsDatasource objectAtIndex:indexPath.row];
    
    if(button.selected){
        [self.selectedImageArray addObject:asset];
        
    }else{
        [self.selectedImageArray removeObject:asset];
    }
}

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
    [_collectionView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.bottomView];
}

- (UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor orangeColor];
        UIButton *completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [completeButton setTitle:@"完成" forState:UIControlStateNormal];
        [completeButton addTarget:self action:@selector(completionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:completeButton];
        
        UIButton *browerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [browerButton setTitle:@"预览" forState:UIControlStateNormal];
        [browerButton addTarget:self action:@selector(prebBrower:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:browerButton];
        
        [completeButton autoSetDimension:ALDimensionWidth toSize:84.0f];
        [completeButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [completeButton autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [completeButton autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [browerButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [browerButton autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [browerButton autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [browerButton autoSetDimension:ALDimensionWidth toSize:84.0f];
        
    }
    return _bottomView;
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
        
        self.titleLable = [[UILabel alloc] init];
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        self.titleLable.text = @"相机胶卷";
        [_topBarView addSubview:self.titleLable];
        [self.titleLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.titleLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
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
    self.titleLable.text = [collection name];
    
    if(!self.assetsDatasource){
        _assetsDatasource = [NSMutableArray array];
        _selectedImageArray = [NSMutableArray array];
    }else{
        [self.assetsDatasource removeAllObjects];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.collection enumerateAssetsWithOptions:0 usingBlock:^(ZJAssets *resultAsset) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(resultAsset){
                    [self.assetsDatasource addObject:resultAsset];
                }else{
                    [self.collectionView reloadData];
                }
            });
        }];
    });
}

@end
