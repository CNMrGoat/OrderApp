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
@property (nonatomic, strong) UIButton *showBtn;
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
    [self addSubview:self.showBtn];
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
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(self);
    }];
    [self.tomorrowToBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.todayToBtn.mas_left);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(self);
    }];
    
    
    [self.showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.tomorrowToBtn.mas_left);
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(self);
    }];
}
-(void)setCount:(NSInteger)count andMoney:(NSString *)money{
    if(count>0){
         [self.countLabel setHidden:NO];
         [self.countLabel setText:[NSString stringWithFormat:@"%zd",count]];
    }else{
         [self.countLabel setHidden:YES];
    }
  
    [self.moneyLabel setText:[NSString stringWithFormat:@"￥%@",money]];
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
        [_countLabel setText:@"0"];
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
        _tomorrowToBtn.titleLabel.font = Demon_15_Font;
        [_tomorrowToBtn bk_addEventHandler:^(id sender) {
            if ([self.localDelegate respondsToSelector:@selector(tomorrowToBuy)]) {
                [self.localDelegate tomorrowToBuy];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _tomorrowToBtn;
}
-(UIButton *)todayToBtn{
    if (!_todayToBtn) {
        _todayToBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_todayToBtn setTitle:@"今天送达" forState:UIControlStateNormal];
        [_todayToBtn setBackgroundColor:UIColorFromHex(0xF55B4F)];
        _todayToBtn.titleLabel.font = Demon_15_Font;
        [_todayToBtn bk_addEventHandler:^(id sender) {
            if ([self.localDelegate respondsToSelector:@selector(todayToBuy)]) {
                [self.localDelegate todayToBuy];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _todayToBtn;
}

-(UIButton *)showBtn{
    if (!_showBtn) {
        _showBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_showBtn setBackgroundColor:[UIColor clearColor]];
        [_showBtn bk_addEventHandler:^(id sender) {
            if ([self.localDelegate respondsToSelector:@selector(showSelectedList)]) {
                [self.localDelegate showSelectedList];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn;
}


@end
