//
//  OrderFinishDetailFootView.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/28.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderFinishDetailFootView : UITableViewHeaderFooterView

+ (instancetype)orderFooterViewTableView:(UITableView *)tableView;

@property(strong,nonatomic)OrderFinishDFootModel *orderFinishDFootModel;//订单数据模型
@property(strong,nonatomic)UILabel *lineLable;
@property(strong,nonatomic)UILabel *markLable;
@property(strong,nonatomic)UILabel *timeLable;
@property(strong,nonatomic)UILabel *confirmTimeLab;
@property(strong,nonatomic)UILabel *finishTimeLab;

@end

NS_ASSUME_NONNULL_END
