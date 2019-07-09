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
@property (nonatomic, copy)NSString *mercid;
@property (nonatomic, copy)NSString *logo;
@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *contactOne;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *startTime;
@property (nonatomic, copy)NSString *endTime;
@property (nonatomic, copy)NSString *pic;
@end

#pragma 商家店铺点餐界面
@interface mercGoodsInfoRequestModel : NSObject

@property (nonatomic ,copy) NSString *mercId;//商户id

@end

@interface mercGoodsInfoResponseModel : NSObject
@property (nonatomic, copy)NSString *uid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *logo;
@property (nonatomic, copy)NSString *mobile;
@property (nonatomic, copy)NSString *contactOne;
@property (nonatomic, copy)NSString *contactTwo;
@property (nonatomic, copy)NSString *contactPerson;
@property (nonatomic, copy)NSString *contactArea;
@property (nonatomic, copy)NSString *startTime;
@property (nonatomic, copy)NSString *endTime;
@property (nonatomic, copy)NSString *ctime;
@property (nonatomic, copy)NSString *announcement;
@property (nonatomic, copy)NSString *pic;
@end

@interface mercGoodsInfoResponseCategoryModel : NSObject
@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSArray  *list;
@end

@interface mercGoodsInfoResponseSubListModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *pic;
@property (nonatomic, copy)NSString *inventory;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *marketPrice;
@property (nonatomic, copy)NSString *goodsNum;
@property (nonatomic, copy)NSString *goodsId;
@end
NS_ASSUME_NONNULL_END
