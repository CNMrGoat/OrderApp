//
//  RecordTableViewCell.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "DemonTableViewCell.h"
#import "OrderCenterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecordTableViewCell : DemonTableViewCell
@property(nonatomic,strong)WalletData *rechargeModel; /**<充值model*/
@property(nonatomic,strong)WalletData *consumeModel;


@end

NS_ASSUME_NONNULL_END
