//
//  OrderCarTableViewCell.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "DemonTableViewCell.h"
#import "OrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderTableViewCell : DemonTableViewCell

@property(strong,nonatomic) SunlistModel *sunlistModel;//订单数据模型

@end

NS_ASSUME_NONNULL_END
