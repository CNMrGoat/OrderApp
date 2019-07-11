//
//  OrderFoodDetailFootChargeView.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol OrderFoodDetailFootChargeViewDelegate <NSObject>

-(void)tomorrowToBuy;
-(void)todayToBuy;

@end

@interface OrderFoodDetailFootChargeView : UIView
@property(nonatomic, weak)id<OrderFoodDetailFootChargeViewDelegate>localDelegate;
-(void)setCount:(NSInteger)count andMoney:(NSString *)money;
@end

NS_ASSUME_NONNULL_END
