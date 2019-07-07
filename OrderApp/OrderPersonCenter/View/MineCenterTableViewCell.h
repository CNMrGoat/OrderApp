//
//  MineCenterTableViewCell.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineCenterTableViewCell : DemonTableViewCell

@property(nonatomic,strong)UIView *lineV; /**< 线 */

@property(nonatomic,strong)UILabel *moneyLab; /**< 钱 */

@end

NS_ASSUME_NONNULL_END
