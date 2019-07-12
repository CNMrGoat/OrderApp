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

@property(strong,nonatomic)UILabel *addressLab;
@property(strong,nonatomic)UILabel *nameLab;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *timeLab;
@property(strong,nonatomic)UILabel *lineLab;
@property(strong,nonatomic)UILabel *orderNameLab;

@end

NS_ASSUME_NONNULL_END
