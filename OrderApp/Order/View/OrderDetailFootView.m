//
//  OrderCDetailFootView.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderDetailFootView.h"

static NSString *footIdentifier = @"OrderDFooterView";

@implementation OrderDetailFootView

+ (instancetype)orderFooterViewTableView:(UITableView *)tableView{
    
    OrderDetailFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footIdentifier];
    
    if (!footView) {
        
        
        footView =[[OrderDetailFootView alloc]initWithReuseIdentifier:footIdentifier];
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
    
    [self.contentView addSubview:self.amountLable];
    [self.contentView addSubview:self.markLable];
    [self.contentView addSubview:self.markDetialLable];
    [self.contentView addSubview:self.lineLable];
    [self makeUpContriant];
}

- (void)makeUpContriant {
    
    [_amountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.right.mas_equalTo(-15);
        make.height.equalTo(@18);
    }];
    
    [_markLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@34);
        make.width.mas_equalTo(60);
        make.left.mas_equalTo(15);
        make.height.equalTo(@18);
    }];
    
    [_markDetialLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.markLable);
        make.left.mas_equalTo(self.markLable.mas_right);
        make.right.mas_equalTo(-15);
    }];
    
    [_lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.width.equalTo(self.contentView);
        make.height.equalTo(@0.6);
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

-(UILabel *)markDetialLable
{
    if (!_markDetialLable) {
        _markDetialLable =[[UILabel alloc]init];
        _markDetialLable.font = Demon_14_Font;
        _markDetialLable.textColor = [UIColor blackColor];;
    }
    return _markDetialLable;
}

-(UILabel *)amountLable
{
    if (!_amountLable) {
        _amountLable =[[UILabel alloc]init];
        _amountLable.font = Demon_15_Font;
        _amountLable.textColor = [UIColor blackColor];
        _amountLable.textAlignment = NSTextAlignmentRight;
    }
    return _amountLable;
}

-(UILabel *)markLable
{
    if (!_markLable) {
        _markLable =[[UILabel alloc]init];
        [_markLable setText:@"订单备注"];
        _markLable.font = Demon_14_Font;
        _markLable.textColor = CS_Color_DeepGray;
    }
    return _markLable;
}




@end
