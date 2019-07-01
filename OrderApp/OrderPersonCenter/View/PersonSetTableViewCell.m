//
//  PersonSetTableViewCell.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "PersonSetTableViewCell.h"

@implementation PersonSetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setDemonSeparatorStyle:DemonTableViewCellSeparatorFull];
        self.textLabel.font = Demon_RegularFont_(15);
        self.textLabel.textColor = UIColorFromHex(0x666666);
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setBackgroundView:[[UIView alloc] init]];
        [self showCellIndicator:YES];
        [self addView];
    }
    return self;
}

#pragma mark -
#pragma mark 添加视图
-(void)addView{
    [self.contentView addSubview:self.lineV];
    [self.contentView addSubview:self.tilLabel];
    [self.contentView addSubview:self.headImgV];
    [self makeUpstraints];
}

#pragma mark -
#pragma mark 添加约束
-(void)makeUpstraints{
    
    
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(SCREEN_WIDTH - 15);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self.contentView);
    }];
    
    
//    [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.width.mas_equalTo(SCREEN_WIDTH - 15);
//        make.height.mas_equalTo(0.5);
//        make.bottom.mas_equalTo(self.contentView);
//    }];
    
    
    [self.tilLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.width.mas_equalTo(SCREEN_WIDTH-100);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

- (UIView *)lineV
{
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = [UIColor colorWithHexString:@"#dedede"];
    }
    return _lineV;
}

- (UILabel *)tilLabel
{
    if (!_tilLabel) {
        _tilLabel = [[UILabel alloc] init];
        _tilLabel.font = Demon_15_Font;
        _tilLabel.textAlignment = NSTextAlignmentRight;
    
   
    }
    return _tilLabel;
}

- (UIImageView *)headImgV
{
    if (!_headImgV) {
        _headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 10, 30, 30)];
        _headImgV.layer.cornerRadius = 15.0f;
        _headImgV.layer.masksToBounds = YES;
    }
    return _headImgV;
}

@end
