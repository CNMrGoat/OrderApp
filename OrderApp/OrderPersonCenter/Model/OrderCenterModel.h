//
//  OrderCenterModel.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface OrderheadVCenterModel : NSObject

@property(nonatomic,copy)NSString *headImgUrl;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *signature;

@end

@interface OrderRechargeModel : NSObject

@end

@interface OrderConsumeModel : NSObject

@end

NS_ASSUME_NONNULL_END
