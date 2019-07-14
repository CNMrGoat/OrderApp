//
//  DemonViewController.m
//  CSDirectBank
//
//  Created by 彭小坚 on 15/8/14.
//  Copyright (c) 2015年 彭小坚. All rights reserved.
//

#import "DemonViewController.h"
#import "LoginService.h"
@implementation DemonViewController

#pragma mark -
#pragma mark life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = CS_Color_BackGroundGray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToLogin) name:@"loginOut" object:nil];
    
}

- (void)goToLogin {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self showHint:@"您的账号有风险，建议更改密码"];

}

- (void)actionBack /**<返回方法*/
{
    [self.navigationController setCanGestureBack:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loginOut" object:nil];
    self.navigationController.navigationBarHidden = YES;
}

@end
