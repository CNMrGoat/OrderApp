//
//  OrderFoodMerchantProductInfoVC.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/8.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodMerchantProductInfoVC.h"
#import "OrderFoodProductInfoHeadView.h"
#import "OrderCountNumView.h"
@interface OrderFoodMerchantProductInfoVC ()<UITableViewDelegate,UITableViewDataSource,OrderFoodProductInfoHeadViewDelegate>
@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, strong)OrderFoodProductInfoHeadView *headView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *moneyLabel;
@property (nonatomic, strong)UILabel *sourceLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UILabel *buyNumLabel;
@property (nonatomic, strong)OrderCountNumView *numView;
@property (nonatomic, strong)UIButton *confirmBtn;
@end

@implementation OrderFoodMerchantProductInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma 添加视图
-(void)addView{
    
    if (@available(iOS 11.0, *)) {
        self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        // Fallback on earlier versions
    }
    
    [self.view addSubview:self.myTableView];
    [self makeUpContraints];
}
#pragma 约束适配
-(void)makeUpContraints{
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}
-(void)setSubListModel:(mercGoodsInfoResponseSubListModel *)subListModel{
    [self.nameLabel setText:subListModel.name];
    [self.moneyLabel setText:[NSString stringWithFormat:@"￥%@",subListModel.price]];
    [self.sourceLabel setText:[NSString stringWithFormat:@"￥%@",subListModel.marketPrice]];
    [self.contentLabel setText:subListModel.desc];
    [self.headView setSubListModel:subListModel];
}
#pragma getter
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
        _myTableView.scrollEnabled = NO;
    }
    return _myTableView;
}
-(OrderFoodProductInfoHeadView *)headView{
    if (!_headView) {
        _headView =[[OrderFoodProductInfoHeadView alloc]init];
        [_headView setLocalDelegate:self];
    }
    return _headView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel =[[UILabel alloc]init];
        [_nameLabel setText:@"卷堡双人餐ST"];
        [_nameLabel setFont:Demon_17_Font];
    }
    return _nameLabel;
}
-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel =[[UILabel alloc]init];
        [_moneyLabel setText:@"￥76"];
        [_moneyLabel setFont:Demon_15_Font];
        [_moneyLabel setTextColor:CS_Color_StandRed];
    }
    return _moneyLabel;
}
-(UILabel *)sourceLabel{
    if (!_sourceLabel) {
        _sourceLabel =[[UILabel alloc]init];
        [_sourceLabel setText:@"￥96"];
        [_sourceLabel setFont:Demon_13_Font];
    }
    return _sourceLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel =[[UILabel alloc]init];
        [_contentLabel setNumberOfLines:0];
        [_contentLabel setText:@"升级版香辣鸡腿堡1个+老北京鸡肉卷1个+香辣鸡翅2块+新奥尔良烤翅两块+土豆泥一份+红豆派1块+9珍两杯"];
        [_contentLabel setFont:Demon_15_Font];
    }
    return _contentLabel;
}
-(UILabel *)buyNumLabel{
    if (!_buyNumLabel) {
        _buyNumLabel =[[UILabel alloc]init];
        [_buyNumLabel setText:@"购买数量"];
        [_buyNumLabel setFont:Demon_17_Font];
    }
    return _buyNumLabel;
}
-(OrderCountNumView *)numView{
    if (!_numView) {
        _numView =[[OrderCountNumView alloc]init];
    }
    return _numView;
}
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:CS_Color_StandRed];
        [_confirmBtn.titleLabel setFont:Demon_15_Font];
        [_confirmBtn.layer setCornerRadius:5];
    }
    return _confirmBtn;
}
#pragma tableViewDelegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView =[[UIView alloc]init];
    if (section ==0) {
        [headView addSubview:self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headView);
            make.right.mas_equalTo(headView);
            make.bottom.mas_equalTo(headView);
            make.top.mas_equalTo(headView);
        }];
    }
    return headView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView =[[UIView alloc]init];
    [footView addSubview:self.nameLabel];
    [footView addSubview:self.moneyLabel];
    [footView addSubview:self.sourceLabel];
    [footView addSubview:self.contentLabel];
    [footView addSubview:self.buyNumLabel];
    [footView addSubview:self.numView];
    [footView addSubview:self.confirmBtn];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(footView).offset(10);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
    }];
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moneyLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(self.moneyLabel);
    }];
    UIView *lineView =[[UIView alloc]init];
    [self.sourceLabel addSubview:lineView];
    [lineView setBackgroundColor:CS_Color_MidGray];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.sourceLabel);
        make.left.mas_equalTo(self.sourceLabel).offset(-2);
        make.right.mas_equalTo(self.sourceLabel).offset(2);
        make.height.mas_equalTo(1);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.moneyLabel.mas_bottom).offset(10);
    }];
    [self.buyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(25);
    }];
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.buyNumLabel);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(-15);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.numView.mas_bottom).offset(100);
    }];
    return footView;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 300;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 400;
}


#pragma OrderFoodProductInfoHeadViewDelegate
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)shareAction{
    NSLog(@"微信分享");
}
@end
