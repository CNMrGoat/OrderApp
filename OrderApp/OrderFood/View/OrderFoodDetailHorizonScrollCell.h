//
//  OrderFoodDetailHorizonScrollCell.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderFoodModel.h"
#import "OrderCountNumView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol OrderFoodDetailHorizonScrollCellDelegate <NSObject>

-(void)horizonScrollAddNum:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(OrderCountNumView *)numView;

-(void)horizonScrollSubNum:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(OrderCountNumView *)numView;

-(void)didSelectCell:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(OrderCountNumView *)numView;
@end

@interface OrderFoodDetailHorizonScrollCell : UITableViewCell
@property(nonatomic ,copy)NSArray *hotList;
@property(nonatomic ,weak)id<OrderFoodDetailHorizonScrollCellDelegate>localDelegate;
@property(nonatomic, assign)NSInteger count;
-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
