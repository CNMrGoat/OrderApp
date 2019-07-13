//
//  OrderFoodDetailViewController.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodDetailViewController.h"
#import "OrderFoodDetailHeadView.h"
#import "OrderFoodDetailMenuCategoryCell.h"
#import "OrderFoodDetailSubMenuCell.h"
#import "subListCell.h"
#import "OrderFoodDetailHorizonScrollCell.h"
#import "OrderFoodDetailFootChargeView.h"
#import "OrderFoodModel.h"
#import "OrderFoodMerchantInfoVC.h"
#import "OrderFoodMerchantProductInfoVC.h"
#import "OrderDetailViewController.h"
#import <UShareUI/UShareUI.h>
@interface OrderFoodDetailViewController ()<UITableViewDelegate,UITableViewDataSource,OrderFoodDetailHeadViewDelegate,OrderFoodDetailFootChargeViewDelegate,OrderFoodDetailHorizonScrollCellDelegate,subListCellDelegate>
@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)OrderFoodDetailHeadView *headView;
@property (nonatomic, strong)OrderFoodDetailFootChargeView *footChargeView;
@property (nonatomic, copy)NSDictionary *merchantInfoDic;
@property (nonatomic, strong)subListCell *subCell;
@property (nonatomic, strong)OrderFoodDetailHorizonScrollCell *subMenuCell;
@property (nonatomic, strong)NSDictionary *dataDicF;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, copy)NSString *moneyStr;
@end

@implementation OrderFoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self requestMercGoodsInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma 添加视图
- (void)addView{
    
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        // Fallback on earlier versions
    }
    self.count =0;
    self.moneyStr =@"0.00";
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.footChargeView];
    [self makeUpContraints];
}

#pragma 约束适配
-(void)makeUpContraints{
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(SCREEN_HEIGHT -60);
    }];
    [self.footChargeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
}
#pragma tableViewDelegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(indexPath.section ==0){
        NSString *cellId =@"DetailHorizonScrollCellId";
       _subMenuCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!_subMenuCell) {
            _subMenuCell =[[OrderFoodDetailHorizonScrollCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        [_subMenuCell setLocalDelegate:self];
        [_subMenuCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return _subMenuCell;
    }else{
        NSString *cellId =@"MainTableViewCellId";
        _subCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!_subCell) {
            _subCell =[[subListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        [_subCell setLocalDelegate:self];
        [_subCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return _subCell;
    }
 
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
    return footView;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 205;
    }else{
        return 300;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 220;
    }
    return 0.1;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma getter
-(UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_mainTableView setDelegate:self];
        [_mainTableView setDataSource:self];
        [_mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _mainTableView;
}
-(OrderFoodDetailHeadView *)headView{
    if (!_headView) {
        _headView =[[OrderFoodDetailHeadView alloc]init];
        [_headView setLocalDelegate:self];
    }
    return _headView;
}
-(OrderFoodDetailFootChargeView *)footChargeView{
    if (!_footChargeView) {
        _footChargeView =[[OrderFoodDetailFootChargeView alloc]init];
        [_footChargeView setLocalDelegate:self];
        [_footChargeView setCount:self.count andMoney:self.moneyStr];
    }
    return _footChargeView;
}
//让自身这个手势事件响应优先级高于其它手势事件
//只是在对于比它响应优先级高的手势调用
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
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
-(void)jumpAction{
    OrderFoodMerchantInfoVC *detailVC =[[OrderFoodMerchantInfoVC alloc]init];
//    detailVC.mercInfoDic =self.merchantInfoDic;
    detailVC.mercInfoDic =self.dataDicF;
    [self.navigationController pushViewController:detailVC animated:YES pushType:NavigationPushCorver];
}
#pragma OrderFoodDetailFootChargeViewDelegate
-(void)todayToBuy{
    OrderDetailViewController * detailVC =[[OrderDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES pushType:NavigationPushCorver];
}
-(void)tomorrowToBuy{
    OrderDetailViewController * detailVC =[[OrderDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES pushType:NavigationPushCorver];
}

#pragma OrderFoodDetailHorizonScrollCellDelegate
-(void)horizonScrollAddNum:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(nonnull OrderCountNumView *)numView{
    self.count ++;
    self.moneyStr =[self.moneyStr addAmt:subListModel.price];
     subListModel.goodsNum =[NSString stringWithFormat:@"%zd",count];
    [self requestAddGoodsCache:subListModel];
    [self.footChargeView setCount:self.count andMoney:self.moneyStr];
}
-(void)horizonScrollSubNum:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(nonnull OrderCountNumView *)numView{
    self.count --;
    self.moneyStr =[self.moneyStr subtractAmt:subListModel.price];
    subListModel.goodsNum =[NSString stringWithFormat:@"%zd",count];
    [self requestAddGoodsCache:subListModel];
    [self.footChargeView setCount:self.count andMoney:self.moneyStr];
}
-(void)didSelectCell:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(nonnull OrderCountNumView *)numView{
    OrderFoodMerchantProductInfoVC *detailVC =[[OrderFoodMerchantProductInfoVC alloc]init];
    detailVC.mercResponseModel = self.mercResponseModel;
    [detailVC setSubListModel:subListModel];
   __block NSInteger number =count;
    WEAKSELF
    detailVC.localBlock = ^(NSInteger count, BOOL isSub, BOOL isAdd, mercGoodsInfoResponseSubListModel * _Nonnull subListModel, OrderCountNumView * _Nonnull countView) {
        if (isSub) weakSelf.count--; weakSelf.moneyStr =[weakSelf.moneyStr subtractAmt:subListModel.price]; [weakSelf.footChargeView setCount:weakSelf.count andMoney:weakSelf.moneyStr];
        if (isAdd) weakSelf.count++; weakSelf.moneyStr =[weakSelf.moneyStr addAmt:subListModel.price]; [weakSelf.footChargeView setCount:weakSelf.count andMoney:weakSelf.moneyStr];
         number =count;
        [numView setNum:count];
    };
    detailVC.count =number;
    [self.navigationController pushViewController:detailVC animated:YES pushType:NavigationPushCorver];
}
#pragma subListCellDelegate
-(void)leftSelect{
    
}
-(void)rightSelectAdd:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(nonnull OrderCountNumView *)numView{
     self.count ++;
     self.moneyStr =[self.moneyStr addAmt:subListModel.price];
     subListModel.goodsNum =[NSString stringWithFormat:@"%zd",count];
     [self requestAddGoodsCache:subListModel];
     [self.footChargeView setCount:self.count andMoney:self.moneyStr];
}
-(void)rightSelectSub:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(nonnull OrderCountNumView *)numView{
    self.count --;
    self.moneyStr =[self.moneyStr subtractAmt:subListModel.price];
     subListModel.goodsNum =[NSString stringWithFormat:@"%zd",count];
    [self requestAddGoodsCache:subListModel];
    [self.footChargeView setCount:self.count andMoney:self.moneyStr];
}
-(void)rightJumpAction:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(nonnull OrderCountNumView *)numView{

   OrderFoodMerchantProductInfoVC *detailVC =[[OrderFoodMerchantProductInfoVC alloc]init];
    detailVC.mercResponseModel = self.mercResponseModel;
    [detailVC setSubListModel:subListModel];
    __block NSInteger number =count;
    WEAKSELF
    detailVC.localBlock = ^(NSInteger count, BOOL isSub, BOOL isAdd, mercGoodsInfoResponseSubListModel * _Nonnull subListModel, OrderCountNumView * _Nonnull countView) {
        if (isSub) weakSelf.count--; weakSelf.moneyStr =[weakSelf.moneyStr subtractAmt:subListModel.price]; [weakSelf.footChargeView setCount:weakSelf.count andMoney:weakSelf.moneyStr];
        if (isAdd) weakSelf.count++; weakSelf.moneyStr =[weakSelf.moneyStr addAmt:subListModel.price]; [weakSelf.footChargeView setCount:weakSelf.count andMoney:weakSelf.moneyStr];
         number =count;
        [numView setNum:count];
    };
    detailVC.count =number;
    [self.navigationController pushViewController:detailVC animated:YES pushType:NavigationPushCorver];
}


#pragma 单个商品每次加减触发提交
-(void)requestAddGoodsCache:(mercGoodsInfoResponseSubListModel *)subListModel{
    addGoodsCacheRequestModel *requestModel =[[addGoodsCacheRequestModel alloc]init];
    requestModel.mercId =self.mercResponseModel.mercid;
    requestModel.comId =MyUser.comInfoUid;
    requestModel.goodsId =subListModel.goodsId;
    requestModel.goodsNum =subListModel.goodsNum;
    
    NSLog(@"%@",[requestModel keyValues]);
    WEAKSELF
    [NetworkClient RequestWithParameters:[requestModel keyValues] withUrl:BASE_URLWith(AddGoodsCacheHttp) needToken:YES success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([@"2000" isEqualToString:codeStr]) {
            
            NSDictionary *dataDic = responseObject[@"data"];
            weakSelf.dataDicF = dataDic;
          
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


#pragma 商家店铺点单界面
-(void)requestMercGoodsInfo{
    mercGoodsInfoRequestModel *requestModel =[[mercGoodsInfoRequestModel alloc]init];
    requestModel.mercId =self.mercResponseModel.mercid;
    WEAKSELF
    [NetworkClient RequestWithParameters:[requestModel keyValues] withUrl:BASE_URLWith(MercGoodsInfoHttp) needToken:YES success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([@"2000" isEqualToString:codeStr]) {
            
           NSDictionary *dataDic = responseObject[@"data"];
            weakSelf.dataDicF = dataDic;
            [weakSelf.headView setMercInfoDic:dataDic[@"mercInfo"]];
            NSDictionary *hotDic =dataDic[@"hotList"];
            weakSelf.subMenuCell.hotList = hotDic[@"list"];
            weakSelf.subCell.categoryList =dataDic[@"otherList"];
            [weakSelf.subMenuCell reloadData];
            [weakSelf.mainTableView reloadData];
            [weakSelf.subCell reloadData];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
