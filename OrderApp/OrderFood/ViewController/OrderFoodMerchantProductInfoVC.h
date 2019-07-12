//
//  OrderFoodMerchantProductInfoVC.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/8.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "DemonViewController.h"
#import "OrderFoodModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^OrderFoodMerchantProductInfoBlock)(NSInteger count,BOOL isSub,BOOL isAdd,mercGoodsInfoResponseSubListModel *subListModel);

@interface OrderFoodMerchantProductInfoVC : DemonViewController
@property (nonatomic, strong)OrderFoodMerchantProductInfoBlock localBlock;
@property (nonatomic, strong)mercGoodsInfoResponseSubListModel *subListModel;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic ,strong) orderMercListResponseModel *mercResponseModel;
@end

NS_ASSUME_NONNULL_END
