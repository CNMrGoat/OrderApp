//
//  PersonSetViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "PersonSetViewController.h"
#import "PersonSetTableViewCell.h"
#import "ChangePasswordViewController.h"

static NSString *const kTableViewCellIdentifier = @"TableViewCellIdentifier";

@interface PersonSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) UIView *footView;
@property(nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) NSArray *titleArr;

@end

@implementation PersonSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户资料";
    [self addView];

}

- (void)addView {
    
    if (@available(iOS 11.0, *)) {
        self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        // Fallback on earlier versions
    }
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.footView];
}

#pragma mark -
#pragma mark getter
- (UIView *)footView
{
    if (!_footView)
    {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight+270, SCREEN_WIDTH, SCREEN_HEIGHT- SafeAreaTopHeight-270)];
        _footView.backgroundColor = [UIColor clearColor];

        UIImage *img = [UIImage imageNamed:@"加餐啦LOGO"];
        UIImageView *QRImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 -50,20, 100, 100)];
        QRImgView.image = img;
        [_footView addSubview:QRImgView];


        UILabel *labelup = [[UILabel alloc]initWithFrame:CGRectMake(0,140, SCREEN_WIDTH, 10)];
        labelup.font = Demon_15_Font;
        labelup.textColor = CS_Color_MidGray;
        labelup.text = @"我的二维码";
        labelup.textAlignment = NSTextAlignmentCenter;
        [_footView addSubview:labelup];

        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, _footView.height-SafeAreaBottomHeight, SCREEN_WIDTH, 49)];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn setTitleColor:CS_Color_BackZhuti forState:UIControlStateNormal];
        btn.titleLabel.font = Demon_17_MediumFont;
        [btn addTarget:self action:@selector(logOutBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:btn];

    }
    return _footView;
}

-(UITableView *)myTableView
{
    if (_myTableView == nil)
    {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight+10,SCREEN_WIDTH, 250) style:UITableViewStylePlain];
        [_myTableView setDataSource:self];
        [_myTableView setDelegate:self];
        [_myTableView setSeparatorColor:[UIColor clearColor]];
        [_myTableView setSeparatorColor:[UIColor redColor]];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.scrollEnabled = NO;
        [_myTableView registerClass:[PersonSetTableViewCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
    }
    return _myTableView;
}

- (NSArray *)dataArr
{
    if (!_dataArr)
    {
        _dataArr = @[@"http://www.bankofchangsha.com",@"驾驭科技",@"用于密码登录",@"137****5678",@"搏一搏单车变摩托"];
    }
    return _dataArr;
}

- (NSArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = @[@"头像",@"名称",@"修改密码",@"电话号码",@"签名"];
    }
    return _titleArr;
}

- (void)logOutBtnClicked {
    
}


#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PersonSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier];
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.tilLabel.textColor = CS_Color_DeepGray;
    cell.tilLabel.text = self.dataArr[indexPath.row];
    
    if (indexPath.row == 0)
    {
        cell.headImgV.image = [UIImage imageNamed:@"加餐啦LOGO"];
        cell.headImgV.hidden = NO;
        cell.tilLabel.hidden = YES;
        [cell setDemonSeparatorStyle:DemonTableViewCellSeparatorFull];
    }
    else
    {
        [cell setDemonSeparatorStyle:DemonTableViewCellSeparatorLeft];
        cell.headImgV.hidden = YES;
        cell.tilLabel.hidden = NO;
    }
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        
        ChangePasswordViewController *vc = [ChangePasswordViewController new];
        [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
        
    }

}



@end
