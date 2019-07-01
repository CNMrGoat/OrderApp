//
//  LoginService.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "LoginService.h"
#import "CodeLoginViewController.h"

@implementation LoginService

+ (instancetype)sharedInstance
{
    static LoginService *sharedInstance = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[LoginService alloc] init];
    });
    return sharedInstance;
}

- (void)login:(UIViewController *)sender
 successBlock:(LoginSuccessBlock)successBlock
  cancelBlock:(LoginCancelBlock)cancelBlock
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([sender isMemberOfClass:[CodeLoginViewController class]] || [sender.presentedViewController isMemberOfClass:[CodeLoginViewController class]]) {
            return;
        } else {
            NSArray *viewControllers = sender.navigationController.viewControllers;
            UIViewController *rootViewController = viewControllers.firstObject;
            if ([rootViewController isMemberOfClass:[CodeLoginViewController class]]) {
                [sender.navigationController popToRootViewControllerAnimated:YES];
            } else {
                CodeLoginViewController *vc = [[CodeLoginViewController alloc] init];
                DemonNavigationController *navVC = [[DemonNavigationController alloc] initWithRootViewController:vc];
                __block typeof(sender) tmpSender = sender;
                [tmpSender presentViewController:navVC animated:YES completion:^{
                    
                }];
            }
        }
    });
}

- (void)logout:(LogoutCompletionBlock)completionBlock
{

    if (completionBlock) {
        completionBlock();
    }
}

@end
