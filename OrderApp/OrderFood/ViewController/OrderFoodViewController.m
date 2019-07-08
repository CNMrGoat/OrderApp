//
//  OrderFoodViewController.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodViewController.h"
#import "OrderFoodCell.h"
#import "OrderFoodDetailViewController.h"
#import "OrderFoodModel.h"

@interface OrderFoodViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong) UITableView *myTableView;
@property (nonatomic ,copy) NSString *mercId;
@end

@implementation OrderFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self request];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma 添加视图
- (void)addView{
    self.title =@"加餐啦";
    [self.view addSubview:self.myTableView];
    [self makeUpConstriant];
}
#pragma 约束适配
- (void)makeUpConstriant{
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}

#pragma getter方法
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
    }
    return _myTableView;
}
#pragma tableViewDelegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellid =@"OrderFoodCellID";
    OrderFoodCell *orderCell =[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!orderCell) {
        orderCell =[[OrderFoodCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    [orderCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return orderCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderFoodDetailViewController *detailVC =[[OrderFoodDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES pushType:NavigationPushCorver];
}
-(void)request{
    orderMercListRequestModel *requestModel =[[orderMercListRequestModel alloc]init];
    requestModel.page =0;
    requestModel.pageSize =1;
    
    [NetworkClient RequestWithParameters:[requestModel keyValues] withUrl:BASE_URLWith(OrderMercListHttp) needToken:NO success:^(id responseObject) {
        
        NSLog(@"%@",responseObject[@"msg"]);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([@"2000" isEqualToString:codeStr]) {
//            self.mercId =responseObject[@""];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
