//
//  UIView+Extend.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "UIView+Extend.h"

@implementation UIView (Extend)
-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)x{
    return self.frame.origin.x;
}
-(CGFloat)y{
    return self.frame.origin.y;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(CGSize)size{
    return self.frame.size;
}

-(CGFloat)centerX{
    
    return self.center.x;
    
}
-(void)setCenterX:(CGFloat)centerX{
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}
-(CGFloat)centerY{
    return self.center.y;
}
-(void)setCenterY:(CGFloat)centerY{
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
    
}

/** 添加边框:四边 */
- (void)border:(UIColor *)color width:(CGFloat)width CornerRadius:(CGFloat)radius {
    if (radius == 0) {
        [self border:color width:width];
    } else {
        CALayer *layer = self.layer;
        if (color != nil) {
            layer.borderColor = color.CGColor;
        }
        layer.cornerRadius = radius;
        layer.masksToBounds = YES;
        layer.borderWidth = width;
    }
}

//添加边框
- (void)border:(UIColor *)color width:(CGFloat)width;
{
    CALayer *layer = self.layer;
    if (color != nil) {
        layer.borderColor = color.CGColor;
    }
    layer.cornerRadius = 4;
    layer.masksToBounds = YES;
    layer.borderWidth = width;
}

@end
