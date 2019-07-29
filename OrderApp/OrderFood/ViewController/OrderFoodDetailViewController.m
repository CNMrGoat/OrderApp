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

#import "OrderTableViewCell.h"

static NSString *kCellId = @"kOrderCarCellIdentifier";

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

@property(nonatomic,strong)UIView *navV; /**< 导航栏视图 */
@property (nonatomic ,strong) UIButton *backbtn1;
@property (nonatomic ,strong) UIButton *backbtn;
@property (nonatomic ,strong) UIButton *shareImg;
@property(nonatomic)BOOL isDragging; /**< 判断是否将要拖拽 */
@property(nonatomic, assign)BOOL isHaveHotData;//招牌美味是否有数据


@property (nonatomic) UIButton *backView;
@property (nonatomic) UITableView *listTableView;
@property (nonatomic, strong) OrderTableViewCell *orderCell;
@property (nonatomic, strong) NSMutableArray *sectionArray;

@end

@implementation OrderFoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sectionArray = [NSMutableArray array];
    [self addView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestMercGoodsInfo];
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
    
    self.isHaveHotData =YES;
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.footChargeView];
    [self.view addSubview:self.navV];
    [self.view addSubview:self.backbtn];
    [self.view addSubview:self.shareImg];
    [self.view addSubview:self.backbtn1];

    
    
    [self makeUpContraints];
}

#pragma 约束适配
-(void)makeUpContraints{
    
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
    
    [self.backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(80);
        make.top.mas_equalTo(5 + navBarHeight);
        
    }];
    
    [self.shareImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.view).mas_offset(10);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(80);
        make.top.mas_equalTo(20 + navBarHeight);
        
    }];
    
    
    [self.backbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(10);
        make.centerY.equalTo(self.shareImg);
        
    }];
    

    
    
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
    

    
    if (tableView.tag == 10001) {
        return 1;
    } else {
        
        if (!self.isHaveHotData) {
            return 1;
        }else{
            return 2;
        }
    }
    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 10001) {
        
        NSArray *arr = self.sectionArray[section][@"list"];
        return arr.count;
    } else {
        
        return 1;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 10001) {
        
        _orderCell = [self.listTableView dequeueReusableCellWithIdentifier:kCellId];
        
        [_orderCell setSeparatorLineHide:YES];
        [_orderCell setTopLineStyle:DemonTableViewCellSeparatorFull];
        [_orderCell setDemonSeparatorStyle:DemonTableViewCellSeparatorFull];
        SunlistModel *model = [SunlistModel new];
        model.pic = [NSString stringWithFormat:@"%@",self.sectionArray[indexPath.section][@"list"][indexPath.row][@"pic"]];
        model.goodName = [NSString stringWithFormat:@"%@",self.sectionArray[indexPath.section][@"list"][indexPath.row][@"goodName"]];
        model.num = [NSString stringWithFormat:@"%@",self.sectionArray[indexPath.section][@"list"][indexPath.row][@"goodsNum"]];
        model.price = [NSString stringWithFormat:@"%@",self.sectionArray[indexPath.section][@"list"][indexPath.row][@"goodsPrice"]];
        _orderCell.sunlistModel = model;
        return _orderCell;
    } else {
        
        if (!self.isHaveHotData) {
            NSString *cellId =@"MainTableViewCellId";
            _subCell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if(!_subCell) {
                _subCell =[[subListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
            }
            [_subCell setLocalDelegate:self];
            [_subCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return _subCell;
        }else{
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
    }
   

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (tableView.tag == 10001) {
        
        UIView *footView =[[UIView alloc]init];
        return footView;
    } else {
        
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
  

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView =[[UIView alloc]init];
    return footView;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag == 10001) {
        
        return 76.f;
    } else {
        
        if (!self.isHaveHotData) {
            if (SCREEN_HEIGHT -60 -220 -205 > 300) {
                return SCREEN_HEIGHT -60 -220 -205;
            } return 300;
        }else{
            if (indexPath.section ==0) {
                return 205;
            }else{
                if (SCREEN_HEIGHT -60 -220 -205 > 300) {
                    return SCREEN_HEIGHT -60 -220 -205;
                } return 300;
            }
        }
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView.tag == 10001) {

        return 0.1;
        
    } else {
        
        if (section ==0) {
            return 250;
        }
        return 0.1;
    }
    

   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10001) {
        
        [_backView removeFromSuperview];
        _backView = nil;
        [_listTableView removeFromSuperview];
        _listTableView = nil;
        [self.sectionArray removeAllObjects];
    }
    
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
        _headView.backbtn1.hidden = YES;
        _headView.backbtn.hidden = YES;
        _headView.shareImg.hidden = YES;
        [_headView setLocalDelegate:self];
    }
    return _headView;
}
-(OrderFoodDetailFootChargeView *)footChargeView{
    if (!_footChargeView) {
        _footChargeView =[[OrderFoodDetailFootChargeView alloc]init];
        [_footChargeView setLocalDelegate:self];
//        [_footChargeView setCount:self.count andMoney:self.];
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
    if (self.count>0) {
        OrderDetailViewController * detailVC =[[OrderDetailViewController alloc]init];
        detailVC.sendTime = @"1";
        detailVC.mercId = self.mercResponseModel.mercid;
        [self.navigationController pushViewController:detailVC animated:YES pushType:NavigationPushCorver];
    } else {
        [self showHint:@"您还未选中商品！"];
    }
    
}
-(void)tomorrowToBuy{
    if (self.count>0) {
        OrderDetailViewController * detailVC =[[OrderDetailViewController alloc]init];
        detailVC.sendTime = @"2";
        detailVC.mercId = self.mercResponseModel.mercid;
        [self.navigationController pushViewController:detailVC animated:YES pushType:NavigationPushCorver];
    } else {
        [self showHint:@"您还未选中商品！"];
    }
}

-(void)showSelectedList {
    NSLog(@"lalallala");
    
    [self requestPayOrderDetail];

}


- (void)requestPayOrderDetail {
    
    WEAKSELF;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:self.mercResponseModel.mercid forKey:@"mercId"];
    
    [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(GoodsCacheHttp) needToken:YES success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([@"2000" isEqualToString:codeStr]) {
            
            NSArray *arr = responseObject[@"data"];
            
            if (arr) {
                [self.sectionArray addObjectsFromArray:arr];
                
                NSArray *array = self.sectionArray[0][@"list"];
                NSInteger a = array.count;
                if (a>0) {
                    [weakSelf showListView];
                }
            }
        
            
        } else {
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)showListView {

    
    [[UIApplication sharedApplication].keyWindow addSubview:self.backView];
    
    
    
    [UIView animateWithDuration:.23 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    //    [UIView animateWithDuration:.15 animations:^{
    //
    //
    //    } completion:^(BOOL finished) {
    //
    //        _backView.transform = CGAffineTransformMakeScale(.1, .1);
    //        [UIView animateWithDuration:.3 animations:^{
    //            _backView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    //        } completion:^(BOOL finished) {
    //            [UIView animateWithDuration:.1 animations:^{
    //                _backView.transform = CGAffineTransformMakeScale(1, 1);
    //
    //            }];
    //        }];
    //    }];
    
    
}

-(UIButton *)backView{
    if (!_backView) {
        _backView = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backView.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.5];
        [_backView addSubview:self.listTableView];
        [_backView bk_addEventHandler:^(id sender) {
            [self hidebackView];
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _backView;
}

-(UITableView *)listTableView{
    if (!_listTableView) {
        
        NSArray *arr = self.sectionArray[0][@"list"];
        NSInteger a = arr.count;
        float hei = a*76.f;
        if (hei> SCREEN_HEIGHT - SafeAreaTopHeight -60) {
            hei = SCREEN_HEIGHT - SafeAreaTopHeight -60;
        }
        
        _listTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-hei-60 , SCREEN_WIDTH, hei) style:UITableViewStylePlain];
        _listTableView.tag = 10001;
        _listTableView.backgroundColor =[UIColor whiteColor];
        [_listTableView setDelegate:self];
        [_listTableView setDataSource:self];
        [_listTableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:kCellId];
        [_listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _listTableView;
}

- (void)hidebackView
{
    [_backView removeFromSuperview];
    _backView = nil;
    [_listTableView removeFromSuperview];
    _listTableView = nil;
    [self.sectionArray removeAllObjects];
    
}


#pragma OrderFoodDetailHorizonScrollCellDelegate
-(void)horizonScrollAddNum:(mercGoodsInfoResponseSubListModel *)subListModel{
//    self.count ++;
//    self.moneyStr =[self.moneyStr addAmt:subListModel.price];
    [self requestAddGoodsCache:subListModel];
//    [self.footChargeView setCount:self.count andMoney:self.moneyStr];
}
-(void)horizonScrollSubNum:(mercGoodsInfoResponseSubListModel *)subListModel {
//    if (self.count >0) {
//        self.count--;
//        self.moneyStr =[self.moneyStr subtractAmt:subListModel.price];
//    }
    [self requestAddGoodsCache:subListModel];
//    [self.footChargeView setCount:self.count andMoney:self.moneyStr];
}
-(void)didSelectCell:(mercGoodsInfoResponseSubListModel *)subListModel {
    OrderFoodMerchantProductInfoVC *detailVC =[[OrderFoodMerchantProductInfoVC alloc]init];
    detailVC.mercResponseModel =self.mercResponseModel;
    [detailVC setSubListModel:subListModel];
    detailVC.count =[subListModel.goodsNum integerValue];
    [self.navigationController pushViewController:detailVC animated:YES pushType:NavigationPushCorver];
}
#pragma subListCellDelegate
-(void)leftSelect{
    [self requestMercGoodsInfo];
}
-(void)rightSelectAdd:(mercGoodsInfoResponseSubListModel *)subListModel {
//     self.count ++;
//     self.moneyStr =[self.moneyStr addAmt:subListModel.price];
     [self requestAddGoodsCache:subListModel];
//     [self.footChargeView setCount:self.count andMoney:self.moneyStr];
}
-(void)rightSelectSub:(mercGoodsInfoResponseSubListModel *)subListModel {
//    if (self.count >0) {
//        self.count--;
//        self.moneyStr =[self.moneyStr subtractAmt:subListModel.price];
//    }
    [self requestAddGoodsCache:subListModel];
//    [self.footChargeView setCount:self.count andMoney:self.moneyStr];
}
-(void)rightJumpAction:(mercGoodsInfoResponseSubListModel *)subListModel{

   OrderFoodMerchantProductInfoVC *detailVC =[[OrderFoodMerchantProductInfoVC alloc]init];
    [detailVC setSubListModel:subListModel];
    detailVC.mercResponseModel =self.mercResponseModel;
    detailVC.count =[subListModel.goodsNum integerValue];
    [self.navigationController pushViewController:detailVC animated:YES pushType:NavigationPushCorver];
}


#pragma 单个商品每次加减触发提交
-(void)requestAddGoodsCache:(mercGoodsInfoResponseSubListModel *)subListModel{
    [self showLoadingWithMessage:@""];
    addGoodsCacheRequestModel *requestModel =[[addGoodsCacheRequestModel alloc]init];
    requestModel.mercId =self.mercResponseModel.mercid;
    requestModel.comId =MyUser.comInfoUid;
    requestModel.goodsId =subListModel.goodsId;
    requestModel.goodsNum =subListModel.goodsNum;
    
    NSLog(@"%@",[requestModel keyValues]);
    WEAKSELF
    [NetworkClient RequestWithParameters:[requestModel keyValues] withUrl:BASE_URLWith(AddGoodsCacheHttp) needToken:YES success:^(id responseObject) {
        [self hideHud];
        NSLog(@"%@",responseObject);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([@"2000" isEqualToString:codeStr]) {
            NSDictionary *dataDic = responseObject[@"data"];
            weakSelf.dataDicF = dataDic;
            [self requestMercGoodsInfo];
        } else {
            [self showHint:responseObject[@"msg"]];
        }
     
        
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
}


#pragma 商家店铺点单界面
-(void)requestMercGoodsInfo{
    [self showLoadingWithMessage:@""];
    mercGoodsInfoRequestModel *requestModel =[[mercGoodsInfoRequestModel alloc]init];
    requestModel.mercId =self.mercResponseModel.mercid;
    WEAKSELF
    [NetworkClient RequestWithParameters:[requestModel keyValues] withUrl:BASE_URLWith(MercGoodsInfoHttp) needToken:YES success:^(id responseObject) {
        [self hideHud];
        NSLog(@"%@",responseObject);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([@"2000" isEqualToString:codeStr]) {
            
           NSDictionary *dataDic = responseObject[@"data"];
            weakSelf.dataDicF = dataDic;
            NSDictionary *cacheInfo =dataDic[@"cacheInfo"];
            NSString *goodsNum =cacheInfo[@"goodsNum"];
            NSString *price =cacheInfo[@"price"];
            if (!ZFStrIsEmpty(goodsNum)) {
                weakSelf.count =[goodsNum integerValue];
            }else{
                weakSelf.count =0;
            }
            if (!ZFStrIsEmpty(price)) {
                weakSelf.moneyStr =price;
            }else{
                weakSelf.moneyStr =@"0.00";
            }
            [weakSelf.footChargeView setCount:weakSelf.count andMoney:weakSelf.moneyStr];
            [weakSelf.headView setMercInfoDic:dataDic[@"mercInfo"]];
            NSDictionary *hotDic =dataDic[@"hotList"];
            if(hotDic.count>0){
                NSArray *hotList =hotDic[@"list"];
                if (hotList.count>0) {
                    [weakSelf.subMenuCell setHotList:hotDic[@"list"]];
                    weakSelf.isHaveHotData =YES;//招牌美味是否有数据
                }else{
                    weakSelf.isHaveHotData =NO;//招牌美味是否有数据
                }
                
            }
            NSArray *categoryList =dataDic[@"otherList"];
            if (categoryList.count>0) {
                 weakSelf.subCell.categoryList =dataDic[@"otherList"];
            }
            [weakSelf.subMenuCell reloadData];
            [weakSelf.mainTableView reloadData];
            [weakSelf.subCell reloadData];
        }
        
    } failure:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
}


#pragma mark -
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isDragging = YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentYoffset = scrollView.contentOffset.y;
    if (_isDragging) {
        if (contentYoffset > 64) {
            self.navV.alpha = 1;
//            [self bringSubView];

        }else if (contentYoffset < 64 && contentYoffset > 0){
            float navAlpha = contentYoffset / 20;
            self.navV.alpha = navAlpha;
//            if (navAlpha > 0.6) {
//                [self bringSubView];
//            }
        }else if (contentYoffset <= 0){
//            [self.navV removeShadow];
            self.navV.alpha = 0;

        }
    }
}


-(UIButton *)backbtn{
    if (!_backbtn) {
        _backbtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _backbtn.backgroundColor = [UIColor clearColor];
        [_backbtn bk_addEventHandler:^(id sender) {
            
            [self backAction];

        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _backbtn;
}

-(UIButton *)backbtn1{
    if (!_backbtn1) {
        _backbtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
        [_backbtn1 setBackgroundImage:[UIImage imageNamed:@"backWhite"] forState:UIControlStateNormal];
    }
    return _backbtn1;
}

-(UIButton *)shareImg{
    
    if (!_shareImg) {
        _shareImg = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareImg setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        [_shareImg addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareImg;
    
}

- (UIView *)navV
{
    if (!_navV) {
        _navV = [[UIView alloc] init];
        _navV.backgroundColor = CS_Color_BackZhuti;
        _navV.alpha = 0.f;
    }
    return _navV;
}


@end
