//
//  ZJAssetBrowserViewController.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/29.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJAssetBrowserViewController.h"

@interface ZJAssetBrowserViewController ()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIView *topBarView;

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
