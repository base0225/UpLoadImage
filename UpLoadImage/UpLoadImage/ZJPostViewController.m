//
//  ZJPostViewController.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/14.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJPostViewController.h"

@interface ZJPostViewController ()

@end

@implementation ZJPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.backgroundColor = [UIColor redColor];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(dismissViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    [cancelButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [cancelButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [cancelButton autoSetDimensionsToSize:CGSizeMake(50, 30)];
    
}

- (void)dismissViewController:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
