//
//  OrderFinishDetailFootView.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/28.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFinishDetailFootView.h"

static NSString *footIdentifier = @"OrderFinishDFooterView";

@implementation OrderFinishDetailFootView

+ (instancetype)orderFooterViewTableView:(UITableView *)tableView{
    
    OrderFinishDetailFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footIdentifier];
    
    if (!footView) {
        
        
        footView =[[OrderFinishDetailFootView alloc]initWithReuseIdentifier:footIdentifier];
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
    [self.contentView addSubview:self.timeLable];
    [self.contentView addSubview:self.confirmTimeLab];
    [self.contentView addSubview:self.finishTimeLab];
    [self makeUpContriant];
}

- (void)makeUpContriant {
    
    [_lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self.contentView);
        make.height.equalTo(@10);
    }];
    
    [_markLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.left.mas_equalTo(15);
        make.height.equalTo(@18);
    }];
    
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.markLable.mas_bottom).offset(8);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.left.mas_equalTo(15);
        make.height.equalTo(@18);
    }];
    
    [_confirmTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLable.mas_bottom).offset(8);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.left.mas_equalTo(15);
        make.height.equalTo(@18);
    }];
    
    [_finishTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmTimeLab.mas_bottom).offset(8);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.left.mas_equalTo(15);
        make.height.equalTo(@18);
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

-(UILabel *)confirmTimeLab
{
    if (!_confirmTimeLab) {
        _confirmTimeLab =[[UILabel alloc]init];
        [_confirmTimeLab setText:@"商家确认时间：2019-39-292-"];
        _confirmTimeLab.font = Demon_14_Font;
        _confirmTimeLab.textColor = CS_Color_MidGray;
    }
    return _confirmTimeLab;
}

-(UILabel *)timeLable
{
    if (!_timeLable) {
        _timeLable =[[UILabel alloc]init];
        [_timeLable setText:@"下单时间：2019-39-292-"];
        _timeLable.font = Demon_14_Font;
        _timeLable.textColor = CS_Color_MidGray;
    }
    return _timeLable;
}

-(UILabel *)markLable
{
    if (!_markLable) {
        _markLable =[[UILabel alloc]init];
        [_markLable setText:@"备注：亲我都去哦我都ID为"];
        _markLable.font = Demon_14_Font;
        _markLable.textColor = [UIColor blackColor];
    }
    return _markLable;
}

-(UILabel *)finishTimeLab
{
    if (!_finishTimeLab) {
        _finishTimeLab =[[UILabel alloc]init];
        [_finishTimeLab setText:@"订单完成时间：2019-39-292-"];
        _finishTimeLab.font = Demon_14_Font;
        _finishTimeLab.textColor = CS_Color_MidGray;
    }
    return _finishTimeLab;
}



-(void)setOrderFinishDFootModel:(OrderFinishDFootModel *)orderFinishDFootModel{
    
    if (orderFinishDFootModel) {
        _orderFinishDFootModel=orderFinishDFootModel;
        
    }
    
    
}

@end
