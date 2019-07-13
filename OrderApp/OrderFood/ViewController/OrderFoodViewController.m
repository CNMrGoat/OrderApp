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
#import "LoginService.h"

@interface OrderFoodViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *myTableView;
@property (nonatomic ,copy) NSString *mercId;
@property (nonatomic ,strong) NSMutableArray *ordermerclist;
@property (nonatomic ,strong) NSMutableArray *midArr; //桥梁数据
@property (nonatomic ,assign) NSInteger page;

@end

@implementation OrderFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page =1;
    self.ordermerclist =[NSMutableArray array];
    self.midArr = [NSMutableArray array];
    [self addView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"%@----%@---%@---%@",MyUser.token,MyUser.mobile,MyUser.signature,MyUser.headImgUrl);
    
    if ( [NSString isNilOrEmpty:MyUser.token] || [NSString isNilOrEmpty:MyUser.isLogin]) {
        [[LoginService sharedInstance] login:self successBlock:^() {
            
        } cancelBlock:^{
            
            
        }];
    } else  {

        // 马上进入刷新状态
        [self.myTableView.mj_header beginRefreshing];

    }
    

}



#pragma 添加视图
- (void)addView{
    self.title =@"加餐啦";
    if (@available(iOS 11.0, *)) {
        self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        // Fallback on earlier versions
    }
    
    [self.view addSubview:self.myTableView];
    [self makeUpConstriant];
}
#pragma 约束适配
- (void)makeUpConstriant{
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.height.mas_equalTo(SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight);
    }];
}

#pragma getter方法
-(UITableView *)myTableView{
    
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.separatorStyle = NO;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        [_tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
        
        _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresData)];
        WEAKSELF;
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf refresData];
        }];
        // 马上进入刷新状态
//        [self.myTableView.mj_header beginRefreshing];
        
        self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMore];
        }];
    }
    return _myTableView;
    
}
- (void)refresData {
    
    _page = 1;
    [self.ordermerclist removeAllObjects];
    [self.midArr removeAllObjects];
//    [self.myTableView reloadData];
    [self requestOrderMercList];
    
}
- (void)loadMore {
    ++_page;
    [self requestOrderMercList];
    
}
#pragma tableViewDelegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ordermerclist.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellid =@"OrderFoodCellID";
    OrderFoodCell *orderCell =[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!orderCell) {
        orderCell =[[OrderFoodCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    orderMercListResponseModel *reponseModel =[orderMercListResponseModel objectWithKeyValues:self.ordermerclist[indexPath.row]];
    [orderCell setListModel:reponseModel];
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
    
    
     orderMercListResponseModel *reponseModel =[orderMercListResponseModel objectWithKeyValues:self.ordermerclist[indexPath.row]];
    OrderFoodDetailViewController *detailVC =[[OrderFoodDetailViewController alloc]init];
    detailVC.mercResponseModel =reponseModel;
    [self.navigationController pushViewController:detailVC animated:YES pushType:NavigationPushCorver];
}

-(void)requestOrderMercList{
    orderMercListRequestModel *requestModel =[[orderMercListRequestModel alloc]init];
    requestModel.page = self.page;
    requestModel.pageSize = 10;
     WEAKSELF;
    [NetworkClient RequestWithParameters:[requestModel JSONObject] withUrl:BASE_URLWith(OrderMercListHttp) needToken:YES success:^(id responseObject) {
        NSLog(@"%@",responseObject[@"msg"]);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([@"2000" isEqualToString:codeStr]) {
            
            [weakSelf.myTableView.mj_header endRefreshing];
            // 拿到当前的上拉刷新控件，结束刷新状态
            [weakSelf.myTableView.mj_footer endRefreshing];
            NSArray *arr =responseObject[@"data"];
            if (arr.count>0) {
                
                [weakSelf.midArr addObjectsFromArray:arr];
                weakSelf.ordermerclist = [NSMutableArray arrayWithArray:self.midArr];
            }
            
            
            if (arr.count < 10) {
                [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];//放到停止加载方法后面 不然会失效
            }
            
            if ( self.midArr.count == 0) {
                [self.myTableView.mj_footer setHidden:YES];
            }
            [weakSelf.myTableView reloadData];
            
        } else {
            
            [weakSelf.midArr removeAllObjects];
            [weakSelf.ordermerclist removeAllObjects];
            if ( self.midArr.count == 0) {
                [self.myTableView.mj_footer setHidden:YES];
            }
            [weakSelf.myTableView.mj_header endRefreshing];
            [weakSelf.myTableView.mj_footer endRefreshing];
            [weakSelf.myTableView.mj_footer endRefreshingWithNoMoreData];//放到停止加载方法后面 不然会失效
            [weakSelf showHint:responseObject[@"msg"]];
            [weakSelf.myTableView reloadData];
        }
        
    } failure:^(NSError *error) {
        if (  self.midArr.count == 0) {
            [self.myTableView.mj_footer setHidden:YES];
        }
        
        [self.midArr removeAllObjects];
        [self.ordermerclist removeAllObjects];
        [self.myTableView.mj_header endRefreshing];
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.myTableView.mj_footer endRefreshing];
        [self.myTableView reloadData];
    }];
}





@end
