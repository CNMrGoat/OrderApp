//
//  OrderFoodCell.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodCell.h"

@interface OrderFoodCell()
@property (nonatomic, strong)UIImageView *imageLogo;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UIView *lineView;
@end
@implementation OrderFoodCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

#pragma 添加视图
-(void)addView{
    [self.contentView addSubview:self.imageLogo];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.lineView];
    [self makeUpContriant];
}
#pragma 约束适配
-(void)makeUpContriant{
    [self.imageLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(80);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageLogo.mas_right).offset(10);
        make.top.mas_equalTo(15);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLabel);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(5);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}
-(void)setListModel:(orderMercListResponseModel *)listModel{
    [self.imageLogo sd_setImageWithURL:[NSURL URLWithString:listModel.logo] placeholderImage:nil];
    [self.titleLabel setText:listModel.name];
    [self.timeLabel setText:[NSString stringWithFormat:@"点餐时间：%@-%@",listModel.startTime,listModel.endTime]];
    [self.phoneLabel setText:[NSString stringWithFormat:@"联系电话：%@",listModel.mobile]];
}
#pragma getter
-(UIImageView *)imageLogo{
    if (!_imageLogo) {
        _imageLogo =[[UIImageView alloc]init];
        [_imageLogo setImage:[UIImage imageNamed:@"商家1"]];
    }
    return _imageLogo;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc]init];
        [_titleLabel setText:@"饭戒"];
        [_titleLabel setFont:Demon_15_Font];
    }
    return _titleLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel =[[UILabel alloc]init];
        [_timeLabel setFont:Demon_13_Font];
        [_timeLabel setText:@"点餐时间：11：00-12：00"];
    }
    return _timeLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel =[[UILabel alloc]init];
        [_phoneLabel setText:@"0327-89990888"];
        [_phoneLabel setFont:Demon_13_Font];
        [_phoneLabel setTextColor:CS_Color_MidGray];
    }
    return _phoneLabel;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView =[[UIView alloc]init];
        [_lineView setBackgroundColor:UIColorFromHex(0xEEEEEE)];
    }
    return _lineView;
}
@end
