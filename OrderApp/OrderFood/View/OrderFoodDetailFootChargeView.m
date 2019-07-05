//
//  OrderFoodDetailFootChargeView.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodDetailFootChargeView.h"
@interface OrderFoodDetailFootChargeView()
@property (nonatomic, strong) UIImageView *buyImg;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIButton *tomorrowToBtn;
@property (nonatomic, strong) UIButton *todayToBtn;
@end
@implementation OrderFoodDetailFootChargeView

-(id)init{
    if(self =[super init]){
        [self addView];
    }
    return self;
}

#pragma 添加视图
-(void)addView{
    [self setBackgroundColor:UIColorFromHex(0x404040)];
    [self addSubview:self.buyImg];
    [self addSubview:self.countLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.todayToBtn];
    [self addSubview:self.tomorrowToBtn];
    [self makeUpConstraints];
}

#pragma 约束适配
-(void)makeUpConstraints{
    [self.buyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.buyImg.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.buyImg.mas_top).offset(10);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countLabel.mas_right);
        make.centerY.mas_equalTo(self);
    }];

    [self.todayToBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.width.mas_equalTo(100);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(self);
    }];
    [self.tomorrowToBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.todayToBtn.mas_left);
        make.width.mas_equalTo(100);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(self);
    }];
}

#pragma getter
-(UIImageView *)buyImg{
    if (!_buyImg) {
        _buyImg =[[UIImageView alloc]init];
        [_buyImg setImage:[UIImage imageNamed:@"购物"]];
    }
    return _buyImg;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel =[[UILabel alloc]init];
        [_countLabel setText:@"2"];
        [_countLabel setTextAlignment:NSTextAlignmentCenter];
        [_countLabel setTextColor:[UIColor whiteColor]];
        [_countLabel.layer setBorderWidth:1];
        [_countLabel.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_countLabel.layer setCornerRadius:8];
        [_countLabel.layer setBackgroundColor:CS_Color_StandRed.CGColor];
        [_countLabel setFont:Demon_10_Font];
    }
    return _countLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel =[[UILabel alloc]init];
        [_moneyLabel setText:@"￥31.5"];
        [_moneyLabel setTextColor:[UIColor whiteColor]];
        [_moneyLabel setFont:Demon_17_Font];
    }
    return _moneyLabel;
}
-(UIButton *)tomorrowToBtn{
    if (!_tomorrowToBtn) {
        _tomorrowToBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_tomorrowToBtn setTitle:@"明天送达" forState:UIControlStateNormal];
        [_tomorrowToBtn setBackgroundColor:UIColorFromHex(0xFBBE3B)];
       
    }
    return _tomorrowToBtn;
}
-(UIButton *)todayToBtn{
    if (!_todayToBtn) {
        _todayToBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_todayToBtn setTitle:@"今天送达" forState:UIControlStateNormal];
         [_todayToBtn setBackgroundColor:UIColorFromHex(0xF55B4F)];
    }
    return _todayToBtn;
}
@end
