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

-(void)addNum:(NSInteger)num OrderCountNumView:(id)numView;
-(void)subNum:(NSInteger)num OrderCountNumView:(id)numView;

@end
@interface OrderCountNumView : UIView
@property(nonatomic, weak)id<OrderCountNumViewDelegate>localDelegate;
-(void)setNum:(NSInteger)count;
@end

NS_ASSUME_NONNULL_END
