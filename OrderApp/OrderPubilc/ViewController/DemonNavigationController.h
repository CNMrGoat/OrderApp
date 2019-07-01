//
//  DemonNavigationController.h
//  CSDirectBank
//
//  Created by 彭小坚 on 15/8/14.
//  Copyright (c) 2015年 彭小坚. All rights reserved.
//

typedef NS_ENUM(NSUInteger, NavigationPushType)/**<Push动画类型*/
{
    NavigationPushNormal = 1,/**<系统默认类型*/
    NavigationPushLinkage = 2,/**<联动类型*/
    NavigationPushCorver = 3,/**<覆盖*/
};

typedef NS_ENUM(NSUInteger, NavigationPopType)/**<pop层级类型*/
{
    NavigationPopNormal = 1,/**<系统默认类型*/
    NavigationPopLinkage = 2 ,/**<联动类型*/
    NavigationPopCorver = 3,/**<覆盖*/
    NavigationPopToRoot = 4,/**<返回到根视图*/
    NavigationPopToIgnore =5 /**<不返回*/
};

#import <UIKit/UIKit.h>

/*!
 *  @author 彭小坚, 15-08-11 17:08:53
 *
 *  @brief  框架NavgationController封装
 *
 *  @since 1.0
 */
@interface DemonNavigationController : UINavigationController

@end


/*!
 *  @author 彭小坚, 15-08-22 22:08:20
 *
 *  @brief  封装的navigation类别，用于重载系统的Push方法，加入了自定义的push动画类型
 *
 *  @since 3.0.1
 */
@interface UINavigationController (Extend)

/*!
 *  @author 彭小坚, 15-08-12 16:08:42
 *
 *  @brief  VC 加载到下一界页面所使用的动画类型。默认为系统类型,开发人员可根据自己的业务特点决定使用哪种类型。
 *             当navigationBar在隐藏或者设置半透明时，建议使用覆盖的跳转动画方式。
 *
 *  @param viewController 继承系统默认
 *  @param animated       是否使用动画
 *  @param type           动画类型 1、系统默认动画  2、联动动画 3、覆盖遮罩
 *
 *  @since 1.0
 */
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                  pushType:(NavigationPushType)type;

/*!
 *  @author 彭小坚, 15-08-14 14:08:48
 *
 *  @brief  设置是否可以滑动返回
 *
 *  @since 3.0.1
 */

-(void)setCanGestureBack:(BOOL)boolValue;

/*!
 *  @author 彭小坚, 15-08-14 15:08:12
 *
 *  @brief  设置返回类型
 *
 *  @param NavigationPopType 返回类型 可参考 NavigationPopType;
 *
 *  @since 3.0.1
 */
-(void)setPopType:(NavigationPopType)type;

/**
 *  返回rootvc后，push到新vc
 *
 *  @param vc  目标控制器
 */
-(void)pushToVC:(UIViewController *)vc;

/*!
 *  @author 朱介伟, 16-01-19 13:01:11
 *
 *  @brief  用于回退到指定控制器类
 *
 *  @param VCClass  目的类
 *  @param animated 是否开启动画
 *
 *  @since 3.3.6
 */
- (void)popToVCClass:(Class)VCClass animated:(BOOL)animated;

/**
 *  去掉fromVc至pushVc 之间的视图
 *
 *  @param pushVc      pushVc 目标视图
 *  @param fromClass   fromClass 源视图
 *  @param animated    animated description
 */

- (void)pushToVC:(UIViewController *)pushVc fromClass:(Class)fromClass animated:(BOOL)animated;
/**
 *  去掉fromVc至pushVc 之间的视图
 *
 *  @param integer 指定向前删除几个视图
 *  @param animated animated description
 */
- (void)popToBeforeViewController:(NSInteger)integer animated:(BOOL)animated;

@end
