//
//  OrderFoodDetailHorizonScrollCell.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol OrderFoodDetailHorizonScrollCellDelegate <NSObject>

-(void)horizonScrollCountNum:(NSInteger)count andMoney:(NSString *)moneyStr;

@end

@interface OrderFoodDetailHorizonScrollCell : UITableViewCell
@property(nonatomic ,copy)NSArray *hotList;
@property(nonatomic ,weak)id<OrderFoodDetailHorizonScrollCellDelegate>localDelegate;
-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
