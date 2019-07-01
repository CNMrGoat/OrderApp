//
//  UIColor+Extend.h
//  CSDirectBank
//
//  Created by 彭小坚 on 15/7/13.
//  Copyright (c) 2015年 lyx. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromHex(HexValue) ([UIColor colorWithHex:HexValue])/**<转换16进制颜色*/

#define UI_ColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a] /**<RGB颜色设置*/

@interface UIColor (Extend)

/*!
 *  @author 彭小坚, 15-08-07 10:08:54
 *
 *  @brief  16进制获取颜色
 *
 *  @param hex  16进制颜色值
 *
 *  @return 颜色
 *
 *  @since 2.8.0
 */
+ (UIColor *) colorWithHex:(unsigned int)hex;

/*!
 *  @author 彭小坚, 15-08-07 10:08:21
 *
 *  @brief  16进制获取颜色，并且设置颜色透明度
 *
 *  @param hex   16进制颜色值
 *  @param alpha 颜色透明度
 *
 *  @return 颜色
 *
 *  @since 2.8.0
 */
+ (UIColor *) colorWithHex:(unsigned int)hex
                     alpha:(CGFloat)alpha;

/*!
 *  @author 彭小坚, 15-08-07 10:08:25
 *
 *  @brief  随机获取颜色
 *
 *  @return 颜色
 *
 *  @since 2.8.0
 */
+ (UIColor *) randomColor;

/*!
 *  @author 谭海涛, 17-04-10 12:52:05
 *
 *  @brief  字符串获取颜(例如0xffffff,#ffffff,ffffff)
 *
 *  @return 颜色
 *
 *  @since 1.0.0
 */
+ (UIColor *) colorWithHexString:(NSString *)color;
@end
