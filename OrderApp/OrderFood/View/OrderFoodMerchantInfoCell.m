//
//  OrderFoodMerchantInfoCell.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/8.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodMerchantInfoCell.h"
@interface OrderFoodMerchantInfoCell()
@property (nonatomic, strong)UILabel *merchantLabel;
@property (nonatomic, strong)UILabel *infoLabel;

@end

@implementation OrderFoodMerchantInfoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

-(void)addView{
    
    [self makeUpConstriant];
}
-(void)makeUpConstriant{
    
}

@end
