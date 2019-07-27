//
//  OrderFoodMerchantInfoVC.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/8.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodMerchantInfoVC.h"
#import "OrderFoodDetailHeadView.h"
#import "OrderFoodMerchantImageHorizonScrollCell.h"
#import "OrderFoodModel.h"
#import <UShareUI/UShareUI.h>
@interface OrderFoodMerchantInfoVC ()<OrderFoodDetailHeadViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)OrderFoodDetailHeadView *headView;
@property (nonatomic, strong)UILabel *addressLabel;
@property (nonatomic, strong)UILabel *showAddressLabel;
@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)UILabel *showPhoneLabel;
@end

@implementation OrderFoodMerchantInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    
    NSLog(@"%@--------%@",[NSString stringWithFormat:@"%@",self.mercInfoDic[@"mercInfo"][@"introduce"]],[NSString stringWithFormat:@"%@",self.mercInfoDic[@"mercInfo"][@"pic"]]);
    
    NSLog(@"%@",self.mercInfoDic);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma 添加视图
-(void)addView{
    
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        // Fallback on earlier versions
    }
    
    [self.view addSubview:self.mainTableView];
    [self makeUpConstraint];
}
#pragma 约束适配
-(void)makeUpConstraint{
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.height.mas_equalTo(self.view);
    }];
}

#pragma tableViewDelegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderFoodMerchantImageHorizonScrollCell *scrollCell =[tableView dequeueReusableCellWithIdentifier:@"KOrderFoodMerchantImageHorizonScrollCell"];
    
    if (!scrollCell) {
//        scrollCell =[[OrderFoodMerchantImageHorizonScrollCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"KOrderFoodMerchantImageHorizonScrollCell"];
        scrollCell =[[OrderFoodMerchantImageHorizonScrollCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"KOrderFoodMerchantImageHorizonScrollCell" WithIntroduce:[NSString stringWithFormat:@"%@",self.mercInfoDic[@"mercInfo"][@"introduce"]] withPic:[NSString stringWithFormat:@"%@",self.mercInfoDic[@"mercInfo"][@"pic"]]];
      

    }
    return scrollCell;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView =[[UIView alloc]init];
    if (section ==0) {
        [headView addSubview:self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headView);
            make.right.mas_equalTo(headView);
            make.bottom.mas_equalTo(headView);
            make.top.mas_equalTo(headView);
        }];
    }
    return headView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView =[[UIView alloc]init];
    footView.backgroundColor = [UIColor whiteColor];
    [footView addSubview:self.addressLabel];
    [footView addSubview:self.showAddressLabel];
    [footView addSubview:self.phoneLabel];
    [footView addSubview:self.showPhoneLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(footView);
    }];
    [self.showAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.top.mas_equalTo(self.addressLabel.mas_bottom).offset(5);
        make.height.equalTo(@38);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.showAddressLabel.mas_bottom).offset(5);
    }];
    [self.showPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.phoneLabel.mas_bottom).offset(5);
    }];

    return footView;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 250;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 160;
}

#pragma getter
-(UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.scrollEnabled = NO;
        [_mainTableView setDelegate:self];
        [_mainTableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_mainTableView setDataSource:self];
    }
    return _mainTableView;
}
-(OrderFoodDetailHeadView *)headView{
    if (!_headView) {
        _headView =[[OrderFoodDetailHeadView alloc]init];
        [_headView setLocalDelegate:self];
        [_headView setMercInfoDic:self.mercInfoDic[@"mercInfo"]];
    }
    return _headView;
}

-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel =[[UILabel alloc]init];
        [_addressLabel setText:@"商家地址"];
        [_addressLabel setFont:Demon_15_Font];
    }
    return _addressLabel;
}
-(UILabel *)showAddressLabel{
    if (!_showAddressLabel) {
        _showAddressLabel =[[UILabel alloc]init];
        [_showAddressLabel setText:[NSString stringWithFormat:@"%@",self.mercInfoDic[@"mercInfo"][@"contactArea"]]];
        [_showAddressLabel setFont:Demon_13_Font];
        _showAddressLabel.numberOfLines = 0;
        [_showAddressLabel setTextColor:CS_Color_MidGray];
    }
    return _showAddressLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel =[[UILabel alloc]init];
        [_phoneLabel setText:@"商家电话"];
        [_phoneLabel setFont:Demon_15_Font];
    }
    return _phoneLabel;
}
-(UILabel *)showPhoneLabel{
    if (!_showPhoneLabel) {
        _showPhoneLabel =[[UILabel alloc]init];
        [_showPhoneLabel setText:[NSString stringWithFormat:@"%@",self.mercInfoDic[@"mercInfo"][@"contactOne"]]];
        [_showPhoneLabel setFont:Demon_13_Font];
        [_showPhoneLabel setTextColor:CS_Color_MidGray];
    }
    return _showPhoneLabel;
}

#pragma OrderFoodDetailHeadViewDelegate
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)shareAction {
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];
    
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"加餐啦" descr:@"公司/团队点餐必备软件！" thumImage:[UIImage imageNamed:@"加餐啦LOGO"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://qiniuzhaodian.csjiayu.com/5d25ac50987c3_admin_sm_html.html";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)jumpAction {
    
}


@end
