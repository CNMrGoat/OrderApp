//
//  OrderFoodDetailHorizonCollectionCell.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodDetailHorizonCollectionCell.h"
#import "OrderCountNumView.h"
@interface OrderFoodDetailHorizonCollectionCell()<OrderCountNumViewDelegate>
@property(nonatomic, strong)UIImageView  *imgLogo;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *moneyLabel;
@property(nonatomic, strong)OrderCountNumView *countView;
@end
@implementation OrderFoodDetailHorizonCollectionCell
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}
#pragma mark -
#pragma mark 添加视图
-(void)addView{
    [self addSubview:self.imgLogo];
    [self addSubview:self.nameLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.countView];
    [self makeUpstraint];
}
#pragma mark -
#pragma mark 约束适配
-(void)makeUpstraint{
    [self.imgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
        make.top.mas_equalTo(self);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgLogo.mas_bottom);
        make.left.mas_equalTo(self.imgLogo.mas_left);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom);
        make.left.mas_equalTo(self.imgLogo.mas_left);
    }];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moneyLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(self.moneyLabel);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
}
#pragma mark -
#pragma mark getter
-(UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo =[[UIImageView alloc]init];
        [_imgLogo setImage:[UIImage imageNamed:@"菜品3"]];
    }
    return _imgLogo;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel =[[UILabel alloc]init];
        [_nameLabel setText:@"招牌虾滑"];
        [_nameLabel setFont:Demon_15_Font];
        [_nameLabel setTextColor:UIColorFromHex(0x666666)];
        [_nameLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel =[[UILabel alloc]init];
        [_moneyLabel setText:@"￥20"];
        [_moneyLabel setFont:Demon_15_Font];
    }
    return _moneyLabel;
}

-(OrderCountNumView *)countView{
    if (!_countView) {
        _countView =[[OrderCountNumView alloc]init];
        [_countView setLocalDelegate:self];
    }
    return _countView;
}

#pragma OrderCountNumViewDelegate
-(void)transferNum:(NSInteger)num{
    if ([self.LocalDelegate respondsToSelector:@selector(collectionCellCountNum:andMoney:)]) {
        [self.LocalDelegate collectionCellCountNum:num andMoney:self.moneyLabel.text];
    }
}
@end
