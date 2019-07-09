//
//  CancelViewController.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/28.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "DemonViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^CallBackBlcok)(void);
@interface CancelViewController : DemonViewController

@property (nonatomic, copy) NSString *orderNum;//单号
@property (nonatomic,copy)CallBackBlcok callBackBlock;

@end

NS_ASSUME_NONNULL_END
