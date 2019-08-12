//
//  LoginService.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "LoginService.h"
#import "PasswordViewController.h"
@interface LoginService ()
@property (nonatomic, retain) id loginSuccessObserver;
@property (nonatomic, retain) id loginCancelObserver;

@end

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
        if ([sender isMemberOfClass:[PasswordViewController class]] || [sender.presentedViewController isMemberOfClass:[PasswordViewController class]]) {
            return;
        } else {
            NSArray *viewControllers = sender.navigationController.viewControllers;
            UIViewController *rootViewController = viewControllers.firstObject;
            if ([rootViewController isMemberOfClass:[PasswordViewController class]]) {
                [sender.navigationController popToRootViewControllerAnimated:YES];
            } else {
                PasswordViewController *vc = [[PasswordViewController alloc] init];
                DemonNavigationController *navVC = [[DemonNavigationController alloc] initWithRootViewController:vc];
                __block typeof(sender) tmpSender = sender;
                [tmpSender presentViewController:navVC animated:YES completion:^{
                    
                    self.loginSuccessObserver = [[NSNotificationCenter defaultCenter] addObserverForName:kLoginSuccessNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                        [[NSNotificationCenter defaultCenter] removeObserver:self.loginSuccessObserver name:kLoginSuccessNotification object:nil];
                        [[NSNotificationCenter defaultCenter] removeObserver:self.loginCancelObserver name:kLoginCancelNotification object:nil];
                        
                        [self notify:tmpSender loginSuccess:note block:successBlock];
                        tmpSender = nil;
                    }];
                    self.loginCancelObserver = [[NSNotificationCenter defaultCenter] addObserverForName:kLoginCancelNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                        [[NSNotificationCenter defaultCenter] removeObserver:self.loginSuccessObserver name:kLoginSuccessNotification object:nil];
                        [[NSNotificationCenter defaultCenter] removeObserver:self.loginCancelObserver name:kLoginCancelNotification object:nil];
                        
                        [self notify:tmpSender loginCancel:note block:cancelBlock];
                        tmpSender = nil;
                    }];
                    
                }];
            }
        }
    });
}


#pragma mark -
#pragma mark Private Methods

- (void)notify:(UIViewController *)sender loginSuccess:(NSNotification *)notification block:(LoginSuccessBlock)successBlock
{
    [sender dismissViewControllerAnimated:YES completion:^{

        [sender.navigationController popToRootViewControllerAnimated:NO];

    }];
}

- (void)notify:(UIViewController *)sender loginCancel:(NSNotification *)notification block:(LoginCancelBlock)cancelBlock
{
    [sender dismissViewControllerAnimated:YES completion:^{
        if (cancelBlock) {
            cancelBlock();
        }
    }];
}

- (void)logout:(LogoutCompletionBlock)completionBlock
{

    if (completionBlock) {
        completionBlock();
    }
}

@end
