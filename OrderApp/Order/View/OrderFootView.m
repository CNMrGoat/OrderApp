//
//  OrderCarFootView.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFootView.h"

static NSString *footIdentifier = @"OrderFooterView";

@implementation OrderFootView

+ (instancetype)orderFooterViewTableView:(UITableView *)tableView{
    
    OrderFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footIdentifier];
    
    if (!footView) {
        
        
        footView =[[OrderFootView alloc]initWithReuseIdentifier:footIdentifier];
        [footView.contentView setBackgroundColor:[UIColor whiteColor]];
        
        UIView *whiteView=[[UIView alloc]init];
        [whiteView  setBackgroundColor:[UIColor whiteColor]];
        [footView setBackgroundView:whiteView];
        
        [footView addSubviews];
    }
    
    return footView;
}


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    return self;
}



-(void)addSubviews{
    
    [self.contentView addSubview:self.lineLable];
    [self.contentView addSubview:self.markLable];
    [self.contentView addSubview:self.amountLable];
    [self.contentView addSubview:self.totalBtn];
    [self.contentView addSubview:self.line2Lable];
    [self makeUpContriant];
}

- (void)makeUpContriant {
    
    [_lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self.contentView);
        make.height.equalTo(@0.6);
    }];
    
    [_markLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.width.mas_equalTo(50);
        make.left.mas_equalTo(SCREEN_WIDTH/2-50);
        make.height.equalTo(@18);
    }];
    
    [_amountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.equalTo(self.markLable);
        make.width.mas_equalTo(SCREEN_WIDTH/2-80);
        make.left.equalTo(self.markLable.mas_right);
    }];
    
    [_totalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@8);
        make.height.equalTo(@26);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.mas_equalTo(65);
    }];
    
    [_line2Lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.width.equalTo(self.contentView);
        make.height.equalTo(@10);
    }];
    
    
    
}


-(UILabel *)lineLable
{
    if (!_lineLable) {
        _lineLable =[[UILabel alloc]init];
        _lineLable.backgroundColor = CS_Color_LightGray;
    }
    return _lineLable;
}

-(UILabel *)line2Lable
{
    if (!_line2Lable) {
        _line2Lable =[[UILabel alloc]init];
        _line2Lable.backgroundColor = CS_Color_BackGroundGray;
    }
    return _line2Lable;
}

-(UILabel *)markLable
{
    if (!_markLable) {
        _markLable =[[UILabel alloc]init];
        [_markLable setText:@"合计"];
        _markLable.font = Demon_15_MediumFont;
        _markLable.textColor = [UIColor blackColor];
    }
    return _markLable;
}

-(UILabel *)amountLable
{
    if (!_amountLable) {
        _amountLable =[[UILabel alloc]init];
        [_amountLable setText:@"333333"];
        _amountLable.font = Demon_15_MediumFont;
        _amountLable.textColor = CS_Color_BackZhuti;
    }
    return _amountLable;
}

-(UIButton *)totalBtn
{
    if (!_totalBtn) {
        _totalBtn =[[UIButton alloc]init];
        [_totalBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [_totalBtn setTitleColor:CS_Color_BackZhuti forState:UIControlStateNormal];
        _totalBtn.titleLabel.font = Demon_15_Font;
        [_totalBtn border:CS_Color_BackZhuti width:1 CornerRadius:3];
        
    }
    return _totalBtn;
}


-(void)setOrderFootModel:(OrderFootModel *)orderFootModel{
    
    if (orderFootModel) {
        _orderFootModel=orderFootModel;
        
        [self.amountLable setText:orderFootModel.amount];
    }
    
    
}

@end
