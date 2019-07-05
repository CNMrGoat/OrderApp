//
//  OrderCountNumView.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderCountNumView.h"

@interface OrderCountNumView()
@property(nonatomic ,strong)UIButton *subBtn;
@property(nonatomic ,strong)UILabel *showLabel;
@property(nonatomic ,strong)UIButton *addBtn;
@end

@implementation OrderCountNumView

-(id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}
#pragma 添加视图
-(void)addView{
    [self addSubview:self.subBtn];
    [self addSubview:self.addBtn];
    [self addSubview:self.showLabel];
    [self makeUpContraints];
}
#pragma 约束适配
-(void)makeUpContraints{
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.left.mas_equalTo(self.subBtn.mas_right);
        make.right.mas_equalTo(self.addBtn.mas_left);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
}
#pragma getter
-(UIButton *)subBtn{
    if (!_subBtn) {
        _subBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_subBtn setBackgroundImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [_subBtn addTarget:self action:@selector(count:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subBtn;
}
-(UILabel *)showLabel{
    if (!_showLabel) {
        _showLabel =[[UILabel alloc]init];
        [_showLabel setText:@""];
        [_showLabel setFont:Demon_10_Font];
    }
    return _showLabel;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(count:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(void)count:(UIButton *)btn{
    
}
@end
