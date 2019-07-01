//
//  OrderCarModel.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject

@end

@interface OrderHeadModel : NSObject


@property (nonatomic, strong) NSString *marketName;

@end

@interface OrderFootModel : NSObject

@property (nonatomic, strong) NSString *amount;

@end

@interface OrderDHeadModel : NSObject


@end

@interface OrderDFootModel : NSObject


@end

@interface OrderPayDFootModel : NSObject


@end


@interface OrderFinishDFootModel : NSObject


@end

NS_ASSUME_NONNULL_END
