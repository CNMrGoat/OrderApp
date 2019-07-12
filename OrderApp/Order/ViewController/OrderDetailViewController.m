//
//  OrderCarDetailViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderTableViewCell.h"
#import "OrderDetailFootView.h"
#import "OrderDetailHeadView.h"
#import "OrderDetialModel.h"

static NSString *kCellIdentifier = @"kOrderCarCellIdentifier";

@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) OrderDetailHeadView *headView;
@property (nonatomic, strong) OrderDetailFootView *footView;
@property (nonatomic, strong) OrderTableViewCell *orderCell;
@property (nonatomic, strong) UILabel *bottomLab;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) UIButton *payBtn;

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *mercName;
@property (nonatomic, strong) NSString *totalAmount;
@property (nonatomic, strong) NSString *intor;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认支付";
    // Do any additional setup after loading the view.
    [self addView];
    self.listArray = [NSMutableArray array];
    [self requestPayOrderDetail];
}

- (void)requestPayOrderDetail {
    
    
    WEAKSELF;
    [NetworkClient RequestWithParameters:nil withUrl:BASE_URLWith(GoodsCacheHttp) needToken:YES success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
//        self.orderDetialModel = [OrderDetialModel objectWithKeyValues:responseObject];
//        
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([@"2000" isEqualToString:codeStr]) {
            
            NSArray *arr = responseObject[@"data"][0][@"list"];
            
            [self.listArray addObjectsFromArray:arr];
            self.totalAmount = [NSString stringWithFormat:@"   ¥  %@",responseObject[@"data"][0][@"totalAmount"]];
            self.mercName = [NSString stringWithFormat:@"%@",responseObject[@"data"][0][@"mercName"]];
            self.bottomLab.text = self.totalAmount;
            [weakSelf.tableView reloadData];
            
        } else {
            
            [self showHint:responseObject[@"msg"]];
        }
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
}

- (void)addView {
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        // Fallback on earlier versions
    }
    
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomLab];
    [self.view addSubview:self.payBtn];
    
    [self makeUpconstraint];
    
    
}

#pragma mark -
#pragma mark 约束适配
- (void)makeUpconstraint {
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.height.mas_equalTo(SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight);
    }];
    
    [self.bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH*7/10);
        make.top.mas_equalTo(SCREEN_HEIGHT-SafeAreaBottomHeight);
        make.height.mas_equalTo(49);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomLab.mas_right);
        make.right.mas_equalTo(self.view);
        make.bottom.height.mas_equalTo(self.bottomLab);
    }];
    

    

    
    
    
}

#pragma mark -
#pragma mark getter


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [_tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

-(UILabel *) bottomLab {
    if (!_bottomLab) {
        _bottomLab = [UILabel new];
        _bottomLab.backgroundColor = UIColorFromHex(0x404040);
        _bottomLab.textColor = [UIColor whiteColor];
        _bottomLab.font = Demon_17_MediumFont;
    }
    return _bottomLab;
}

-(UIButton *) payBtn {
    if (!_payBtn) {
        _payBtn = [UIButton new];
        _payBtn.backgroundColor = CS_Color_BackZhuti;
        [_payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(payBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _payBtn.titleLabel.font = Demon_15_Font;
    }
    return _payBtn;
}

- (void)payBtnClicked {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"" forKey:@"desc"];
    
    [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(SubOrderAndPayHttp) needToken:YES success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        [self showHint:responseObject[@"msg"]];
        if ([@"2000" isEqualToString:codeStr]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}



#pragma mark -
#pragma mark   tableView delegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 76.f;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headView = [OrderDetailHeadView orderHeaderViewTableView:tableView];
    _headView.nameLab.text = [NSString stringWithFormat:@"收货人：%@",MyUser.nickName];
    _headView.orderNameLab.text = [NSString stringWithFormat:@"%@",self.mercName];
    return _headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 130;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    _footView= [OrderDetailFootView orderFooterViewTableView:tableView];
    _footView.amountLable.text = [NSString stringWithFormat:@"小计 ¥%@",self.totalAmount];
    return _footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 60;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
     return self.listArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _orderCell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    [_orderCell setSeparatorLineHide:YES];
    [_orderCell setTopLineStyle:DemonTableViewCellSeparatorFull];
    [_orderCell setDemonSeparatorStyle:DemonTableViewCellSeparatorFull];
    SunlistModel *model = [SunlistModel new];
    model.pic = [NSString stringWithFormat:@"%@",self.listArray[indexPath.row][@"pic"]];
    model.goodName = [NSString stringWithFormat:@"%@",self.listArray[indexPath.row][@"goodName"]];
    model.num = [NSString stringWithFormat:@"%@",self.listArray[indexPath.row][@"goodsNum"]];
    model.price = [NSString stringWithFormat:@"%@",self.listArray[indexPath.row][@"goodsPrice"]];
    _orderCell.sunlistModel = model;
    return _orderCell;
    
}





@end
