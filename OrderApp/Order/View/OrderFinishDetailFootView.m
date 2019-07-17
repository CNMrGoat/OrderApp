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
        _confirmTimeLab.font = Demon_14_Font;
        _confirmTimeLab.textColor = CS_Color_MidGray;
    }
    return _confirmTimeLab;
}

-(UILabel *)timeLable
{
    if (!_timeLable) {
        _timeLable =[[UILabel alloc]init];
        _timeLable.font = Demon_14_Font;
        _timeLable.textColor = CS_Color_MidGray;
    }
    return _timeLable;
}

-(UILabel *)markLable
{
    if (!_markLable) {
        _markLable =[[UILabel alloc]init];
        _markLable.font = Demon_14_Font;
        _markLable.textColor = [UIColor blackColor];
    }
    return _markLable;
}

-(UILabel *)finishTimeLab
{
    if (!_finishTimeLab) {
        _finishTimeLab =[[UILabel alloc]init];
        _finishTimeLab.font = Demon_14_Font;
        _finishTimeLab.textColor = CS_Color_MidGray;
    }
    return _finishTimeLab;
}



-(void)setDetailDataModel:(DetailData *)detailDataModel{
    
    if (detailDataModel) {
        _detailDataModel=detailDataModel;
        
        if (detailDataModel.status == 2) {
            self.markLable.text = [NSString stringWithFormat:@"备注：%@",detailDataModel.userDesc];
            self.timeLable.text = [NSString stringWithFormat:@"下单时间：%@",detailDataModel.ctime];
            self.confirmTimeLab.text = [NSString stringWithFormat:@"取消订单：%@",detailDataModel.canelTime];
            self.finishTimeLab.text = [NSString stringWithFormat:@"取消订单备注：%@",detailDataModel.desc];
        } else {
            
            self.markLable.text = [NSString stringWithFormat:@"备注：%@",detailDataModel.userDesc];
            self.timeLable.text = [NSString stringWithFormat:@"下单时间：%@",detailDataModel.ctime];
            self.confirmTimeLab.text = [NSString stringWithFormat:@"商家确认时间：%@",detailDataModel.ctime];
            self.finishTimeLab.text = [NSString stringWithFormat:@"完成时间：%@",detailDataModel.ctime];
            
        }
    }
}

@end
