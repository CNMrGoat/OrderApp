//
//  RecordTableViewCell.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "RecordTableViewCell.h"

@interface RecordTableViewCell()

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
    [self.contentView addSubview:self.miaoshuLab];
    [self.contentView addSubview:self.timeLabel];

    [self makeViewsConstraints];
}

- (void)makeViewsConstraints
{
    
    //写死数据
    [self.miaoshuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@8);
        make.height.equalTo(@18);
        make.width.mas_equalTo(@(SCREEN_WIDTH/2-15));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(self.miaoshuLab);
        make.left.mas_equalTo(self.miaoshuLab.mas_right);
    }];
    
   
}

#pragma mark -
#pragma mark getter & setter
- (void)setRechargeModel:(WalletData *)rechargeModel{
    if (_rechargeModel != rechargeModel) {
        _rechargeModel = rechargeModel;
        
        _miaoshuLab.text = [NSString stringWithFormat:@"+充值金额 %@",_rechargeModel.money] ;
        _timeLabel.text = [NSString stringWithFormat:@"%@",_rechargeModel.cTime] ;
        
    }
}

- (void)setConsumeModel:(WalletData *)consumeModel{
    if (_consumeModel != consumeModel) {
        _consumeModel = consumeModel;
        
        _miaoshuLab.text = [NSString stringWithFormat:@"-消费金额 %@",_consumeModel.money] ;
        _timeLabel.text = [NSString stringWithFormat:@"%@",_consumeModel.cTime] ;

    }
}



- (UILabel *)miaoshuLab
{
    if (!_miaoshuLab) {
        _miaoshuLab = [UILabel new];
        _miaoshuLab.font = Demon_14_Font;
        _miaoshuLab.textColor = [UIColor blackColor];
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
        _timeLabel.textAlignment = NSTextAlignmentRight;
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
