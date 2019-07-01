//
//  OrderCDetailHeadView.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailHeadView : UITableViewHeaderFooterView

+ (instancetype)orderHeaderViewTableView:(UITableView *)tableView;

@property(strong,nonatomic)OrderDHeadModel *orderDHeadModel;//订单数据模型

@end

NS_ASSUME_NONNULL_END
