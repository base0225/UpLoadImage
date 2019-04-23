//
//  ZJAlbumTableViewCell.m
//  UpLoadImage
//
//  Created by zhujia on 2019/4/23.
//  Copyright © 2019 朱佳. All rights reserved.
//

#import "ZJAlbumTableViewCell.h"

@interface ZJAlbumTableViewCell ()

@property (nonatomic, strong) UILabel *titlelabel;

@end

@implementation ZJAlbumTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self constructView];
    }
    return self;
}

- (void)constructView{
    self.titlelabel = [[UILabel alloc] init];
    self.titlelabel.textColor = [UIColor blackColor];
    self.titlelabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titlelabel];
    
    [self.titlelabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.0f];
    [self.titlelabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
}

- (void)bindmodel:(NSString *)text{
    self.titlelabel.text = text;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
