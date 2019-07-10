//
//  OrderFoodMerchantInfoVC.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/8.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodMerchantInfoVC.h"
#import "OrderFoodDetailHeadView.h"
#import "OrderFoodMerchantImageHorizonScrollCell.h"
@interface OrderFoodMerchantInfoVC ()<OrderFoodDetailHeadViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)OrderFoodDetailHeadView *headView;
@property (nonatomic, strong)UILabel *addressLabel;
@property (nonatomic, strong)UILabel *showAddressLabel;
@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UILabel *showPhoneLabel;
@property (nonatomic, strong)UIButton *choiceBtn;
@end

@implementation OrderFoodMerchantInfoVC

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
    [self.view addSubview:self.mainTableView];
    [self makeUpConstraint];
}
#pragma 约束适配
-(void)makeUpConstraint{
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(-20);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}

#pragma tableViewDelegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderFoodMerchantImageHorizonScrollCell *scrollCell =[tableView dequeueReusableCellWithIdentifier:@"KOrderFoodMerchantImageHorizonScrollCell"];
    if (!scrollCell) {
        scrollCell =[[OrderFoodMerchantImageHorizonScrollCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"KOrderFoodMerchantImageHorizonScrollCell"];
    }
    return scrollCell;
    
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
    [footView addSubview:self.addressLabel];
    [footView addSubview:self.showAddressLabel];
    [footView addSubview:self.phoneLabel];
    [footView addSubview:self.showPhoneLabel];
    [footView addSubview:self.choiceBtn];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(footView).offset(10);
    }];
    [self.showAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.addressLabel.mas_bottom).offset(5);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.showAddressLabel.mas_bottom).offset(10);
    }];
    [self.showPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.phoneLabel.mas_bottom).offset(5);
    }];
    [self.choiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footView);
        make.top.mas_equalTo(self.showPhoneLabel.mas_bottom).offset(60);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    return footView;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{        return 170;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 220;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 300;
}

#pragma getter
-(UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_mainTableView setDelegate:self];
        [_mainTableView setDataSource:self];
    }
    return _mainTableView;
}
-(OrderFoodDetailHeadView *)headView{
    if (!_headView) {
        _headView =[[OrderFoodDetailHeadView alloc]init];
        [_headView setLocalDelegate:self];
        [_headView setMercInfoDic:self.mercInfoDic];
    }
    return _headView;
}

-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel =[[UILabel alloc]init];
        [_addressLabel setText:@"商家地址"];
        [_addressLabel setFont:Demon_15_Font];
    }
    return _addressLabel;
}
-(UILabel *)showAddressLabel{
    if (!_showAddressLabel) {
        _showAddressLabel =[[UILabel alloc]init];
        [_showAddressLabel setText:@"湖南省长沙市岳麓区佑母塘路799号钰龙天下家园二期"];
        [_showAddressLabel setFont:Demon_13_Font];
        [_showAddressLabel setTextColor:CS_Color_MidGray];
    }
    return _showAddressLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel =[[UILabel alloc]init];
        [_phoneLabel setText:@"商家电话"];
        [_phoneLabel setFont:Demon_15_Font];
    }
    return _phoneLabel;
}
-(UILabel *)showPhoneLabel{
    if (!_showPhoneLabel) {
        _showPhoneLabel =[[UILabel alloc]init];
        [_showPhoneLabel setText:@"0731-83298520"];
        [_showPhoneLabel setFont:Demon_13_Font];
        [_showPhoneLabel setTextColor:CS_Color_MidGray];
    }
    return _showPhoneLabel;
}
-(UIButton *)choiceBtn{
    if (!_choiceBtn) {
        _choiceBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_choiceBtn setTitle:@"商家意见" forState:UIControlStateNormal];
        [_choiceBtn setTitleColor:CS_Color_StandRed forState:UIControlStateNormal];
        [_choiceBtn.layer setBorderWidth:1];
        [_choiceBtn.layer setBorderColor:CS_Color_StandRed.CGColor];
        [_choiceBtn.layer setCornerRadius:5];
    }
    return _choiceBtn;
}
#pragma OrderFoodDetailHeadViewDelegate
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)shareAction{
    NSLog(@"微信分享");
}

- (void)jumpAction {
    
}


@end
