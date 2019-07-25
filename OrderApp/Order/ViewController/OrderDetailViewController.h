//
//  OrderCarDetailViewController.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "DemonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailViewController : DemonViewController

@property (nonatomic, copy) NSString *orderNum;//单号
@property (nonatomic, copy) NSString *sendTime;//送达时间
@property (nonatomic, copy) NSString *mercId;//送达时间

@end

NS_ASSUME_NONNULL_END
