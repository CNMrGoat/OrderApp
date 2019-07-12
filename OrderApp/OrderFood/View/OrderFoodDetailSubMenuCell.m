//
//  OrderFoodDetailSubMenuCell.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodDetailSubMenuCell.h"

@interface OrderFoodDetailSubMenuCell()<OrderCountNumViewDelegate>
@property (nonatomic, strong)UIImageView *imageLogo;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *detailLabel;
@property (nonatomic, strong)UILabel *moneyLabel;

@end
@implementation OrderFoodDetailSubMenuCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

#pragma 添加视图
-(void)addView{
    [self.contentView addSubview:self.imageLogo];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.countNumView];
    [self makeUpContriant];
}
#pragma 约束适配
-(void)makeUpContriant{
    [self.imageLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(80);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageLogo.mas_right).offset(10);
        make.top.mas_equalTo(15);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.detailLabel);
        make.top.mas_equalTo(self.detailLabel.mas_bottom).offset(10);
    }];
    [self.countNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-15);
        make.centerY.mas_equalTo(self.moneyLabel);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
}
-(void)setSubListModel:(mercGoodsInfoResponseSubListModel *)subListModel{
    _subListModel =subListModel;
    [self.imageLogo setImageWithURL:[NSURL URLWithString:subListModel.pic] placeholderImage:nil];
    [self.titleLabel setText:subListModel.name];
    [self.detailLabel setText:subListModel.desc];
    [self.moneyLabel setText:[NSString stringWithFormat:@"￥%@",subListModel.marketPrice]];
}
#pragma getter
-(UIImageView *)imageLogo{
    if (!_imageLogo) {
        _imageLogo =[[UIImageView alloc]init];
        [_imageLogo setImage:[UIImage imageNamed:@"菜品2"]];
    }
    return _imageLogo;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc]init];
        [_titleLabel setText:@"香辣豆花"];
        [_titleLabel setFont:Demon_15_Font];
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel =[[UILabel alloc]init];
        [_detailLabel setFont:Demon_12_Font];
        [_detailLabel setNumberOfLines:0];
        [_detailLabel setText:@"香辣多汁，口感鲜美，主要原料：鸡翅，小麦粉"];
        [_detailLabel setTextColor:CS_Color_MidGray];
    }
    return _detailLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel =[[UILabel alloc]init];
        [_moneyLabel setText:@"￥11.5"];
        [_moneyLabel setFont:Demon_12_Font];
        [_moneyLabel setTextColor:CS_Color_MidGray];
    }
    return _moneyLabel;
}
-(OrderCountNumView *)countNumView{
    if (!_countNumView) {
        _countNumView =[[OrderCountNumView alloc]init];
        [_countNumView setLocalDelegate:self];
    }
    return _countNumView;
}

#pragma countNumViewDelegate
-(void)addNum:(NSInteger)num OrderCountNumView:(id)numView{
    if([self.LocalDelegate respondsToSelector:@selector(addNum:andCount:OrderCountNumView:)]){
        [self.LocalDelegate addNum:self.subListModel andCount:num OrderCountNumView:numView];
    }
}
-(void)subNum:(NSInteger)num OrderCountNumView:(id)numView{
    if([self.LocalDelegate respondsToSelector:@selector(subNum:andCount:OrderCountNumView:)]){
        [self.LocalDelegate subNum:self.subListModel andCount:num OrderCountNumView:numView];
    }
}

@end
