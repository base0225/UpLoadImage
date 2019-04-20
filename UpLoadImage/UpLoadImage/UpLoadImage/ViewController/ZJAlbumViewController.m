//
//  ZJAlbumViewController.m
//  UpLoadImage
//
//  Created by zhujia on 2019/4/20.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJAlbumViewController.h"
#import "ZJPHAssertManger.h"

@interface ZJAlbumViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *tipsLabel;

//data
@property (nonatomic, strong)  NSMutableArray *albumArray;
@end

@implementation ZJAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.topBarView];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:[[UIApplication sharedApplication] statusBarFrame].size.height];
    [self.topBarView autoSetDimension:ALDimensionHeight toSize:44.0f];
    
    [self initpage];
    
    [self checkAuthorization];
}

- (void)initpage{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor grayColor];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topBarView];
    
    [self.view addSubview:self.tipsLabel];
    [self.tipsLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.tipsLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];

}

- (void)checkAuthorization{
    if([ZJPHAssertManger authorizationStatus] == ZJAssetAuthorizationStatusNotDetermined){
        
        NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [dic objectForKey:@"CFBundleDisplayName"];
        if(!appName){
            appName = [dic objectForKey:(NSString *)kCFBundleNameKey];
        }
        NSString *tips = [NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册",appName];
        self.tipsLabel.hidden = NO;
        self.tipsLabel.text = tips;
    }else{
        [ZJPHAssertManger requestAuthorization:^(ZJAssetAuthorizationStatus stauts) {
            if(stauts != ZJAssetAuthorizationStatusNotAuthorized){
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self initDatasource];
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self checkAuthorization];
                });
            }
        }];
    }
}

- (void)initDatasource{
    self.albumArray = [NSMutableArray array];
    
    //加载图片
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    });
}


#pragma mark -- UITableViewDelegate
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return self.albumsArray.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if(indexPath.row % 2 == 0){
        cell.backgroundColor = [UIColor redColor];
    }else{
        cell.backgroundColor = [UIColor greenColor];
    }
    
    return cell;
}

#pragma mark -- UIEvent
- (void)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark -- UI

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
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
        
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.text = @"照片";
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

- (UILabel *)tipsLabel {
    
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.hidden = YES;
        _tipsLabel.font = [UIFont systemFontOfSize:16.0f];
        _tipsLabel.textColor = [UIColor blackColor];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.numberOfLines = 0;
    }
    return _tipsLabel;
}

@end
