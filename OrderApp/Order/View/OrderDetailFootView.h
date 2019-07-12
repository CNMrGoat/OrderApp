//
//  OrderCDetailFootView.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailFootView : UITableViewHeaderFooterView

+ (instancetype)orderFooterViewTableView:(UITableView *)tableView;


@property(strong,nonatomic)UILabel *amountLable;
@property(strong,nonatomic)UILabel *markLable;
@property(strong,nonatomic)UILabel *markDetialLable;
@property(strong,nonatomic)UILabel *lineLable;

@end

NS_ASSUME_NONNULL_END
