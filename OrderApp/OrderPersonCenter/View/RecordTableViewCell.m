//
//  RecordTableViewCell.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "RecordTableViewCell.h"

@interface RecordTableViewCell()
@property (strong, nonatomic) UILabel *nameLab;/**<公司名称*/
@property (strong, nonatomic) UILabel *miaoshuLab;/**<描述*/
@property (strong, nonatomic) UILabel *timeLabel;/**<时间*/

@end

@implementation RecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpAllChirdView];
    }
    return self;
}

- (void)setUpAllChirdView
{
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.miaoshuLab];
    [self.contentView addSubview:self.timeLabel];

    [self makeViewsConstraints];
}

- (void)makeViewsConstraints
{
    
    //写死数据
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.top.equalTo(@10);
        make.height.equalTo(@18);
        make.width.mas_equalTo(@(SCREEN_WIDTH/2));
    }];
    
    [self.miaoshuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-18);
        make.top.equalTo(@8);
        make.height.equalTo(@18);
        make.left.mas_equalTo(self.nameLab.mas_right);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.miaoshuLab.mas_bottom).offset(8);
        make.left.mas_equalTo(18);
        make.width.mas_equalTo(SCREEN_WIDTH-36);
        make.height.equalTo(@15);
    }];
    
    UILabel *lab = [UILabel new];
    [self.contentView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.mas_equalTo(18);
        make.width.mas_equalTo(SCREEN_WIDTH-36);
        make.height.equalTo(@0.8);
    }];
    lab.backgroundColor = CS_Color_BackGroundGray;
    
   
}

#pragma mark -
#pragma mark getter & setter
- (void)setRechargeModel:(WalletData *)rechargeModel{
    if (_rechargeModel != rechargeModel) {
        _rechargeModel = rechargeModel;
        _nameLab.text = [NSString stringWithFormat:@"%@",_rechargeModel.comName] ;
        _miaoshuLab.text = [NSString stringWithFormat:@"+%@",_rechargeModel.money] ;
        _timeLabel.text = [NSString stringWithFormat:@"%@",_rechargeModel.cTime] ;
        
    }
}

- (void)setConsumeModel:(WalletData *)consumeModel{
    if (_consumeModel != consumeModel) {
        _consumeModel = consumeModel;
        _nameLab.text = [NSString stringWithFormat:@"%@",_consumeModel.comName] ;
        _miaoshuLab.text = [NSString stringWithFormat:@"-%@",_consumeModel.money] ;
        _timeLabel.text = [NSString stringWithFormat:@"%@",_consumeModel.cTime] ;

    }
}


- (UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.font = Demon_16_Font;
        _nameLab.textColor = [UIColor blackColor];
        _nameLab.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLab;
}

- (UILabel *)miaoshuLab
{
    if (!_miaoshuLab) {
        _miaoshuLab = [UILabel new];
        _miaoshuLab.font = Demon_16_Font;
        _miaoshuLab.textColor = [UIColor redColor];
        _miaoshuLab.textAlignment = NSTextAlignmentRight;
        _miaoshuLab.adjustsFontSizeToFitWidth = YES;
    }
    return _miaoshuLab;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = Demon_14_Font;
        _timeLabel.textColor = CS_Color_MidGray;
    }
    return _timeLabel;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
