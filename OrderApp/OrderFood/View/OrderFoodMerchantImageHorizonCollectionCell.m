//
//  OrderFoodDetailHorizonCollectionCell.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodMerchantImageHorizonCollectionCell.h"
@interface OrderFoodMerchantImageHorizonCollectionCell()
@property(nonatomic, strong)UIImageView  *imgLogo;
@end
@implementation OrderFoodMerchantImageHorizonCollectionCell
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
@end
