/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)showLoadingWithMessage:(NSString *)Message;
- (void)showLoadingWithMessage:(NSString *)Message InView:(UIView *)view;
- (void)showLoadingWithMessage:(NSString *)Message InView:(UIView *)view yOffset:(float)yOffset;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

/**根据字符串生成控制器并跳转PUSH*/
- (void)pushWithControllerName:(NSString *)controllerName;

/**webView图片自适应并返回内容高度*/
- (CGFloat)webViewResizeImg:(UIWebView *)webView;
@end
