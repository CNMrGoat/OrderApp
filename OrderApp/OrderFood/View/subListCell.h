//
//  subListCell.m
//
//
//  Created by on 2019/6/26.
//  Copyright © 2019年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderFoodModel.h"
#import "OrderCountNumView.h"
@protocol subListCellDelegate <NSObject>


-(void)leftSelect;//选择左边菜单

-(void)rightSelectAdd:(mercGoodsInfoResponseSubListModel*)subListModel
             andCount:(NSInteger)count
    OrderCountNumView:(OrderCountNumView *)numView ; //选择右边菜单统计个数
-(void)rightSelectSub:(mercGoodsInfoResponseSubListModel *)subListModel
             andCount:(NSInteger)count
    OrderCountNumView:(OrderCountNumView *)numView ;//选择右边菜单统计个数

-(void)rightJumpAction:(mercGoodsInfoResponseSubListModel *)subListModel andCount:(NSInteger)count OrderCountNumView:(OrderCountNumView *)numView;
@end

@interface subListCell : UITableViewCell
@property (nonatomic, weak)id<subListCellDelegate>LocalDelegate;
@property (nonatomic, copy)NSArray *categoryList;

-(void)reloadData;
@end
