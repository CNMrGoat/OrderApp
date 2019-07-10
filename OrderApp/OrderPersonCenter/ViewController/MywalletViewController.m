//
//  MywalletViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "MywalletViewController.h"
#import "BCSSliderView.h"
#import "RecordTableViewCell.h"

@interface MywalletViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *headView;/**<头部视图*/
@property (nonatomic, strong) UILabel *titlelab;
@property (nonatomic, strong) UILabel *moneyLab;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BCSSliderView *sliderView;/**<滑动器*/
@property (nonatomic, strong) UIScrollView *scrollView;/**<滚动视图*/
@property (nonatomic, assign) NSInteger tempValue;/**<临时值*/

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

@property(nonatomic, strong) NSMutableArray *leftListArray;/**<充值记录*/
@property(nonatomic, strong) NSMutableArray *rightListArray;/**<消费记录*/

@end

@implementation MywalletViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.leftListArray removeAllObjects];
    [self.rightListArray removeAllObjects];
    if (self.sliderView.whichIndex == 0) {
        [self requestRecharge];
    }else{
        [self requestConsume];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的钱包";
    [self setUp];
    [self setUpViewConstraints];
    
}

- (void)setUp{
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.titlelab];
    [self.headView addSubview:self.moneyLab];
    [self.view addSubview:self.sliderView];
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.mainView];
    [_mainView addSubview:self.leftView];
    [_mainView addSubview:self.rightView];
    [_mainView addSubview:self.tableView];
    
}

- (void)viewWillLayoutSubviews
{
    self.scrollView.contentSize = CGSizeMake(2*SCREEN_WIDTH, 100);
}

- (void)setUpViewConstraints{
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaTopHeight+15);
        make.left.equalTo(@15);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.height.mas_equalTo(100);
    }];
    
    
    [_titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.equalTo(@15);
        make.width.mas_equalTo(SCREEN_WIDTH-100);
        make.height.mas_equalTo(20);
    }];
    
    
    [_moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.equalTo(@15);
        make.width.mas_equalTo(SCREEN_WIDTH-100);
        make.height.mas_equalTo(30);
    }];
    
    
    
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sliderView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView);
        make.left.equalTo(self.mainView);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.mainView);
    }];
    
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView);
        make.left.equalTo(self.leftView.mas_right);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.mainView);
    }];
    
    if (_sliderView.whichIndex == 0) {
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.leftView);
        }];
    }else{
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.rightView);
        }];
    }
    
    
    
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightView.mas_right);
    }];

}

- (void)sliderViewIndexChanged:(NSInteger)index {
    
    [self.leftListArray removeAllObjects];
    [self.rightListArray removeAllObjects];
    
    if (index == 0)
    {
        [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.leftView);
        }];
        [self requestRecharge];
        
    }
    else if (index == 1)
    {
        [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.rightView);
        }];
        [self requestConsume];
    }

}

#pragma mark -
#pragma mark tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_sliderView.whichIndex == 0) {
        return self.leftListArray.count;
    }else{
        return  self.rightListArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setSeparatorLineHide:YES];
    [cell setTopLineStyle:DemonTableViewCellSeparatorFull];
    [cell setDemonSeparatorStyle:DemonTableViewCellSeparatorFull];
    
    
    cell.backgroundColor = [UIColor whiteColor];
    if (_sliderView.whichIndex == 0) {
        cell.rechargeModel = self.leftListArray[indexPath.row];
    }else{
        
        cell.consumeModel = self.rightListArray[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 34;
}

#pragma mark -
#pragma mark  左右滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.scrollView.contentOffset.x == 0) {
        self.sliderView.whichIndex = 0;
        
    }else if (self.scrollView.contentOffset.x == self.view.frame.size.width) {
        
        self.sliderView.whichIndex = 1;
        
    }
    if (_tempValue != self.sliderView.whichIndex) {
        self.tempValue = self.sliderView.whichIndex;
        [self sliderViewIndexChanged:_sliderView.whichIndex];
    }

}


#pragma mark -
#pragma mark  getter & setter
- (BCSSliderView *)sliderView{
    if (!_sliderView) {
        _sliderView = [[BCSSliderView alloc] init];
        _sliderView.frame = CGRectMake(0, SafeAreaTopHeight+130, SCREEN_WIDTH, 45.0f);
        _sliderView.backgroundColor = [UIColor whiteColor];
        
        if ([self.switchIndex isEqualToString:@"1"]) {
            _sliderView.whichIndex = 1;
            [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
            self.tempValue = 1;
        }else{
            _sliderView.whichIndex = 0;
        }
        [_sliderView whichButtonClicked:^(UIButton *button, NSInteger index) {
            if (index == 0) {
                self.sliderView.whichIndex = 0;
                [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }else if (index == 1) {
                self.sliderView.whichIndex = 1;
                [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
            }
            self.tempValue = self.sliderView.whichIndex;
            [self sliderViewIndexChanged:index];
        }];
        [_sliderView.leftButton setTitle:@"充值记录" forState:UIControlStateNormal];
        _sliderView.leftButton.titleLabel.font = Demon_16_Font;
        [_sliderView.rightButton setTitle:@"消费记录" forState:UIControlStateNormal];
        _sliderView.rightButton.titleLabel.font = Demon_16_Font;
    }
    return _sliderView;
}

- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = CS_Color_BackGroundGray;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[RecordTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor =CS_Color_BackZhuti;
        [_headView border:CS_Color_BackZhuti width:4];
    }
    return _headView;
}

- (UILabel *)titlelab
{
    if (!_titlelab) {
        _titlelab = [[UILabel alloc] init];
        _titlelab.textColor = [UIColor whiteColor];
        _titlelab.font = Demon_14_Font;
        _titlelab.text = @"我的余额";
    }
    return _titlelab;
}

- (UILabel *)moneyLab
{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] init];
        _moneyLab.textColor = [UIColor whiteColor];
        _moneyLab.font = Demon_18_MediumFont;
        _moneyLab.text = self.myMoney;
    }
    return _moneyLab;
}

- (UIView *)leftView {
    if (!_leftView) {
        UIView *tempView = [[UIView alloc] init];
        tempView.backgroundColor = [UIColor clearColor];
        _leftView = tempView;
    }
    return _leftView;
}

- (UIView *)rightView {
    if (!_rightView) {
        UIView *tempView = [[UIView alloc] init];
        tempView.backgroundColor = [UIColor clearColor];
        _rightView = tempView;
    }
    return _rightView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}


- (NSMutableArray *)leftListArray
{
    if (!_leftListArray) {
        _leftListArray = [NSMutableArray array];
    }
    return _leftListArray;
}
- (NSMutableArray *)rightListArray
{
    if (!_rightListArray) {
        _rightListArray = [NSMutableArray array];
    }
    return _rightListArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestRecharge {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSNumber numberWithInteger:1] forKey:@"type"];
    NSLog(@"%@",parameters);
    [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(WalletChangeLogInfoHttp) needToken:YES success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);

        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([@"2000" isEqualToString:codeStr]) {
            
            WalletModel *walletModel = [WalletModel objectWithKeyValues:responseObject];
            self.leftListArray = [WalletData objectArrayWithKeyValuesArray:walletModel.data];
            [self.tableView reloadData];
    
            
        } else {
            
            [self showHint:responseObject[@"msg"]];
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView reloadData];
    }];
    
}

- (void)requestConsume {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSNumber numberWithInteger:2] forKey:@"type"];
    NSLog(@"%@",parameters);
    [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(WalletChangeLogInfoHttp) needToken:YES success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([@"2000" isEqualToString:codeStr]) {
            
            WalletModel *walletModel = [WalletModel objectWithKeyValues:responseObject];
            self.rightListArray = [WalletData objectArrayWithKeyValuesArray:walletModel.data];
            [self.tableView reloadData];
            
            
        } else {
            
            [self showHint:responseObject[@"msg"]];
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView reloadData];
    }];
}

@end
