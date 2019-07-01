//
//  OrderCarFootView.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderFootView : UITableViewHeaderFooterView

+ (instancetype)orderFooterViewTableView:(UITableView *)tableView;

@property(strong,nonatomic)OrderFootModel *orderFootModel;//订单数据模型

@property(strong,nonatomic)UILabel *lineLable;
@property(strong,nonatomic)UILabel *markLable;
@property(strong,nonatomic)UILabel *amountLable;

@property(strong,nonatomic)UIButton *totalBtn;

@property(strong,nonatomic)UILabel *line2Lable;

@end

NS_ASSUME_NONNULL_END
