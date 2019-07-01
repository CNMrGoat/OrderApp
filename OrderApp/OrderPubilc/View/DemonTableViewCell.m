//
//  DemonTableViewCell.m
//  HouseCommunity
//
//  Created by 彭小坚 on 15/11/5.
//  Copyright © 2015年 彭小坚. All rights reserved.
//

#import "DemonTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Extend.h"

@interface DemonTableViewCell()
{
    BOOL bottomLineIsDraw;
    CGFloat bottomDrawOriginX;
    UIColor *bottomLineColor;
    UIEdgeInsets bottomLineInsets;
    
    BOOL isDrawTopLine;
    CGFloat topDrawOriginX;
    UIColor *topLineColor;
    UIEdgeInsets topLineInsets;
}
@end

@implementation DemonTableViewCell
@synthesize rightIndicator = _rightIndicator;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor clearColor];
        self.opaque = YES;
        self.alpha = 1.0;
        [self.contentView addSubview:self.rightIndicator];
        [self initLineProperty];
        [self makeConstraits];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawBottomLine];
}

- (void)makeConstraits
{
    [self.rightIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.height.equalTo(@12);
        make.width.equalTo(@7);
        make.centerY.equalTo(self);
    }];
}

#pragma mark -
#pragma mark Private Method

- (void)initLineProperty
{
    bottomLineColor = [UIColor grayColor];
    bottomLineIsDraw = NO;
    bottomDrawOriginX = 10;
    
    isDrawTopLine = NO;
    topLineColor = [UIColor grayColor];
    topDrawOriginX = 0;
}

- (void)setDemonSeparatorStyle:(DemonTableViewCellSeparatorStyle)separatorStyle
{
    switch (separatorStyle)
    {
        case DemonTableViewCellSeparatorFull:
        {
            bottomDrawOriginX = 0;
        }
            break;
            
        case DemonTableViewCellSeparatorSystem:
        {
            bottomLineInsets = self.separatorInset;
        }
            break;
        case DemonTableViewCellSeparatorLeft:
        {
            bottomDrawOriginX = 10;
        }
            break;
    }
    [self setNeedsDisplay];
}


- (void)setTopLineStyle:(DemonTableViewCellSeparatorStyle)separatorStyle
{
    isDrawTopLine = YES;
    switch (separatorStyle)
    {
        case DemonTableViewCellSeparatorFull:
        {
            topDrawOriginX = 0;
        }
            break;
            
        case DemonTableViewCellSeparatorSystem:
        {
            topLineInsets = self.separatorInset;
        }
            break;
        case DemonTableViewCellSeparatorLeft:
        {
            topDrawOriginX = 10;
        }
            break;
    }
     [self setNeedsDisplay];
}

- (void)showCellIndicator:(BOOL)isShow
{
    self.rightIndicator.hidden = !isShow;
    [self setNeedsDisplay];
}

- (void)setSeparatorLineColor:(UIColor *)color
{
    bottomLineColor = color;
    [self setNeedsDisplay];
}

- (void)setSeparatorLineHide:(BOOL)isHide
{
    bottomLineColor = [UIColor clearColor];
    [self setNeedsDisplay];
}

- (void)setSeparatorLineLeft:(CGFloat)padding
{
    bottomDrawOriginX = padding;
    [self setNeedsDisplay];
}

- (void)setSeparatorLineInset:(UIEdgeInsets)inset
{
    bottomLineInsets = inset;
    [self setNeedsDisplay];
}

- (void)setTopSeparatorLineColor:(UIColor *)color/**<设置分割线的颜色*/
{
    topLineColor = color;
    [self setNeedsDisplay];
}

- (void)setTopSeparatorLineHide:(BOOL)isHide/**<隐藏或显示分割线*/
{
    topLineColor = [UIColor clearColor];
    [self setNeedsDisplay];
}

- (void)setTopSeparatorLineLeft:(CGFloat)padding/**<分割线左缩进*/
{
    topDrawOriginX = padding;
    [self setNeedsDisplay];
}

- (void)seToptSeparatorLineInset:(UIEdgeInsets)inset/**<分割线布局*/
{
    topLineInsets = inset;
    [self setNeedsDisplay];
}

- (void)drawBottomLine
{
//    if (bottomLineIsDraw) return;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,0.5);
    CGContextSetStrokeColorWithColor(context, bottomLineColor.CGColor);
    CGContextMoveToPoint(context,bottomDrawOriginX,self.height);
    CGContextAddLineToPoint(context,self.width-bottomLineInsets.right,self.height);
    
    if (isDrawTopLine)
    {
        CGContextMoveToPoint(context,0,0);
        CGContextAddLineToPoint(context,self.width-bottomLineInsets.right,0);
    }
    
    CGContextStrokePath(context);
//    bottomLineIsDraw = YES;
}

#pragma mark -
#pragma mark getter

- (UIImageView *)rightIndicator
{
    if (!_rightIndicator)
    {
        _rightIndicator = [[UIImageView alloc]init];
        _rightIndicator.backgroundColor = [UIColor clearColor];
        _rightIndicator.image = [UIImage imageNamed:@"arrowHead"];
        _rightIndicator.hidden = YES;
    }
    return _rightIndicator;
}
@end
