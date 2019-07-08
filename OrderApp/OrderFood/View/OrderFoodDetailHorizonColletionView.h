//
//  OrderFoodDetailHorizonColletionView.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol OrderFoodDetailHorizonColletionViewDelegate <NSObject>

-(void)colletionViewCountNum:(NSInteger)count andMoney:(NSString *)moneyStr;

@end
@interface OrderFoodDetailHorizonColletionView : UIView
@property (nonatomic ,weak) id<OrderFoodDetailHorizonColletionViewDelegate>LocalDelegate;
@end

NS_ASSUME_NONNULL_END
