//
//  ChangePasswordViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UIButton+Extend.h"

@interface ChangePasswordViewController ()


@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UITextField *yanZMField;
@property (nonatomic, strong) UIButton *yanZMBtn;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UITextField *xinMMField;
@property (nonatomic, strong) UILabel *lab5;
@property (nonatomic, strong) UIButton *finishBtn;


@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    [self addView];
}

- (void)addView {
    
    [self.view addSubview:self.lab1];
    [self.view addSubview:self.lab2];
    [self.view addSubview:self.yanZMField];
    [self.view addSubview:self.yanZMBtn];
    [self.view addSubview:self.lab3];
    [self.view addSubview:self.lab4];
    [self.view addSubview:self.xinMMField];
    [self.view addSubview:self.lab5];
    [self.view addSubview:self.finishBtn];
    
    [self makeUpconstraint];

}

#pragma mark -
#pragma mark getter

- (UILabel *)lab1
{
    if (!_lab1) {
        _lab1 = [[UILabel alloc] init];
        _lab1.textColor = CS_Color_MidGray;
        _lab1.font = Demon_13_Font;
        _lab1.text = @"验证码将发送到您的手机179****4567";

    }
    return _lab1;
}

- (UILabel *)lab2
{
    if (!_lab2) {
        _lab2 = [[UILabel alloc] init];
        _lab2.textColor = CS_Color_DeepBlack;
        _lab2.font = Demon_16_Font ;
        _lab2.text = @"验证码";
        
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

- (UILabel *)lab4
{
    if (!_lab4) {
        _lab4 = [[UILabel alloc] init];
        _lab4.textColor = CS_Color_DeepBlack;
        _lab4.font = Demon_16_Font ;
        _lab4.text = @"新密码";
        
    }
    return _lab4;
}

- (UITextField *)xinMMField
{
    if (!_xinMMField) {
        _xinMMField = [[UITextField alloc] init];
        _xinMMField.textColor = CS_Color_DeepBlack;
        _xinMMField.font = Demon_16_Font ;
        _xinMMField.placeholder = @"至少6位数密码";
        
    }
    return _xinMMField;
}

- (UILabel *)lab5
{
    if (!_lab5) {
        _lab5 = [[UILabel alloc] init];
        _lab5.backgroundColor = CS_Color_LightGray;
    }
    return _lab5;
}

- (UIButton *)finishBtn
{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishBtn setTitle:@"完  成" forState:UIControlStateNormal];
        _finishBtn.backgroundColor = CS_Color_BackZhuti;
        [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_finishBtn addTarget:self action:@selector(finishBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_finishBtn border:CS_Color_BackZhuti width:0.8];
    }
    return _finishBtn;
}


#pragma mark -
#pragma mark 约束适配
- (void)makeUpconstraint {
    
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(SafeAreaTopHeight +30);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(SCREEN_WIDTH -30);
    }];
    
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.lab1.mas_bottom).offset(30);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    [self.yanZMBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.height.mas_equalTo(self.lab2);
        make.width.mas_equalTo(90);
    }];
    
    
    [self.yanZMField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.top.height.mas_equalTo(self.lab2);
        make.right.mas_equalTo(self.yanZMBtn.mas_left);
    }];
    
    [self.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lab2);
        make.top.mas_equalTo(self.yanZMBtn.mas_bottom).offset(6);
        make.height.mas_equalTo(0.5);
        make.right.mas_equalTo(self.yanZMBtn);
    }];
    
    
    [self.lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.lab3.mas_bottom).offset(15);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    
    
    [self.xinMMField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.top.height.mas_equalTo(self.lab4);
        make.right.mas_equalTo(-15);
    }];
    
    [self.lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.mas_equalTo(self.lab3);
        make.top.mas_equalTo(self.xinMMField.mas_bottom).offset(6);
    }];
    
    
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.width.mas_equalTo(self.lab5);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.lab5.mas_bottom).offset(30);
    }];
    
}

#pragma mark -
#pragma mark 点击事件
- (void)yanZMBtnAction {
    
    [self.yanZMBtn startWithSecondTime:59 title:@"获取验证码"  countDownTitle:@"s" mainColor:CS_Color_BackGroundGray countColor:[UIColor lightGrayColor]];
    
}

- (void)finishBtnAction {
    
}

@end
