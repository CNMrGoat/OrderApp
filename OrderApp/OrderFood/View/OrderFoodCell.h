//
//  OrderFoodCell.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderFoodModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderFoodCell : UITableViewCell
@property (nonatomic ,strong) orderMercListResponseModel *listModel;
@end

NS_ASSUME_NONNULL_END
