//
//  OrderFoodProductInfoHeadView.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/8.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderFoodModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol  OrderFoodProductInfoHeadViewDelegate<NSObject>

-(void)backAction;//导航栏回退
-(void)shareAction;//分享


@end
@interface OrderFoodProductInfoHeadView : UIView
@property(nonatomic ,weak)id<OrderFoodProductInfoHeadViewDelegate>localDelegate;
@property (nonatomic, strong)mercGoodsInfoResponseSubListModel *subListModel;
@end

NS_ASSUME_NONNULL_END
