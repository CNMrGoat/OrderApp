//
//  FindPwdViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/28.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "FindPwdViewController.h"
#import "UIButton+Extend.h"
@interface FindPwdViewController ()

@property (nonatomic, strong) UITextField *phnoeField;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UITextField *yanZMField;
@property (nonatomic, strong) UIButton *yanZMBtn;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UITextField *mMField;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation FindPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找回密码";
    [self addView];
}

- (void)addView {

    [self.view addSubview:self.phnoeField];
    [self.view addSubview:self.lab2];
    [self.view addSubview:self.yanZMField];
    [self.view addSubview:self.yanZMBtn];
    [self.view addSubview:self.lab3];
    [self.view addSubview:self.mMField];
    [self.view addSubview:self.lab4];
    [self.view addSubview:self.loginBtn];

    
    [self makeUpconstraint];
    
    
}

#pragma mark -
#pragma mark getter



- (UITextField *)phnoeField
{
    if (!_phnoeField) {
        _phnoeField = [[UITextField alloc] init];
        _phnoeField.textColor = CS_Color_DeepBlack;
        _phnoeField.font = Demon_16_Font ;
        _phnoeField.placeholder = @"请输入手机号";
        
    }
    return _phnoeField;
}

- (UILabel *)lab2
{
    if (!_lab2) {
        _lab2 = [[UILabel alloc] init];
        _lab2.backgroundColor = CS_Color_LightGray;
    }
    return _lab2;
}



- (UITextField *)yanZMField
{
    if (!_yanZMField) {
        _yanZMField = [[UITextField alloc] init];
        _yanZMField.textColor = CS_Color_DeepBlack;
        _yanZMField.font = Demon_16_Font ;
        _yanZMField.placeholder = @"请输入验证码";
        
    }
    return _yanZMField;
}


- (UIButton *)yanZMBtn
{
    if (!_yanZMBtn) {
        _yanZMBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yanZMBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _yanZMBtn.titleLabel.font = Demon_14_Font;
        [_yanZMBtn setTitleColor:CS_Color_BackZhuti forState:UIControlStateNormal];
        [_yanZMBtn addTarget:self action:@selector(yanZMBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_yanZMBtn border:CS_Color_BackZhuti width:0.8];
    }
    return _yanZMBtn;
}


- (UILabel *)lab3
{
    if (!_lab3) {
        _lab3 = [[UILabel alloc] init];
        _lab3.backgroundColor = CS_Color_LightGray;
    }
    return _lab3;
}

- (UITextField *)mMField
{
    if (!_mMField) {
        _mMField = [[UITextField alloc] init];
        _mMField.textColor = CS_Color_DeepBlack;
        _mMField.font = Demon_16_Font ;
        _mMField.placeholder = @"请输入新密码";
        
    }
    return _mMField;
}

- (UILabel *)lab4
{
    if (!_lab4) {
        _lab4 = [[UILabel alloc] init];
        _lab4.backgroundColor = CS_Color_LightGray;
    }
    return _lab4;
}


- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = CS_Color_BackZhuti;
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_loginBtn border:CS_Color_BackZhuti width:0.8];
    }
    return _loginBtn;
}




#pragma mark -
#pragma mark 约束适配
- (void)makeUpconstraint {
    

    
    [self.phnoeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(SafeAreaBottomHeight +30);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-15);
    }];
    
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.phnoeField );
        make.top.mas_equalTo(self.phnoeField.mas_bottom).offset(6);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [self.yanZMField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.height.mas_equalTo(self.yanZMBtn);
        make.right.mas_equalTo(self.yanZMBtn.mas_left);
    }];
    
    
    
    [self.yanZMBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.lab2.mas_bottom).offset(15);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(90);
    }];
    
    
    
    
    [self.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.yanZMField );
        make.top.mas_equalTo(self.yanZMField.mas_bottom).offset(6);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.mMField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.lab3.mas_bottom).offset(15);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-15);
    }];
    
    [self.lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.phnoeField );
        make.top.mas_equalTo(self.mMField.mas_bottom).offset(6);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.width.mas_equalTo(self.lab2);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.lab4.mas_bottom).offset(30);
    }];
    

    
}

#pragma mark -
#pragma mark 点击事件
- (void)yanZMBtnAction {
    
    [self.yanZMBtn startWithSecondTime:59 title:@"获取验证码"  countDownTitle:@"s" mainColor:CS_Color_BackGroundGray countColor:[UIColor lightGrayColor]];
    
}

- (void)loginBtnAction {
    
    
}

@end
