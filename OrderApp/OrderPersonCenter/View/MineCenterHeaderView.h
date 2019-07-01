//
//  MineCenterHeaderView.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MineCenterHeadViewDelegate <NSObject>

- (void)headViewAction; /**< 个人信息点击方法 */

@end

NS_ASSUME_NONNULL_BEGIN

@interface MineCenterHeaderView : UIView

@property (nonatomic, weak) id<MineCenterHeadViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
