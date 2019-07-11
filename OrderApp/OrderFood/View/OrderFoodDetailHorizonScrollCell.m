//
//  OrderFoodDetailHorizonScrollCell.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodDetailHorizonScrollCell.h"
#import "OrderFoodDetailHorizonColletionView.h"
@interface OrderFoodDetailHorizonScrollCell()<OrderFoodDetailHorizonColletionViewDelegate>
@property(nonatomic, strong)OrderFoodDetailHorizonColletionView *horizonView;
@property(nonatomic, strong)UIView *lineView;
@end

@implementation OrderFoodDetailHorizonScrollCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}
-(void)setHotList:(NSArray *)hotList{
    [self.horizonView setHotList:hotList];
}
#pragma 添加视图
-(void)addView{
  
    [self addSubview:self.horizonView];
    [self addSubview:self.lineView];
    [self makeUpConstriant];
}
#pragma 约束适配
-(void)makeUpConstriant{
    [self.horizonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(2);
        make.height.mas_equalTo(1);
    }];
}

#pragma getter

-(OrderFoodDetailHorizonColletionView *)horizonView{
    if (!_horizonView) {
        _horizonView =[[OrderFoodDetailHorizonColletionView alloc]init];
        [_horizonView setLocalDelegate:self];
      
    }
    return _horizonView;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView =[[UIView alloc]init];
        [_lineView setBackgroundColor:UIColorFromHex(0xEEEEEE)];
    }
    return _lineView;
}
-(void)reloadData{
    [self.horizonView reloadData];
}
#pragma OrderFoodDetailHorizonColletionViewDelegate
-(void)colletionViewCountNum:(NSInteger)count andMoney:(NSString *)moneyStr{
    if ([self.localDelegate respondsToSelector:@selector(horizonScrollCountNum:andMoney:)]) {
        [self.localDelegate horizonScrollCountNum:count andMoney:moneyStr];
    }
}
@end
