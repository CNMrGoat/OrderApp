//
//  UIView+Extend.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extend)

@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGSize size;

@property (nonatomic,assign) CGFloat centerX;

@property (nonatomic,assign) CGFloat centerY;

-(void)setX:(CGFloat)x;
-(CGFloat)x;
-(void)setY:(CGFloat)y;
-(CGFloat)y;
-(void)setWidth:(CGFloat)width;
-(CGFloat)width;
-(void)setHeight:(CGFloat)height;
-(CGFloat)height;
-(void)setSize:(CGSize)size;
-(CGSize)size;
-(CGFloat)centerX;
-(void)setCenterX:(CGFloat)centerX;
-(CGFloat)centerY;
-(void)setCenterY:(CGFloat)centerY;

/** 添加边框:四边 */
- (void)border:(UIColor *)color width:(CGFloat)width CornerRadius:(CGFloat)radius;
/** 添加边框:四边 默认4*/
- (void)border:(UIColor *)color width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
