//
//  OrderCDetailHeadView.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderDetailHeadView.h"



@interface OrderDetailHeadView ()



@end

@implementation OrderDetailHeadView



-(id)init{
    if (self =[super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubviews];
    }
    return self;
}



-(void)addSubviews{
    
    [self addSubview:self.addressLab];
    [self addSubview:self.nameLab];
    [self addSubview:self.titleLab];
    [self addSubview:self.timeLab];
//    [self addSubview:self.lineLab];
//    [self addSubview:self.orderNameLab];
    [self makeUpContriant];
}

- (void)makeUpContriant {
    
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.height.equalTo(@20);
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.addressLab);
        make.top.equalTo(self.addressLab.mas_bottom).offset(8);
        make.height.mas_equalTo(15);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.top.equalTo(self.nameLab.mas_bottom).offset(8);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.mas_right);
        make.top.height.equalTo(self.titleLab);
        make.right.mas_equalTo(-15);
    }];
    
//    [_lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.width.equalTo(self);
//        make.top.equalTo(self.titleLab.mas_bottom).offset(8);
//        make.height.mas_equalTo(10);
//    }];
//
//    [_orderNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.width.equalTo(self.addressLab);
//        make.top.equalTo(self.lineLab.mas_bottom).offset(8);
//        make.height.mas_equalTo(18);
//    }];
    
    
    
}

-(UILabel *)addressLab
{
    if (!_addressLab) {
        _addressLab =[[UILabel alloc]init];
        _addressLab.font = Demon_16_MediumFont;
        _addressLab.textColor = [UIColor blackColor];
    }
    return _addressLab;
}

-(UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab =[[UILabel alloc]init];
        _nameLab.font = Demon_14_Font;
        _nameLab.textColor = CS_Color_MidGray;
    }
    return _nameLab;
}


-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab =[[UILabel alloc]init];
        [_titleLab setText:@"送达时间"];
        _titleLab.font = Demon_14_Font;
        _titleLab.textColor =  CS_Color_MidGray;
    }
    return _titleLab;
}

-(UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab =[[UILabel alloc]init];
        [_timeLab setText:@"----"];
        _timeLab.font = Demon_14_Font;
        _timeLab.textColor = [UIColor blackColor];
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}

-(UILabel *)lineLab
{
    if (!_lineLab) {
        _lineLab =[[UILabel alloc]init];
        _lineLab.backgroundColor = CS_Color_BackGroundGray;
    }
    return _lineLab;
}

-(UILabel *)orderNameLab
{
    if (!_orderNameLab) {
        _orderNameLab =[[UILabel alloc]init];
        _orderNameLab.font = Demon_15_MediumFont;
        _orderNameLab.textColor = [UIColor blackColor];
    }
    return _orderNameLab;
}



@end
