//
//  BindphoneViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/28.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "BindphoneViewController.h"
#import "UIButton+Extend.h"

@interface BindphoneViewController ()

@property (nonatomic, strong) UITextField *phnoeField;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UITextField *yanZMField;
@property (nonatomic, strong) UIButton *yanZMBtn;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UIButton *finishBtn;
@property (nonatomic, strong) NSString *pwd;

@end

@implementation BindphoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"绑定手机号";
    self.pwd = @"";
    [self addView];
}

- (void)addView {
    
    [self.view addSubview:self.phnoeField];
    [self.view addSubview:self.lab2];
    [self.view addSubview:self.yanZMField];
    [self.view addSubview:self.yanZMBtn];
    [self.view addSubview:self.lab3];
    [self.view addSubview:self.finishBtn];
    
    
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
        _phnoeField.keyboardType = UIKeyboardTypeNumberPad;
        
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
    
   
    
    
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.width.mas_equalTo(self.lab2);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.lab3.mas_bottom).offset(30);
    }];
    
    
    
}

#pragma mark -
#pragma mark 点击事件
- (void)yanZMBtnAction {
    
    if ([self.phnoeField.text checkPhoneNumInput]) {
        [self.yanZMBtn startWithSecondTime:59 title:@"获取验证码"  countDownTitle:@"s" mainColor:CS_Color_BackGroundGray countColor:[UIColor lightGrayColor]];
        
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:self.phnoeField.text forKey:@"mobile"];
        [parameters setObject:@"BIND" forKey:@"type"];
        [parameters setObject:@"MEM" forKey:@"appType"];
        
        [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(SendCodeHttp) needToken:NO success:^(id responseObject) {
            
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
        [parameters setObject:self.openid forKey:@"openid"];
        [parameters setObject:self.phnoeField.text forKey:@"mobile"];
        [parameters setObject:self.yanZMField.text forKey:@"verifyCode"];
        [parameters setObject:self.pwd forKey:@"pwd"];
        
        [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(WxBindMobileHttp) needToken:NO success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            NSDictionary *dic = responseObject[@"data"];
            if ([@"2000" isEqualToString:codeStr]) {
                NSLog(@"登录成功");
                MyUser.comInfoMobile = [NSString stringWithFormat:@"%@",dic[@"comInfo"][@"mobile"]];
                MyUser.comInfoName = [NSString stringWithFormat:@"%@",dic[@"comInfo"][@"name"]];
                MyUser.comInfoUid = [NSString stringWithFormat:@"%@",dic[@"comInfo"][@"uid"]];
                MyUser.ctime = [NSString stringWithFormat:@"%@",dic[@"ctime"]];
                MyUser.headImgUrl = [NSString stringWithFormat:@"%@",dic[@"headImgUrl"]];
                MyUser.mobile = [NSString stringWithFormat:@"%@",dic[@"mobile"]];
                MyUser.nickName = [NSString stringWithFormat:@"%@",dic[@"nickName"]];
                MyUser.openid = [NSString stringWithFormat:@"%@",dic[@"openid"]];
                MyUser.signature = [NSString stringWithFormat:@"%@",dic[@"signature"]];
                MyUser.token = [NSString stringWithFormat:@"%@",dic[@"token"]];
                MyUser.uid = [NSString stringWithFormat:@"%@",dic[@"uid"]];
                MyUser.wallet = [NSString stringWithFormat:@"%@",dic[@"wallet"]];
                MyUser.isLogin = [NSString stringWithFormat:@"1"];
                [self postNotication];
            } else {
                [self showHint:responseObject[@"msg"]];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }
    
    
}

- (void)postNotication {
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:self userInfo:nil];
}

- (BOOL)checkContent {
    
    if (![self.phnoeField.text checkPhoneNumInput]) {
        
        [self showHint:@"手机号码不正确"];
        return NO;
    }
    
    
    if (self.yanZMField.text.length<3) {
        
        [self showHint:@"请输入正确的验证码"];
        return NO;
    }
    
    
    if ([self.yanZMField.text containStr:@" "]) {
        
        [self showHint:@"验证码不能包含空格" ];
        return NO;
    }
    
    
    return YES;
}

@end
