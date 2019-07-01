//
//  DemonTabbarItem.h
//  PerAcc
//
//  Created by tim on 15-3-28.
//  Copyright (c) 2015年 All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DemonTabbarItem : UIControl

@property (nonatomic,copy) NSString *normalImageName;
@property (nonatomic,copy) NSString *selectedImageName;
@property (nonatomic,strong) UIImageView *pointImageView;


/*!
 *
 *
 *  @brief  选中状态，YES为选中状态，NO为非选中状态
 *
 *  @since 3.0.1
 */
@property (nonatomic, assign) BOOL isSelected;

/*!
 *
 *
 *  @brief  初始化Tabbar的item
 *
 *  @param frame             item的frame
 *  @param normalImageName   非选中状态的图片名称
 *  @param selectedImageName 选中状态的按钮图片名称
 *  @param normalFontColor   非选中状态的字体颜色
 *  @param selectedFontColor 选中状态的字体颜色
 *  @param title             item的title
 *
 *  @return item
 *
 *  @since 3.0.1
 */

- (id)initWithFrame:(CGRect)frame
    normalImageName:(NSString *)normalImageName
  selectedImageNemd:(NSString *)selectedImageName
    normalFontColor:(UIColor *)normalFontColor
  selectedFontColor:(UIColor *)selectedFontColor
              title:(NSString *)title;

/**
 *  显示红点标记
 *
 *  @param flag 是否显示红点标记 yes:显示，no:隐藏
 */
- (void)showRedPointAtItem:(BOOL)flag;

/**
 *  更新网络图片
 *
 *  @param selected 选中状态，YES为选中状态，NO为非选中状态
 */
- (void)updateUrlImage:(BOOL)selected;

@end
