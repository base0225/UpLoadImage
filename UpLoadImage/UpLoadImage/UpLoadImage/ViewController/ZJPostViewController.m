//
//  ZJPostViewController.m
//  UpLoadImage
//
//  Created by 朱佳 on 2019/4/14.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJPostViewController.h"
#import "ZJDynamicImageCell.h"
#import "ZJDynamicImageAddCell.h"
#import "ZJAlbumViewController.h"
#import <QiniuSDK.h>
#import <QNConfiguration.h>
#import <QN_GTM_Base64.h>
#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#import "QNUrlSafeBase64.h"
#import "ZJAssets.h"

static const CGFloat collectionViewInsetTop = 130;

@interface ZJPostViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *topBarView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, copy) NSString *scope;
@property (nonatomic, copy) NSString *accessKey;
@property (nonatomic, copy) NSString *secretKey;
@property (nonatomic, copy) NSString *uploadToken;

@end

@implementation ZJPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scope = @"beth";
    self.accessKey = @"";
    self.secretKey = @"";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.topBarView];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.topBarView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:[[UIApplication sharedApplication] statusBarFrame].size.height];
    [self.topBarView autoSetDimension:ALDimensionHeight toSize:44.0f];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(collectionViewInsetTop, 10, 0, 10)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateArray:) name:@"zjgridArray" object:nil];
}

- (void)updateArray:(NSNotification*)notification{
    NSDictionary *object = notification.object;
    self.dataSource = object[@"array"];
    NSLog(@"%@",self.dataSource);
    [self.collectionView reloadData];
    
}


#pragma mark -- UI Event

- (void)saveImage:(id)sender{
    
    [self createToken];
    
    [self upLoadImage];
    
    NSLog(@"上传接口");
//    https://developer.qiniu.com/kodo/sdk/1240/objc
    
}


- (void)dismissViewController:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


#pragma mark -- collectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    if(indexPath.row == 0){
        ZJDynamicImageAddCell *addimageCell =  [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ZJDynamicImageAddCell" forIndexPath:indexPath];
        [addimageCell bindmodelwithstr:[NSString stringWithFormat:@"最多添加%ld张",(20 - self.dataSource.count)]];
        cell = addimageCell;
    }else
    {
        ZJDynamicImageCell *imageCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ZJDynamicImageCell" forIndexPath:indexPath];
        ZJAssets *asset = [self.dataSource objectAtIndex:(indexPath.row-1)];
        [imageCell bindMode:asset];
        cell = imageCell;
    }
   return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-60)/3.0f, ([UIScreen mainScreen].bounds.size.width-60)/3.0f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        NSLog(@"添加照片");
        [self addImage];
    }else{
        NSLog(@"展示大图");
    }
}

#pragma mark -- UIEvent
- (void)addImage{
    ZJAlbumViewController *ablumiewController = [[ZJAlbumViewController alloc] init];
    [self presentViewController:ablumiewController animated:YES completion:^{
        
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
        rightButton.translatesAutoresizingMaskIntoConstraints = NO;
        [rightButton setTitle:@"上传" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
        [_topBarView addSubview:rightButton];
        [rightButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.0f];
        [rightButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
    }
    return _topBarView;
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = true;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_collectionView registerClass:NSClassFromString(@"ZJDynamicImageCell") forCellWithReuseIdentifier:@"ZJDynamicImageCell"];
        [_collectionView registerClass:NSClassFromString(@"ZJDynamicImageAddCell") forCellWithReuseIdentifier:@"ZJDynamicImageAddCell"];
    }
    return _collectionView;
}

#pragma mark -- Qiniu
- (void)upLoadImage{
  QNUploadManager *uploadManger = [[QNUploadManager alloc] init];
    [self.dataSource enumerateObjectsUsingBlock:^(ZJAssets *asset, NSUInteger idx, BOOL * _Nonnull stop) {
        [uploadManger putPHAsset:asset.phAsset key:nil token:self.uploadToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            NSLog(@"%@",info);
            NSLog(@"%@",key);

        } option:nil];
    }];
}


//获取token
- (void)createToken {
    if (!self.scope.length || !self.accessKey.length || !self.secretKey.length) {
        return;
    }
    // 将上传策略中的scrop和deadline序列化成json格式
    NSMutableDictionary *authInfo = [NSMutableDictionary dictionary];
    [authInfo setObject:self.scope forKey:@"scope"];
    [authInfo
     setObject:[NSNumber numberWithLong:[[NSDate date] timeIntervalSince1970]]
     forKey:@"deadline"];
    
    NSData *jsonData =
    [NSJSONSerialization dataWithJSONObject:authInfo options:NSJSONWritingPrettyPrinted error:nil];
    
    // 对json序列化后的上传策略进行URL安全的base64编码
    NSString *encodedString = [self urlSafeBase64Encode:jsonData];
    
    // 用secretKey对编码后的上传策略进行HMAC-SHA1加密，并且做安全的base64编码，得到encoded_signed
    NSString *encodedSignedString = [self HMACSHA1:self.secretKey text:encodedString];
    
    // 将accessKey、encodedSignedString和encodedString拼接，中间用：分开，就是上传的token
    NSString *token =
    [NSString stringWithFormat:@"%@:%@:%@", self.accessKey, encodedSignedString, encodedString];
    
    self.uploadToken = token;
    
}

- (NSString *)HMACSHA1:(NSString *)key text:(NSString *)text {
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];

    char cHMAC[CC_SHA1_DIGEST_LENGTH];

    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);

    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash = [self urlSafeBase64Encode:HMAC];
    return hash;
}

- (NSString *)urlSafeBase64Encode:(NSData *)text {
    NSString *base64 =
    [[NSString alloc] initWithData:[QN_GTM_Base64 encodeData:text] encoding:NSUTF8StringEncoding];
    base64 = [base64 stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    base64 = [base64 stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return base64;
}


@end
