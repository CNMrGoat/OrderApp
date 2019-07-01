//
//  OrderCarHeadView.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol OrderHeadViewDelegate <NSObject>

- (void)headViewAddressActionWithTag:(NSInteger)i; /**< 地点点击方法 */

@end

@interface OrderHeadView : UITableViewHeaderFooterView

+ (instancetype)orderHeaderViewTableView:(UITableView *)tableView;

@property(strong,nonatomic)OrderHeadModel *orderHeadModel;//订单数据模型
@property (nonatomic, weak) id<OrderHeadViewDelegate> delegate;

@property(strong,nonatomic)UILabel *orderNumLab;
@property(strong,nonatomic)UILabel *orderStateLab;
@property(strong,nonatomic)UILabel *orderTimeLab;
@property(strong,nonatomic)UILabel *marketNameLable;
@property(strong,nonatomic)UIButton *deleteBtn;

@end





NS_ASSUME_NONNULL_END
