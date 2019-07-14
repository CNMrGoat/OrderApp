//
//  MineCenterViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "MineCenterViewController.h"
#import "MineCenterHeaderView.h"
#import "MineCenterTableViewCell.h"
#import "MywalletViewController.h"
#import "MyOrderViewController.h"
#import "ShareFriendsViewController.h"
#import "BusiCooperationViewController.h"
#import "SuggestViewController.h"
#import "AboutUsViewController.h"
#import "PersonSetViewController.h"
#import "CodeLoginViewController.h"
#import "LoginService.h"


static NSString *kCellIdentifier = @"kMyPersonCenterCellIdentifier";

@interface MineCenterViewController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UIView *navV;

@property (nonatomic, strong) UIButton *setBtn;

@property (nonatomic, strong) MineCenterHeaderView *headView;
@property(strong,nonatomic)OrderheadVCenterModel *headModel;//订单数据模型

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) MineCenterTableViewCell *mineCCell;

@property(nonatomic,strong)NSArray *titleAry;
@property(nonatomic,strong)NSArray *imgAry;



@end

@implementation MineCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addView];
//    [self getUpdateVision];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    NSLog(@"%@----%@---%@---%@",MyUser.token,MyUser.mobile,MyUser.signature,MyUser.headImgUrl);
            
    [self requstUserInfo];


}

- (void)requstUserInfo {
    
    if ( [NSString isNilOrEmpty:MyUser.token] || [NSString isNilOrEmpty:MyUser.isLogin]) {
        
        self.headModel = [OrderheadVCenterModel new];
        self.headModel.nickName = MyUser.nickName;
        self.headModel.mobile = MyUser.mobile;
        self.headModel.signature = MyUser.signature;
        self.headModel.headImgUrl = MyUser.headImgUrl;
        self.headView.orderheadVCenterModel = self.headModel;
        [self.myTableView reloadData];
        [[LoginService sharedInstance] login:self successBlock:^() {
            
        } cancelBlock:^{
            
            
        }];
    } else  {
        
        [NetworkClient RequestWithParameters:nil withUrl:BASE_URLWith(UserInfoHttp) needToken:YES success:^(id responseObject) {
            
            NSLog(@"%@",responseObject);
            NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            
            if ([@"2000" isEqualToString:codeStr]) {
                
                self.headModel = [OrderheadVCenterModel new];
                self.headModel.nickName = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"nickName"]];
                self.headModel.mobile = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"mobile"]];
                self.headModel.signature = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"signature"]];
                self.headModel.headImgUrl = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"headImgUrl"]];
                MyUser.wallet = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"wallet"]];
                self.headView.orderheadVCenterModel = self.headModel;
                [self.myTableView reloadData];
                
            } else {
                
                if ([@"登录失效或未授权" isEqualToString:responseObject[@"msg"]]) {
                    [self showHint:@"您的账号有风险，建议更改密码"];
                    [self gotoLogin];
                } else {
                    [self showHint:responseObject[@"msg"]];
                }
                
          
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }
    
}

- (void)addView {
    
    if (@available(iOS 11.0, *)) {
        self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        // Fallback on earlier versions
    }

    [self.view addSubview:self.navV];
    [self.view addSubview:self.setBtn];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.myTableView];
    
    [self makeUpconstraint];
    self.headView.frame = CGRectMake(0, 0, 0, 150);
    self.myTableView.tableHeaderView = self.headView;
    
}

#pragma mark -
#pragma mark 约束适配
- (void)makeUpconstraint {
    
    CGFloat navBarHeight = 0.f;
    if (iPhoneX_Series) {
        navBarHeight = SafeAreaTopHeight - 64.f;
    }
    
    [self.navV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(SafeAreaTopHeight);
        make.right.mas_equalTo(self.view);
    }];
    
    
    [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(10);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(80);
        make.top.mas_equalTo(20 + navBarHeight);
    }];
    

    
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.height.mas_equalTo(SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight);
    }];
    
}

#pragma mark -
#pragma mark getter


-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.separatorStyle = NO;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        
        [_myTableView registerClass:[MineCenterTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _myTableView;
}

/**<禁止tableView下拉*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = self.myTableView.contentOffset;
    if (offset.y <= 0) {
        offset.y = 0;
    }
    self.myTableView.contentOffset = offset;
}

- (UIView *)navV
{
    if (!_navV) {
        _navV = [[UIView alloc] init];
        _navV.backgroundColor = CS_Color_BackZhuti;
//        _navV.alpha = 0.f;
    }
    return _navV;
}

- (UIButton *)setBtn
{
    if (!_setBtn) {
        _setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
        [_setBtn addTarget:self action:@selector(setBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setBtn;
}

-(MineCenterHeaderView *)headView{
    if (!_headView) {
        _headView =[[MineCenterHeaderView alloc]init];
//        _headView.delegate = self;
        _headView.orderheadVCenterModel = self.headModel;
    }
    return _headView;
}

- (NSArray *)titleAry
{
    if (!_titleAry) {
        _titleAry = @[ @"推荐好友", @"商务合作", @"意见反馈" , @"关于我们"];
    }
    return _titleAry;
}

- (NSArray *)imgAry
{
    if (!_imgAry) {
        _imgAry = @[  @"推荐", @"商务", @"意见", @"关于"];
    }
    return _imgAry;
}


#pragma mark -
#pragma mark   点击事件

- (void)setBtnAction:(UIButton *)sender {
    PersonSetViewController *vc = [PersonSetViewController new];
    [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
}

#pragma mark -
#pragma mark   tableView delegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *grayView = [[UIView alloc] init];
    grayView.backgroundColor = UI_ColorWithRGBA(240, 240, 240, 1);
    return grayView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } return self.titleAry.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _mineCCell = [self.myTableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (indexPath.section == 0) {
        
        _mineCCell.imageView.image = [UIImage imageNamed:@"钱包"];
        _mineCCell.textLabel.text = @"我的钱包";
        _mineCCell.moneyLab.text = [NSString stringWithFormat:@"  ¥ %@",MyUser.wallet];
        _mineCCell.lineV.hidden = YES;
    } else {
        
        _mineCCell.imageView.image = [UIImage imageNamed:self.imgAry[indexPath.row]];
        _mineCCell.textLabel.text = self.titleAry[indexPath.row];
        if (indexPath.row == self.titleAry.count - 1) {
            _mineCCell.lineV.hidden = YES;
        }else{
            _mineCCell.lineV.hidden = NO;
        }
        
    }

    return _mineCCell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        MywalletViewController *vc = [[MywalletViewController alloc] init];
        vc.title = @"我的钱包";
        vc.myMoney =  [NSString stringWithFormat:@"¥ %@",MyUser.wallet];
        [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
    } else {
        switch (indexPath.row) {
            case 0:{
                ShareFriendsViewController *vc = [ShareFriendsViewController new];
                [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
            }
                break;
            case 1:{
                BusiCooperationViewController *vc = [BusiCooperationViewController new];
                [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
            }
                break;
            case 2:{
                SuggestViewController *vc = [SuggestViewController new];
                [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
            }
                break;
            case 3:{
                AboutUsViewController *vc = [AboutUsViewController new];
                [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];

            }
                break;
            default:
                break;
        }
    }
}



- (void)gotoLogin {
    
    [[LoginService sharedInstance] login:self successBlock:^() {
        
    } cancelBlock:^{
        
        
    }];
    
}


@end
