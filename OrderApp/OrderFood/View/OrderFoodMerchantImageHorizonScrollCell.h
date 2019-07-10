//
//  OrderFoodDetailHorizonScrollCell.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface OrderFoodMerchantImageHorizonScrollCell : UITableViewCell


@property (nonatomic, strong) NSString *introduce;
@property (nonatomic, strong) NSString *pic;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithIntroduce:(NSString *)introduce  withPic:(NSString *)pic;

@end

NS_ASSUME_NONNULL_END
