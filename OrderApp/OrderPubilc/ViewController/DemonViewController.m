//
//  DemonViewController.m
//  CSDirectBank
//
//  Created by 彭小坚 on 15/8/14.
//  Copyright (c) 2015年 彭小坚. All rights reserved.
//

#import "DemonViewController.h"

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
    
}

- (void)actionBack /**<返回方法*/
{
    [self.navigationController setCanGestureBack:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
