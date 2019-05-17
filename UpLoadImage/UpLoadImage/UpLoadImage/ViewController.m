//
//  ViewController.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/11.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ViewController.h"
#import "ZJPublicViewController.h"
#if DEBUG
#import "FLEXManager.h"
#endif


@interface ViewController ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if DEBUG
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    button.right = [UIScreen mainScreen].bounds.size.width - 10.0f;
    button.bottom = [UIScreen mainScreen].bounds.size.height - 64.0f - 10.0f;
    [button setBackgroundColor:[UIColor purpleColor]];
    [button addTarget:self action:@selector(debugButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:button];
#endif
    
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickButton setBackgroundColor:[UIColor greenColor]];
    [clickButton setTitle:@"点我呀" forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickButton];
    
    [clickButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [clickButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [clickButton autoSetDimensionsToSize:CGSizeMake(60, 30)];
    
}

- (void)clickButton:(id)sender{
    NSLog(@"点击了button");
    ZJPublicViewController *publicViewController = [[ZJPublicViewController alloc] init];
    publicViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:publicViewController animated:YES completion:^{
    }];
}

#if DEBUG
- (void)debugButtonPressed:(id)sender
{
    [[FLEXManager sharedManager] showExplorer];
}
#endif

@end
