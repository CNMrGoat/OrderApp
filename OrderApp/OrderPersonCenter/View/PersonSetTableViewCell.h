//
//  PersonSetTableViewCell.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "DemonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonSetTableViewCell : DemonTableViewCell

@property(nonatomic,strong)UIView *lineV; /**< 线 */
@property(nonatomic,strong) UILabel *tilLabel;
@property(nonatomic,strong) UIImageView *headImgV;

@end

NS_ASSUME_NONNULL_END
