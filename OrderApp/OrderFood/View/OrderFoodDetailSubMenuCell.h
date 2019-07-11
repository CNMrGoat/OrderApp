//
//  OrderFoodDetailSubMenuCell.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderFoodModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol OrderFoodDetailSubMenuCellDelegate <NSObject>

-(void)addNum:(mercGoodsInfoResponseSubListModel *)subListModel;
-(void)subNum:(mercGoodsInfoResponseSubListModel *)subListModel;
@end

@interface OrderFoodDetailSubMenuCell : UITableViewCell
@property (nonatomic, weak ) id<OrderFoodDetailSubMenuCellDelegate>LocalDelegate;
@property (nonatomic, strong ) mercGoodsInfoResponseSubListModel *subListModel;
@end

NS_ASSUME_NONNULL_END
