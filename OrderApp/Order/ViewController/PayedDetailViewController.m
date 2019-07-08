//
//  PayedDetailViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/28.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "PayedDetailViewController.h"
#import "OrderTableViewCell.h"
#import "OrderHeadView.h"
#import "OrderPayDetailFootView.h"

static NSString *kCellIdentifier = @"kOrderCarCellIdentifier";
@interface PayedDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) OrderHeadView *headView;
@property (nonatomic, strong) OrderPayDetailFootView *footView;
@property (nonatomic, strong) OrderTableViewCell *orderCell;

@end

@implementation PayedDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self addView];
    
}

- (void)addView {
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        // Fallback on earlier versions
    }
    
    
    [self.view addSubview:self.tableView];
    
    [self makeUpconstraint];
    
    
}

#pragma mark -
#pragma mark 约束适配
- (void)makeUpconstraint {
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.height.mas_equalTo(SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight+49);
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




#pragma mark -
#pragma mark   tableView delegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 76.f;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headView = [OrderHeadView orderHeaderViewTableView:tableView];
    _headView.deleteBtn.tag = 1000+section;
    [_headView.deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return _headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 92;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    _footView = [OrderPayDetailFootView orderFooterViewTableView:tableView];
    
    return _footView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 240;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    return 2;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _orderCell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    [_orderCell setSeparatorLineHide:YES];
    [_orderCell setTopLineStyle:DemonTableViewCellSeparatorFull];
    [_orderCell setDemonSeparatorStyle:DemonTableViewCellSeparatorFull];
//    _orderCell.orderModel = [OrderModel new];
    return _orderCell;
    
}





#pragma mark -
#pragma mark   点击事件

- (void)deleteBtnClicked:(UIButton *)sender {
    
    NSLog(@"~~~~删除%ld~~~~~",sender.tag);
}


@end
