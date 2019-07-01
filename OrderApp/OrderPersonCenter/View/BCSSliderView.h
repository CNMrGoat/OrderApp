//
//  BCSSliderView.h
//  CSDirectBank
//
//  Created by 邹永进 on 16/9/5.
//  Copyright © 2016年 tim. All rights reserved.
//

#import <UIKit/UIKit.h>

/**<滑动点击筛选控件*/
@interface BCSSliderView: UIView
/**<滑块的名称数组*/
//@property (nonatomic, strong) NSArray *titleArray;

/**<当前被选中sliderBar中的按钮 可设置为0 1 2，默认为0*/
@property (nonatomic,assign)NSInteger whichIndex;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

/**<点击sliderBar某个按钮的回调*/
- (void)whichButtonClicked:(void(^)(UIButton *button,NSInteger index))blc;

@end
