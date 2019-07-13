//
//  OrderCountNumView.h
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol OrderCountNumViewDelegate <NSObject>

-(void)addNum;
-(void)subNum;

@end
@interface OrderCountNumView : UIView
@property(nonatomic, weak)id<OrderCountNumViewDelegate>localDelegate;
-(void)setNum:(NSInteger)count;
@property(nonatomic ,assign)NSInteger count;
@end

NS_ASSUME_NONNULL_END
