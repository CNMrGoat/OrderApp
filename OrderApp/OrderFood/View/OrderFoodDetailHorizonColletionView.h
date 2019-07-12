//
//  OrderFoodDetailHorizonColletionView.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderFoodModel.h"
#import "OrderCountNumView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol OrderFoodDetailHorizonColletionViewDelegate <NSObject>

-(void)colletionViewAddNum:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(OrderCountNumView *)numView;

-(void)colletionViewSubNum:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(OrderCountNumView *)numView;

-(void)didSelectCell:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(OrderCountNumView *)numView;
@end
@interface OrderFoodDetailHorizonColletionView : UIView
@property(nonatomic ,copy)NSArray *hotList;
@property (nonatomic ,weak) id<OrderFoodDetailHorizonColletionViewDelegate>LocalDelegate;
-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
