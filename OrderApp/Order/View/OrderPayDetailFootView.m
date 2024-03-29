//
//  OrderPayDetailFootView.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/28.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderPayDetailFootView.h"

static NSString *footIdentifier = @"OrderPayDFooterView";

@implementation OrderPayDetailFootView

+ (instancetype)orderFooterViewTableView:(UITableView *)tableView{
    
    OrderPayDetailFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footIdentifier];
    
    if (!footView) {
        
        
        footView =[[OrderPayDetailFootView alloc]initWithReuseIdentifier:footIdentifier];
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
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.codeImgView];
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
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLable.mas_bottom).offset(8);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.left.mas_equalTo(15);
        make.height.equalTo(@18);
    }];
    

    
    [_codeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLable).offset(25);
        make.centerX.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(100);
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

-(UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable =[[UILabel alloc]init];
        [_titleLable setText:@"取餐二维码"];
        _titleLable.font = Demon_16_MediumFont;
        _titleLable.textColor = [UIColor blackColor];;
    }
    return _titleLable;
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

- (UIImageView *)codeImgView
{
    if (!_codeImgView) {
        _codeImgView = [UIImageView new];
        _codeImgView.image = [UIImage imageNamed:@"加餐啦LOGO"];
    }
    return _codeImgView;
}



-(void)setOrderPayDFootModel:(OrderPayDFootModel *)orderPayDFootModel{
    
    if (orderPayDFootModel) {
        _orderPayDFootModel=orderPayDFootModel;
        
    }
    
    
}

@end
