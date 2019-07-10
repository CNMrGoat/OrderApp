//
//  OrderFoodDetailHeadView.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  OrderFoodDetailHeadViewDelegate<NSObject>

-(void)backAction;//导航栏回退
-(void)shareAction;//分享
-(void)jumpAction;//跳转详情

@end

@interface OrderFoodDetailHeadView : UIView
@property (nonatomic, copy)NSDictionary *mercInfoDic;
@property (nonatomic ,strong) UILabel *notifyLabel;
@property(nonatomic ,weak)id<OrderFoodDetailHeadViewDelegate>localDelegate;
@end

NS_ASSUME_NONNULL_END
