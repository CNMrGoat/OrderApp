//
//  LoginService.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^LoginSuccessBlock)(void);
typedef void (^LoginCancelBlock)(void);
typedef void (^LogoutCompletionBlock)(void);

@interface LoginService : NSObject

+ (instancetype)sharedInstance;

/**
 *  普通登录
 *
 *  @param sender       当前的viewcontroller
 *  @param successBlock 登录成功的block
 *  @param cancelBlock  登录取消的block
 */
- (void)login:(UIViewController *)sender
 successBlock:(LoginSuccessBlock)successBlock
  cancelBlock:(LoginCancelBlock)cancelBlock;

/**
 *  退出
 *
 *  @param completionBlock 退出完成的block
 */
- (void)logout:(LogoutCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
