//
//  subListCell.m
//
//
//  Created by on 2019/6/26.
//  Copyright © 2019年 . All rights reserved.
//

#import "subListCell.h"
#import "OrderFoodDetailMenuCategoryCell.h"
#import "OrderFoodDetailSubMenuCell.h"
@interface subListCell()<UITableViewDataSource,UITableViewDelegate,OrderFoodDetailSubMenuCellDelegate>
@property(nonatomic, strong)UITableView *leftTableView;
@property(nonatomic, strong)UITableView *rightTableView;
@property(nonatomic, assign)NSInteger count;
@end

@implementation subListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
#pragma 添加视图
-(void)initUI{
    [self addSubview:self.leftTableView];
    [self addSubview:self.rightTableView];
    [self makeUpContraints];
}
#pragma 约束适配
-(void)makeUpContraints{
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftTableView.mas_right);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}
#pragma tableViewDelegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView ==self.leftTableView) {
        return 50;
    }else{
        return 100;
    }
  
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==self.leftTableView) {
        NSString *cellId =@"DetailMenuCategoryCellId";
        OrderFoodDetailMenuCategoryCell *categoryCell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!categoryCell) {
            categoryCell =[[OrderFoodDetailMenuCategoryCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        [categoryCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return categoryCell;
    }else {
        NSString *cellId =@"DetailsubMenyCellId";
        OrderFoodDetailSubMenuCell *subMenuCell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!subMenuCell) {
            subMenuCell =[[OrderFoodDetailSubMenuCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        [subMenuCell setLocalDelegate:self];
        [subMenuCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return subMenuCell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==self.leftTableView) {
        return 50;
    }else{
        return 100;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView ==self.leftTableView){
        if ([self.LocalDelegate respondsToSelector:@selector(leftSelect)]) {
            [self.LocalDelegate leftSelect];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma getter
-(UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_leftTableView setDelegate:self];
        [_leftTableView setDataSource:self];
    }
    return _leftTableView;
}
-(UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_rightTableView setDelegate:self];
        [_rightTableView setDataSource:self];
    }
    return _rightTableView;
}
#pragma OrderFoodDetailSubMenuCellDelegate
-(void)countNum:(NSInteger)count andMoney:(nonnull NSString *)moneyStr{
    self.count =count;
    if ([self.LocalDelegate respondsToSelector:@selector(rightSelect:andMoney:)]) {
        [self.LocalDelegate rightSelect:count andMoney:moneyStr];
    }
}
@end
