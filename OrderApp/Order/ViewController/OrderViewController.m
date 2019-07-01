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

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
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
    }
    return _tableView;
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
    _headView = [OrderHeadView orderHeaderViewTableView:tableView];
    _headView.delegate = self;
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
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    } return 3;
    
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _orderCell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];

    [_orderCell setSeparatorLineHide:YES];
    [_orderCell setTopLineStyle:DemonTableViewCellSeparatorFull];
    [_orderCell setDemonSeparatorStyle:DemonTableViewCellSeparatorFull];
    _orderCell.orderModel = [OrderModel new];
    return _orderCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"~~~~~~~~%ld",indexPath.section);
    switch (indexPath.section) {
        case 0:
        {
            OrderDetailViewController *vc = [OrderDetailViewController new];
            [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
        }
            break;
            
        case 1:
        {
            PayedDetailViewController *vc = [PayedDetailViewController new];
            [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
        }
            break;
            
        case 2:
        {
            FinishedViewController *vc = [FinishedViewController new];
            [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
        }
            break;
            
        case 3:
        {
            CancelViewController *vc = [CancelViewController new];
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
    
    NSLog(@"~~~~删除%ld~~~~~",sender.tag);
}


- (void)goToBtnClicked {
    
   [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchTabNotification" object:[NSIndexPath indexPathForRow:0 inSection:1]];
}

- (void)headViewAddressActionWithTag:(NSInteger)i {
    
    NSLog(@"gagagagagagga~~~~~~%ld",i);
}

@end
