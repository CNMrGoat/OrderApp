//
//  OrderCarHeadView.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderHeadView.h"

struct DelegateFlags{
    unsigned int headAction : 1;
    
};

@interface OrderHeadView()
@property(nonatomic,assign)struct DelegateFlags delegateFlags;


@end

static NSString *headIdentifier = @"OrderHeaderView";

@implementation OrderHeadView

+ (instancetype)orderHeaderViewTableView:(UITableView *)tableView{
    
    OrderHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headIdentifier];
    
    if (!headView) {
        
        
        headView =[[OrderHeadView alloc]initWithReuseIdentifier:headIdentifier];
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
    
    [self.contentView addSubview:self.orderNumLab];
    [self.contentView addSubview:self.orderStateLab];
    [self.contentView addSubview:self.orderTimeLab];
    [self.contentView addSubview:self.marketNameLable];
    [self.contentView addSubview:self.deleteBtn];
    [self makeUpContriant];
    [self addAction];
}

- (void)makeUpContriant {
    
    [_orderNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@12);
        make.width.mas_equalTo(SCREEN_WIDTH-30-70);
        make.height.equalTo(@18);
    }];
    
    [_orderStateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.orderNumLab);
        make.width.mas_equalTo(70);
        make.right.mas_equalTo(-15);
    }];
    
    [_orderTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.equalTo(self.orderNumLab);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.top.equalTo(self.orderNumLab.mas_bottom).offset(8);
    }];
    
    [_marketNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.mas_equalTo(self.orderTimeLab.mas_bottom).offset(8);
        make.width.mas_equalTo(SCREEN_WIDTH-30-50);
        make.height.equalTo(@20);
    }];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.equalTo(self.marketNameLable);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.width.mas_equalTo(46);
    }];
    
}

-(UILabel *)orderNumLab
{
    if (!_orderNumLab) {
        _orderNumLab =[[UILabel alloc]init];
        [_orderNumLab setText:@"单号：734523863874624"];
        _orderNumLab.font = Demon_14_Font;
        _orderNumLab.textColor = [UIColor blackColor];
    }
    return _orderNumLab;
}

-(UILabel *)orderStateLab
{
    if (!_orderStateLab) {
        _orderStateLab =[[UILabel alloc]init];
        [_orderStateLab setText:@"已支付"];
        _orderStateLab.font = Demon_14_MediumFont;
        _orderStateLab.textColor =CS_Color_BackZhuti;
        _orderStateLab.textAlignment = NSTextAlignmentRight;
    }
    return _orderStateLab;
}


-(UILabel *)orderTimeLab
{
    if (!_orderTimeLab) {
        _orderTimeLab =[[UILabel alloc]init];
        [_orderTimeLab setText:@"下单时间：2019-39-292-"];
        _orderTimeLab.font = Demon_13_Font;
        _orderTimeLab.textColor = CS_Color_MidGray;
    }
    return _orderTimeLab;
}

-(UILabel *)marketNameLable
{
    if (!_marketNameLable) {
        _marketNameLable =[[UILabel alloc]init];
        [_marketNameLable setText:@"18573jckabjkcbasjkcbajkcbjk3333"];
        _marketNameLable.font = Demon_15_MediumFont;
        _marketNameLable.textColor = [UIColor blackColor];
        _marketNameLable.userInteractionEnabled = YES;
    }
    return _marketNameLable;
}

-(UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn =[[UIButton alloc]init];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _deleteBtn.backgroundColor = [UIColor whiteColor];
        _deleteBtn.titleLabel.font = Demon_14_Font;
        [_deleteBtn border:CS_Color_MidGray width:1 CornerRadius:2];

    }
    return _deleteBtn;
}


-(void)setOrderHeadModel:(OrderHeadModel *)orderHeadModel{
    
    if (orderHeadModel) {
        _orderHeadModel=orderHeadModel;
        
        [self.marketNameLable setText:orderHeadModel.marketName];
    }
    
}


- (void)addAction {
    
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewAction:)];
    [self.marketNameLable addGestureRecognizer:headTap];
}

- (void)headViewAction:(UITapGestureRecognizer *)tap {
    if (_delegateFlags.headAction)  {
        [self.delegate headViewAddressActionWithTag:self.tag];
    }
}

#pragma makr -
#pragma mark -- setter
///TODO:如果有新加的delegate方法,请添加到这个set方法里面,缓存了委托对象能否响应协议的某个方法，以此提升方法执行效率
- (void)setDelegate:(id<OrderHeadViewDelegate>)delegate
{
    _delegate = delegate;
    if ([delegate conformsToProtocol:@protocol(OrderHeadViewDelegate)]) {
        _delegateFlags.headAction = [delegate respondsToSelector:@selector(headViewAddressActionWithTag:)];
    } else {
        
        _delegateFlags.headAction = NO;
    }
}
@end
