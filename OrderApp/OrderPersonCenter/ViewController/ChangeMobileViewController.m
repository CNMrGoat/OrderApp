//
//  ChangeMobileViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/7/7.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "ChangeMobileViewController.h"
#import "UIButton+Extend.h"

@interface ChangeMobileViewController ()


@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UITextField *yanZMField;
@property (nonatomic, strong) UIButton *yanZMBtn;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UITextField *xinMMField;
@property (nonatomic, strong) UILabel *lab5;
@property (nonatomic, strong) UIButton *finishBtn;


@end

@implementation ChangeMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addView];
}

- (void)addView {
    
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


- (UILabel *)lab2
{
    if (!_lab2) {
        _lab2 = [[UILabel alloc] init];
        _lab2.textColor = CS_Color_DeepBlack;
        _lab2.font = Demon_16_Font ;
        if ([self.title isEqualToString:@"修改号码"]) {
            _lab2.text = @"手机号";
        } else {
            _lab2.text = @"新手机号";
        }
        
        
    }
    return _lab2;
}

- (UITextField *)yanZMField
{
    if (!_yanZMField) {
        _yanZMField = [[UITextField alloc] init];
        _yanZMField.textColor = CS_Color_DeepBlack;
        _yanZMField.font = Demon_16_Font ;
        _yanZMField.keyboardType =   UIKeyboardTypeNumberPad;
        
        if ([self.title isEqualToString:@"修改号码"]) {
            _yanZMField.placeholder = @"请输入手机号码";
        } else {
            _yanZMField.placeholder = @"请输入新号码";
        }
        
        _yanZMField.keyboardType = UIKeyboardTypeNumberPad;
        
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
        _lab4.text = @"验证码";
        
    }
    return _lab4;
}

- (UITextField *)xinMMField
{
    if (!_xinMMField) {
        _xinMMField = [[UITextField alloc] init];
        _xinMMField.textColor = CS_Color_DeepBlack;
        _xinMMField.font = Demon_16_Font ;
        _xinMMField.placeholder = @"请输入验证码";
        _xinMMField.keyboardType =   UIKeyboardTypeNumberPad;
        _xinMMField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
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
        if ([self.title isEqualToString:@"修改号码"]) {
           [_finishBtn setTitle:@"完  成" forState:UIControlStateNormal];
        } else {
           [_finishBtn setTitle:@"确认绑定" forState:UIControlStateNormal];
        }
        
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
    
    
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(SafeAreaTopHeight +15);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    [self.yanZMBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.height.mas_equalTo(self.lab2);
        make.width.mas_equalTo(90);
    }];
    
    
    [self.yanZMField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(85);
        make.height.mas_equalTo(self.lab2);
        make.centerY.mas_equalTo(self.lab2).offset(1);
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
        make.left.mas_equalTo(85);
        make.height.mas_equalTo(self.lab4);
        make.centerY.mas_equalTo(self.lab4).offset(1);
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
    
    if ([self.yanZMField.text checkPhoneNumInput]) {
        
        [self.yanZMBtn startWithSecondTime:59 title:@"获取验证码"  countDownTitle:@"s" mainColor:CS_Color_BackGroundGray countColor:[UIColor lightGrayColor]];
        
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:self.yanZMField.text forKey:@"mobile"];
        [parameters setObject:@"CHANGEMOBILE" forKey:@"type"];
        [parameters setObject:@"MEM" forKey:@"appType"];
        NSLog(@"%@",parameters);
        [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(SendCodeHttp) needToken:NO success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            NSDictionary *dic = (NSDictionary *)responseObject;
            [self showHint:dic[@"msg"]];
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    } else {
        
       [self showHint:@"手机号码不正确"];
    }

    
    
    
}

- (void)finishBtnAction {
    
    if ([self checkContent]) {
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:self.yanZMField.text forKey:@"newMobile"];
        [parameters setObject:self.xinMMField.text forKey:@"verifyCode"];
        
        NSLog(@"~~~~~%@",parameters);
        
        [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(ChangeMobileHttp) needToken:YES success:^(id responseObject) {
            
            NSLog(@"%@",responseObject);
            NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            [self showHint:responseObject[@"msg"]];
            if ([@"2000" isEqualToString:codeStr]) {
                MyUser.mobile = self.yanZMField.text;
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

- (BOOL)checkContent {
    
    if (![self.yanZMField.text checkPhoneNumInput]) {
        
        [self showHint:@"手机号码不正确"];
        return NO;
        
    }
    
    
    if (self.xinMMField.text.length<3) {
        
        [self showHint:@"请输入正确的验证码"];
        return NO;
    }
    
    
//    if (self.xinMMField.text.length > 5) {
//        [self showHint:@"密码不能大于15位!"];
//        return NO;
//    }
    
    
    if ([self.xinMMField.text containStr:@" "]) {
        
        [self showHint:@"验证码不能包含空格" ];
        return NO;
    }
    
    
    return YES;
}

@end
