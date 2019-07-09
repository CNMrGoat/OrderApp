//
//  subListCell.m
//
//
//  Created by on 2019/6/26.
//  Copyright © 2019年 . All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol subListCellDelegate <NSObject>


-(void)leftSelect;//选择左边菜单

-(void)rightSelect:(NSInteger)count andMoney:(NSString *)money;//选择右边菜单统计个数

-(void)rightJumpAction;
@end

@interface subListCell : UITableViewCell
@property (nonatomic, weak)id<subListCellDelegate>LocalDelegate;
@end
