//
//  OrderFoodDetailHorizonScrollCell.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodDetailHorizonScrollCell.h"
#import "OrderFoodDetailHorizonColletionView.h"
@interface OrderFoodDetailHorizonScrollCell()
@property(nonatomic, strong)OrderFoodDetailHorizonColletionView *horizonView;
@end

@implementation OrderFoodDetailHorizonScrollCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

#pragma 添加视图
-(void)addView{
  
    [self addSubview:self.horizonView];
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
}
#pragma getter

-(OrderFoodDetailHorizonColletionView *)horizonView{
    if (!_horizonView) {
        _horizonView =[[OrderFoodDetailHorizonColletionView alloc]init];
    }
    return _horizonView;
}
@end
