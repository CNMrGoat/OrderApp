//
//  OrderFoodModel.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/7.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface OrderFoodModel : NSObject

@end

#pragma 点餐商家列表
@interface orderMercListRequestModel : NSObject

@property (nonatomic, assign) NSInteger page;//第几页

@property (nonatomic, assign) NSInteger pageSize;//每页数量

@end

@interface orderMercListResponseModel : NSObject

@end

#pragma 商家店铺点餐界面
@interface mercGoodsInfoRequestModel : NSObject

@property (nonatomic ,copy) NSString *mercId;//商户id

@end

@interface mercGoodsInfoResponseModel : NSObject


@end
NS_ASSUME_NONNULL_END
