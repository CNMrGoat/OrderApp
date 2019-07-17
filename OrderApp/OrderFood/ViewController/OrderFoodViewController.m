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
#import "TanChuanMessageView.h"

@interface OrderFoodViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *myTableView;
@property (nonatomic ,copy) NSString *mercId;
@property (nonatomic ,strong) NSMutableArray *ordermerclist;
@property (nonatomic ,strong) NSMutableArray *midArr; //桥梁数据
@property (nonatomic ,assign) NSInteger page;

@property (nonatomic, strong) NSString *updataStr;
@property (nonatomic, strong) NSString *lastVersion;
@property (nonatomic ,strong) TanChuanMessageView *tanChuanView;

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
    
        // 马上进入刷新状态
    [self.myTableView.mj_header beginRefreshing];

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
    
    if ( [NSString isNilOrEmpty:MyUser.token] || [NSString isNilOrEmpty:MyUser.isLogin]) {
        [self.myTableView.mj_header endRefreshing];
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.myTableView.mj_footer endRefreshing];
        [[LoginService sharedInstance] login:self successBlock:^() {
            
        } cancelBlock:^{
            
            
        }];
    } else  {
        
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
                if ([@"登录失效或未授权" isEqualToString:responseObject[@"msg"]]) {
                    [weakSelf showHint:responseObject[@"msg"]];
                    [self gotoLogin];
                } else {
                    [weakSelf showHint:responseObject[@"msg"]];
                }
               
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
    
    
    
}

- (void)gotoLogin {
    
    [[LoginService sharedInstance] login:self successBlock:^() {
        
    } cancelBlock:^{
        
        
    }];
    
}


#pragma mark 检查更新
- (void)checkUpdata
{
    
    AFHTTPSessionManager *_manager = [[AFHTTPSessionManager alloc]init];
    [_manager POST:@"https://itunes.apple.com/cn/lookup?id=1327220155" parameters:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [self verionback:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
    }];
    
}


- (void)verionback:(id)response
{
    
    NSDictionary *dic = (NSDictionary *)response;
    
    NSDictionary *localDic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *currentVersion = [localDic objectForKey:@"CFBundleShortVersionString"];
    
    NSArray *infoArray = [dic objectForKey:@"results"];
    
    if ([infoArray count]) {
        
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        self.lastVersion = [releaseInfo objectForKey:@"version"];
        _updataStr = [releaseInfo objectForKey:@"trackViewUrl"];
        
        
        NSLog(@"%@",_updataStr);
        NSArray *lastAry = [self.lastVersion componentsSeparatedByString:@"."];
        NSArray *currentAry = [currentVersion componentsSeparatedByString:@"."];
        NSString * lastVers = [lastAry componentsJoinedByString:@""];
        currentVersion = [currentAry componentsJoinedByString:@""];
        
        NSLog(@"%d   ----   %d",[lastVers intValue] ,[currentVersion intValue]);
        
        if ([lastVers intValue] > [currentVersion intValue]) {
            [self getUpdateVision];
        }
    }
}

- (void)getUpdateVision {
    
    //    WEAKSELF;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"MEM" forKey:@"appType"];
    
    [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(AppVersionUpdateHttp) needToken:NO success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([@"2000" isEqualToString:codeStr]) {
            
            [self updateWindowWithStr:responseObject[@"data"][@"versionDesc"]];
        }
    } failure:^(NSError *error) {
        
        
    }];
    
    
}



- (void)updateWindowWithStr:(NSString *)str {
    
    self.tanChuanView  = [[TanChuanMessageView alloc]initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tanChuanView.headImage.image = [UIImage imageNamed:@"更新升级"];
    self.tanChuanView.titleLabel.text = [NSString stringWithFormat:@"发现新版本 %@",self.lastVersion];
    self.tanChuanView.titleLabel1.text = str;
    
    UIApplication *ap = [UIApplication sharedApplication];
    
    [self.tanChuanView.quxiaobtn addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [self.tanChuanView.querenbtn addTarget:self action:@selector(queren) forControlEvents:UIControlEventTouchUpInside];
    [ap.keyWindow addSubview:self.tanChuanView];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.tanChuanView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    } completion:^(BOOL finished) {
        
        
    }];
}

-(void)quxiao{
    [self.tanChuanView removeFromSuperview];
}

-(void)queren{
    [self.tanChuanView removeFromSuperview];
    NSURL *url = [NSURL URLWithString:_updataStr];
    [[UIApplication sharedApplication]openURL:url];
}




@end
