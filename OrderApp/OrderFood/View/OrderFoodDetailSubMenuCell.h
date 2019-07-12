//
//  OrderFoodDetailSubMenuCell.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderFoodModel.h"
#import "OrderCountNumView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol OrderFoodDetailSubMenuCellDelegate <NSObject>

-(void)addNum:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(OrderCountNumView *)numView;
-(void)subNum:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(OrderCountNumView *)numView;
@end

@interface OrderFoodDetailSubMenuCell : UITableViewCell
@property (nonatomic, weak ) id<OrderFoodDetailSubMenuCellDelegate>LocalDelegate;
@property (nonatomic, strong ) mercGoodsInfoResponseSubListModel *subListModel;
@property (nonatomic, strong)OrderCountNumView *countNumView;
@end

NS_ASSUME_NONNULL_END
