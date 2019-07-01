//
//  OrderCDetailHeadView.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderDetailHeadView.h"

static NSString *headIdentifier = @"OrderDHeaderView";

@interface OrderDetailHeadView ()

@property(strong,nonatomic)UILabel *addressLab;
@property(strong,nonatomic)UILabel *nameLab;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *timeLab;
@property(strong,nonatomic)UILabel *lineLab;
@property(strong,nonatomic)UILabel *orderNameLab;

@end

@implementation OrderDetailHeadView

+ (instancetype)orderHeaderViewTableView:(UITableView *)tableView{
    
    OrderDetailHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headIdentifier];
    
    if (!headView) {
        
        
        headView =[[OrderDetailHeadView alloc]initWithReuseIdentifier:headIdentifier];
        [headView.contentView setBackgroundColor:[UIColor whiteColor]];
        
        UIView *whiteView=[[UIView alloc]init];
        [whiteView  setBackgroundColor:[UIColor whiteColor]];
        [headView setBackgroundView:whiteView];
        
        [headView addSubviews];
    }
    
    return headView;
}


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    return self;
}



-(void)addSubviews{
    
    [self.contentView addSubview:self.addressLab];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.timeLab];
    [self.contentView addSubview:self.lineLab];
    [self.contentView addSubview:self.orderNameLab];
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
    
    [_lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.contentView);
        make.top.equalTo(self.titleLab.mas_bottom).offset(8);
        make.height.mas_equalTo(10);
    }];
    
    [_orderNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.addressLab);
        make.top.equalTo(self.lineLab.mas_bottom).offset(8);
        make.height.mas_equalTo(18);
    }];
    
    
    
}

-(UILabel *)addressLab
{
    if (!_addressLab) {
        _addressLab =[[UILabel alloc]init];
        [_addressLab setText:@"地址：湖南是看巴萨开酒吧上课吧"];
        _addressLab.font = Demon_16_MediumFont;
        _addressLab.textColor = [UIColor blackColor];
    }
    return _addressLab;
}

-(UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab =[[UILabel alloc]init];
        [_nameLab setText:@"收货人：吴先生"];
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
        [_timeLab setText:@"明天中午12点"];
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
        [_orderNameLab setText:@"肯德基宅技术（啊是看不见卡社保卡下）"];
        _orderNameLab.font = Demon_15_MediumFont;
        _orderNameLab.textColor = [UIColor blackColor];
    }
    return _orderNameLab;
}




-(void)setOrderDHeadModel:(OrderDHeadModel *)orderDHeadModel{
    
    if (orderDHeadModel) {
        _orderDHeadModel=orderDHeadModel;
    
    }
}

@end
