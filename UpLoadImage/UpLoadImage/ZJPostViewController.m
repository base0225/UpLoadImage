//
//  ZJPostViewController.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/14.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJPostViewController.h"

@interface ZJPostViewController ()

@property (nonatomic, strong) UIView *topBarView;

@end

@implementation ZJPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.topBarView];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:[[UIApplication sharedApplication] statusBarFrame].size.height];
    [self.topBarView autoSetDimension:ALDimensionHeight toSize:44.0f];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.backgroundColor = [UIColor redColor];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(dismissViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    [cancelButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [cancelButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [cancelButton autoSetDimensionsToSize:CGSizeMake(50, 30)];
    
}

- (void)setUpTopBar{
    
}

- (void)dismissViewController:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
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
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setTitle:@"上传" forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(savImage:) forControlEvents:UIControlEventTouchUpInside];
        [_topBarView addSubview:rightButton];
        
    }
    return _topBarView;
}


@end
