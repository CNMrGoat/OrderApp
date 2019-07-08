//
//  OrderFoodDetailViewController.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodDetailViewController.h"
#import "OrderFoodDetailHeadView.h"
#import "OrderFoodDetailMenuCategoryCell.h"
#import "OrderFoodDetailSubMenuCell.h"
#import "subListCell.h"
#import "OrderFoodDetailHorizonScrollCell.h"
#import "OrderFoodDetailFootChargeView.h"
#import "OrderFoodModel.h"
#import "OrderFoodMerchantInfoVC.h"
#import "OrderFoodMerchantProductInfoVC.h"
@interface OrderFoodDetailViewController ()<UITableViewDelegate,UITableViewDataSource,OrderFoodDetailHeadViewDelegate,OrderFoodDetailFootChargeViewDelegate,OrderFoodDetailHorizonScrollCellDelegate,subListCellDelegate>
@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)OrderFoodDetailHeadView *headView;
@property (nonatomic, strong)OrderFoodDetailFootChargeView *footChargeView;
@end

@implementation OrderFoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self request];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma 添加视图
- (void)addView{
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.footChargeView];
    [self makeUpContraints];
}

#pragma 约束适配
-(void)makeUpContraints{
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(-20);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    [self.footChargeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
}
#pragma tableViewDelegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(indexPath.section ==0){
        NSString *cellId =@"DetailHorizonScrollCellId";
        OrderFoodDetailHorizonScrollCell *subMenuCell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!subMenuCell) {
            subMenuCell =[[OrderFoodDetailHorizonScrollCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        [subMenuCell setLocalDelegate:self];
        [subMenuCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return subMenuCell;
    }else{
        NSString *cellId =@"MainTableViewCellId";
        subListCell *tableViewCell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if(!tableViewCell) {
            tableViewCell =[[subListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        [tableViewCell setLocalDelegate:self];
        [tableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return tableViewCell;
    }
 
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
   
    return footView;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 160;
    }else{
        return 300;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 220;
    }
    return 10;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section ==1) {
        return 100;
    }
    return 10;
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
    }
    return _headView;
}
-(OrderFoodDetailFootChargeView *)footChargeView{
    if (!_footChargeView) {
        _footChargeView =[[OrderFoodDetailFootChargeView alloc]init];
        [_footChargeView setLocalDelegate:self];
    }
    return _footChargeView;
}
//让自身这个手势事件响应优先级高于其它手势事件
//只是在对于比它响应优先级高的手势调用
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


#pragma OrderFoodDetailHeadViewDelegate
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)shareAction{
    NSLog(@"微信分享");
}
-(void)jumpAction{
    OrderFoodMerchantInfoVC *detailVC =[[OrderFoodMerchantInfoVC alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES pushType:NavigationPushCorver];
}
#pragma OrderFoodDetailFootChargeViewDelegate
-(void)todayToBuy{
    NSLog(@"今日送达");
}
-(void)tomorrowToBuy{
    NSLog(@"明日送达");
}

#pragma OrderFoodDetailHorizonScrollCellDelegate
-(void)horizonScrollCountNum:(NSInteger)count andMoney:(NSString *)moneyStr{
    
}

#pragma subListCellDelegate
-(void)leftSelect{
    
}
-(void)rightSelect:(NSInteger)count andMoney:(NSString *)money{
    
}
-(void)rightJumpAction{
    OrderFoodMerchantProductInfoVC *detailVC =[[OrderFoodMerchantProductInfoVC alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES pushType:NavigationPushCorver];
}
-(void)request{
    mercGoodsInfoRequestModel *requestModel =[[mercGoodsInfoRequestModel alloc]init];
    requestModel.mercId =self.mercId;
    [NetworkClient RequestWithParameters:[requestModel keyValues] withUrl:BASE_URLWith(MercGoodsInfoHttp) needToken:NO success:^(id responseObject) {
        
        NSLog(@"%@",responseObject[@"msg"]);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([@"2000" isEqualToString:codeStr]) {
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
