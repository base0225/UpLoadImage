//
//  ViewController.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/11.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ViewController.h"
#import "PureLayout.h"
#import "UIView+Position.h"
#import "ZJPublicViewController.h"


@interface ViewController ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor greenColor]];
    [button setTitle:@"点我呀" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [button autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [button autoSetDimensionsToSize:CGSizeMake(60, 30)];
    
}

- (void)clickButton:(id)sender{
    NSLog(@"点击了button");
    ZJPublicViewController *publicViewController = [[ZJPublicViewController alloc] init];
    [self.navigationController presentViewController:publicViewController animated:YES completion:^{
        
    }];
}

@end
