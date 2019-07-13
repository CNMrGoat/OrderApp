//
//  OrderFoodDetailHorizonCollectionCell.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodDetailHorizonCollectionCell.h"

@interface OrderFoodDetailHorizonCollectionCell()<OrderCountNumViewDelegate>
@property(nonatomic, strong)UIImageView  *imgLogo;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *moneyLabel;

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
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(120);
        make.top.mas_equalTo(self);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgLogo.mas_bottom);
        make.left.mas_equalTo(self.imgLogo.mas_left);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom);
        make.left.mas_equalTo(self.imgLogo.mas_left);
        make.right.mas_equalTo(self.countView.mas_left);
    }];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.imgLogo.mas_right);
        make.centerY.mas_equalTo(self.moneyLabel);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
}
-(void)setSubListModel:(mercGoodsInfoResponseSubListModel *)subListModel{
    _subListModel =subListModel;
    [self.imgLogo setImageWithURL:[NSURL URLWithString:subListModel.pic] placeholderImage:nil];
    [self.nameLabel setText:subListModel.name];
    [self.moneyLabel setText:[NSString stringWithFormat:@"￥%@",subListModel.price]];
    [self.countView setNum:subListModel.goodsNum.integerValue];
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
        [_nameLabel setFont:Demon_13_Font];
        [_nameLabel setTextColor:UIColorFromHex(0x666666)];
        [_nameLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel =[[UILabel alloc]init];
        [_moneyLabel setText:@"￥20"];
        [_moneyLabel setFont:Demon_13_Font];
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
-(void)addNum{
    if ([self.LocalDelegate respondsToSelector:@selector(collectionCellAddNum:)]) {
        [self.LocalDelegate collectionCellAddNum:self.subListModel];
    }
}
-(void)subNum{
    if ([self.LocalDelegate respondsToSelector:@selector(collectionCellSubNum:)]) {
        [self.LocalDelegate collectionCellSubNum:self.subListModel];
    }
}

@end
