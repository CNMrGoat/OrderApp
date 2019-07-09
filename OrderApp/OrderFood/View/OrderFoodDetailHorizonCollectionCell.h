//
//  OrderFoodDetailHorizonCollectionCell.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderFoodModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol OrderFoodDetailHorizonCollectionCellDelegate <NSObject>

-(void)collectionCellCountNum:(NSInteger)count andMoney:(NSString *)moneyStr;

@end

@interface OrderFoodDetailHorizonCollectionCell : UICollectionViewCell
@property (nonatomic, strong)mercGoodsInfoResponseSubListModel *subListModel;
@property (nonatomic, weak)id<OrderFoodDetailHorizonCollectionCellDelegate>LocalDelegate;
@end

NS_ASSUME_NONNULL_END
