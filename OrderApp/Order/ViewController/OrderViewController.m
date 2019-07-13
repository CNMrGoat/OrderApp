//
//  OrderCarViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderTableViewCell.h"
#import "OrderHeadView.h"
#import "OrderFootView.h"
#import "OrderDetailViewController.h"
#import "PayedDetailViewController.h"
#import "FinishedViewController.h"
#import "CancelViewController.h"
#import "OrderListModel.h"
#import "LoginService.h"

static NSString *kCellIdentifier = @"kOrderCarCellIdentifier";

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,OrderHeadViewDelegate>

@property (nonatomic, strong) UIView * noMessageView;
@property (nonatomic, strong) UIImageView * noMessageIView;
@property (nonatomic, strong) UILabel * noMessageLab;
@property (nonatomic, strong) UIButton * goToBtn;
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) OrderHeadView *headView;
//@property (nonatomic, strong) OrderCarFootView *footView;
@property (nonatomic, strong) OrderTableViewCell *orderCell;

@property (assign, nonatomic) NSInteger page; //多少页
@property (assign, nonatomic) NSNumber* pageSize ;// 每页的数量

@property(strong,nonatomic) OrderListModel *orderListModel;//订单数据模型

@property (nonatomic ,strong) NSMutableArray *sectionArr;
@property (nonatomic ,strong) NSMutableArray *midArr; //桥梁数据

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // Do any additional setup after loading the view.
    self.page = 1;
    self.pageSize = [NSNumber numberWithInt:10];
    self.sectionArr = [NSMutableArray array];
    self.midArr = [NSMutableArray array];
    [self addView];

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    
    NSLog(@"～～～～～token～～～～～%@～～～",MyUser.token);
    
        // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];


}

- (void)requestOrderList {
    
    
    if ( [NSString isNilOrEmpty:MyUser.token] || [NSString isNilOrEmpty:MyUser.isLogin]) {
        [[LoginService sharedInstance] login:self successBlock:^() {
            
        } cancelBlock:^{
            
            
        }];
    } else  {
        
        NSNumber *page = [NSNumber numberWithInteger:self.page];
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:page  forKey:@"page"];
        [parameters setObject:self.pageSize forKey:@"pageSize"];
        
        WEAKSELF;
        [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(ShowOrderDetailHttp) needToken:YES success:^(id responseObject) {
            
            NSLog(@"%@",responseObject);
            
            self.orderListModel = [OrderListModel objectWithKeyValues:responseObject];
            
            DataModel *dataModel = self.orderListModel.data;
            
            NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            if ([@"2000" isEqualToString:codeStr]) {
                
                [weakSelf.tableView.mj_header endRefreshing];
                // 拿到当前的上拉刷新控件，结束刷新状态
                [weakSelf.tableView.mj_footer endRefreshing];
                if (dataModel.list.count>0) {
                    
                    [weakSelf.midArr addObjectsFromArray:dataModel.list];
                    weakSelf.sectionArr = [NSMutableArray arrayWithArray:self.midArr];
                }
                
                
                if (dataModel.list.count < 10) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];//放到停止加载方法后面 不然会失效
                }
                
                if ( self.midArr.count == 0) {
                    self.noMessageView.hidden = NO;
                    [self.tableView.mj_footer setHidden:YES];
                }else{
                    self.noMessageView.hidden = YES;
                }
                [weakSelf.tableView reloadData];
                
            } else {
                
                [weakSelf.midArr removeAllObjects];
                [weakSelf.sectionArr removeAllObjects];
                if ( self.midArr.count == 0) {
                    self.noMessageView.hidden = NO;
                    [self.tableView.mj_footer setHidden:YES];
                }
                [weakSelf.tableView.mj_header endRefreshing];
                [weakSelf.tableView.mj_footer endRefreshing];
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];//放到停止加载方法后面 不然会失效
                [weakSelf showHint:self.orderListModel.msg];
                [weakSelf.tableView reloadData];
            }
            
            
        } failure:^(NSError *error) {
            if (  self.midArr.count == 0) {
                self.noMessageView.hidden = NO;
                [self.tableView.mj_footer setHidden:YES];
            }
            
            [self.midArr removeAllObjects];
            [self.sectionArr removeAllObjects];
            [self.tableView.mj_header endRefreshing];
            // 拿到当前的上拉刷新控件，结束刷新状态
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            
        }];
        
    }
    
    
}

- (void)addView {
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        // Fallback on earlier versions
    }
    

    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.noMessageView];
    
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
    
    [self.noMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.tableView);
        make.height.mas_equalTo(160);
        make.width.equalTo(@200);
        
    }];
    
    [self.noMessageIView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.noMessageView);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(40);
        make.top.mas_equalTo(0);
        
    }];
    
    [self.noMessageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(self.noMessageView);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(54);
        
    }];
    
    
    [self.goToBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.noMessageView);
        make.top.mas_equalTo(110);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(34);
        
    }];
    
    [self.goToBtn border:CS_Color_BackZhuti width:0.6 CornerRadius:17];
    
    
    
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
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresData)];
        WEAKSELF;
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf refresData];
        }];
        // 马上进入刷新状态
//        [self.tableView.mj_header beginRefreshing];
        
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMore];
        }];
    }
    return _tableView;
}

- (void)refresData {
    
    _page = 1;
    [self.sectionArr removeAllObjects];
    [self.midArr removeAllObjects];
    [self.tableView reloadData];
    [self requestOrderList];
    
}
- (void)loadMore {
    ++_page;
    [self requestOrderList];
    
}

- (UIView *)noMessageView {
    
    if (!_noMessageView) {
        _noMessageView = [UIView new];
        _noMessageIView = [UIImageView new];
        _noMessageIView.image = [UIImage imageNamed:@"订单空页面"];
        _noMessageLab = [UILabel new];
        _noMessageLab.textAlignment = NSTextAlignmentCenter;
        _noMessageLab.font = Demon_15_Font;
        _noMessageLab.textColor = CS_Color_MidGray;
        _noMessageLab.text = @"暂时还没订单，快去下单";
        
        _goToBtn = [UIButton new];
        _goToBtn.backgroundColor = CS_Color_BackZhuti;
        [_goToBtn setTitle:@"去下单" forState:UIControlStateNormal];
        [_goToBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_goToBtn addTarget:self action:@selector(goToBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _goToBtn.titleLabel.font = Demon_15_MediumFont;
        
        
        
        [_noMessageView addSubview:_noMessageIView];
        [_noMessageView addSubview:_noMessageLab];
        [_noMessageView addSubview:_goToBtn];
        _noMessageView.hidden = YES;
        
    }
    return _noMessageView;
}


#pragma mark -
#pragma mark   tableView delegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 76.f;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
 
    NSLog(@"~~~~~~~~~%@~~~~~~~",self.sectionArr);
    _headView = [OrderHeadView orderHeaderViewTableView:tableView];
    _headView.delegate = self;
    _headView.listModel  = [ListModel objectWithKeyValues:self.sectionArr[section]];
    _headView.tag = 1000+section;
    
    _headView.deleteBtn.tag = 1000+section;
    [_headView.deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    return _headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 92;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = CS_Color_BackGroundGray;
    return view;

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"~~~~~~~~~%ld~~~~~~~",self.sectionArr.count);
    return self.sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ListModel *model = [ListModel objectWithKeyValues:self.sectionArr[section]];
    return model.sunList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _orderCell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];

    [_orderCell setSeparatorLineHide:YES];
    [_orderCell setTopLineStyle:DemonTableViewCellSeparatorFull];
    [_orderCell setDemonSeparatorStyle:DemonTableViewCellSeparatorFull];
    
    ListModel *model = [ListModel objectWithKeyValues:self.sectionArr[indexPath.section]];
    _orderCell.sunlistModel =  [SunlistModel objectWithKeyValues:model.sunList[indexPath.row]];
    return _orderCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListModel *model  = [ListModel objectWithKeyValues:self.sectionArr[indexPath.section]];
    NSLog(@"~~~~~~~~%ld",(long)indexPath.section);
    switch (model.status) {
        case 3:
        {
            PayedDetailViewController *vc = [PayedDetailViewController new];
            vc.orderNum = model.orderNum;
            vc.callBackBlock = ^(void){
                [self.tableView.mj_header beginRefreshing];
            };
            [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
        }
            break;
            
        case 1:
        {
            PayedDetailViewController *vc = [PayedDetailViewController new];
            vc.orderNum = model.orderNum;
            vc.callBackBlock = ^(void){
                [self.tableView.mj_header beginRefreshing];
            };
            [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
        }
            break;
            
        case 4:
        {
            FinishedViewController *vc = [FinishedViewController new];
            vc.orderNum = model.orderNum;
            vc.callBackBlock = ^(void){
                [self.tableView.mj_header beginRefreshing];
            };
            [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
        }
            break;
            
        case 2:
        {
            CancelViewController *vc = [CancelViewController new];
            vc.orderNum = model.orderNum;
            vc.callBackBlock = ^(void){
                [self.tableView.mj_header beginRefreshing];
            };
            [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
        }
            break;
            
        default:
            break;
    }
    
}



#pragma mark -
#pragma mark   点击事件

- (void)deleteBtnClicked:(UIButton *)sender {
    [self showLoadingWithMessage:@""];
    NSLog(@"~~~~删除%ld~~~~~",(long)sender.tag);
    ListModel *model  = [ListModel objectWithKeyValues:self.sectionArr[sender.tag -1000]];
    NSNumber *page = [NSNumber numberWithInteger:[model.orderNum integerValue]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:page  forKey:@"orderNum"];
    [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(DelOrderHttp) needToken:YES success:^(id responseObject) {
        [self hideHud];
        NSLog(@"%@",responseObject);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([@"2000" isEqualToString:codeStr]) {
            // 马上进入刷新状态
            [self.tableView.mj_header beginRefreshing];
        }
        [self showHint:responseObject[@"msg"]];
    } failure:^(NSError *error) {
        [self hideHud];
    }];

}


- (void)goToBtnClicked {
    
   [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchTabNotification" object:[NSIndexPath indexPathForRow:0 inSection:1]];
}

- (void)headViewAddressActionWithTag:(NSInteger)i {
    
    NSLog(@"gagagagagagga~~~~~~%ld",i);
}

@end
