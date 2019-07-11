//
//  OrderFoodDetailMenuCategoryCell.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodDetailMenuCategoryCell.h"

@interface OrderFoodDetailMenuCategoryCell()
@property (nonatomic, strong)UILabel *titleLabel;
@end

@implementation OrderFoodDetailMenuCategoryCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

#pragma 添加视图
-(void)addView{
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.titleLabel];
    [self makeUpContriant];
}
#pragma 约束适配
-(void)makeUpContriant{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
    }];
   
}
-(void)setCategoryModel:(mercGoodsInfoResponseCategoryModel *)categoryModel{
    [self.titleLabel setText:categoryModel.title];
}
#pragma getter
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc]init];
        [_titleLabel setText:@"热销"];
        [_titleLabel setFont:Demon_15_Font];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

@end
