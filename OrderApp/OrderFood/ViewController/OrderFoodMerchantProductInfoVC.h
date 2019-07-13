//
//  OrderFoodMerchantProductInfoVC.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/8.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "DemonViewController.h"
#import "OrderFoodModel.h"
#import "OrderCountNumView.h"
NS_ASSUME_NONNULL_BEGIN


@interface OrderFoodMerchantProductInfoVC : DemonViewController
@property (nonatomic ,strong)orderMercListResponseModel *mercResponseModel;
@property (nonatomic, strong)mercGoodsInfoResponseSubListModel *subListModel;
@property (nonatomic, assign)NSInteger count;
@end

NS_ASSUME_NONNULL_END
