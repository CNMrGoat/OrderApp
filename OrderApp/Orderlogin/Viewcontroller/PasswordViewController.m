//
//  PasswordViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/28.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "PasswordViewController.h"
#import "FindPwdViewController.h"
#import "BindphoneViewController.h"
#import <UMShare/UMShare.h>
#import "OrderLoginModel.h"

@interface PasswordViewController ()


@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UITextField *phnoeField;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UITextField *yanZMField;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *findPwdBtn;
@property (nonatomic, strong) UIButton *wxVCBtn;
@property (nonatomic, strong) UILabel *lab4;

@property (nonatomic, strong) wxLoginRequestModel *wxReqModel;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)addView {
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.phnoeField];
    [self.view addSubview:self.lab2];
    [self.view addSubview:self.yanZMField];
    [self.view addSubview:self.lab3];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.findPwdBtn];
    
    /**
     *  平台是否安装
     *
     *  @param platformType 平台类型 @see UMSocialPlatformType
     *
     *  @return YES 代表安装，NO 代表未安装
     *  @note 在判断QQ空间的App的时候，QQApi判断会出问题
     UMSocialPlatformType_Sina               = 0, //新浪
     UMSocialPlatformType_WechatSession      = 1, //微信聊天
     UMSocialPlatformType_QQ                 = 4,//QQ聊天页面
     
     */
    
    
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        [self.view addSubview:self.wxVCBtn];
        [self.view addSubview:self.lab4];
    }

    
    [self makeUpconstraint];
    
    
}

#pragma mark -
#pragma mark getter

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = Demon_24_Font;
        _titleLab.text = @"欢迎登录加餐啦";
        
    }
    return _titleLab;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = Demon_14_Font;
        [_cancelBtn setTitleColor:CS_Color_DeepGray forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

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
        _yanZMField.placeholder = @"请输入密码";
        _yanZMField.secureTextEntry = YES;
        _yanZMField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return _yanZMField;
}



- (UILabel *)lab3
{
    if (!_lab3) {
        _lab3 = [[UILabel alloc] init];
        _lab3.backgroundColor = CS_Color_LightGray;
    }
    return _lab3;
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


- (UIButton *)findPwdBtn
{
    if (!_findPwdBtn) {
        _findPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_findPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        _findPwdBtn.titleLabel.font = Demon_14_Font;
        [_findPwdBtn setTitleColor:CS_Color_DeepGray forState:UIControlStateNormal];
        [_findPwdBtn addTarget:self action:@selector(findPwdBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findPwdBtn;
}

- (UIButton *)wxVCBtn
{
    if (!_wxVCBtn) {
        _wxVCBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wxVCBtn setImage:[UIImage imageNamed:@"微信-1"]  forState:UIControlStateNormal];
        [_wxVCBtn addTarget:self action:@selector(wxBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxVCBtn;
}



- (UILabel *)lab4
{
    if (!_lab4) {
        _lab4 = [[UILabel alloc] init];
        _lab4.textColor = CS_Color_DeepGray;
        _lab4.font = Demon_13_Font ;
        _lab4.text = @"登录代表您已同意用户协议，隐私政策";
        _lab4.textAlignment = NSTextAlignmentCenter;
        
    }
    return _lab4;
}






#pragma mark -
#pragma mark 约束适配
- (void)makeUpconstraint {
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(SafeAreaTopHeight +15);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(SCREEN_WIDTH -100);
    }];
    

    
    
    [self.phnoeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(40);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-15);
    }];
    
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.phnoeField );
        make.top.mas_equalTo(self.phnoeField.mas_bottom).offset(6);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [self.yanZMField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lab2.mas_bottom).offset(15);
        make.left.height.width.mas_equalTo(self.phnoeField);
    }];
    

    
    
    [self.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.yanZMField );
        make.top.mas_equalTo(self.yanZMField.mas_bottom).offset(6);
        make.height.mas_equalTo(0.5);
    }];
    
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.width.mas_equalTo(self.lab2);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.lab3.mas_bottom).offset(30);
    }];
    
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lab2);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(75);
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(15);
    }];
    
    
    [self.findPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.lab2);
        make.height.top.mas_equalTo(self.cancelBtn);
        make.width.mas_equalTo(60);
    }];
    
    
    [self.wxVCBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_HEIGHT- SafeAreaBottomHeight -50);
        make.height.width.mas_equalTo(44);
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    
    
    
    
    [self.lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.lab2);
        make.top.mas_equalTo(self.wxVCBtn.mas_bottom).offset(15);
        make.height.mas_equalTo(18);
        
    }];
    
    
    
    
    
    
    
}

#pragma mark -
#pragma mark 点击事件


- (void)findPwdBtnAction {
    
    FindPwdViewController *vc = [FindPwdViewController new];
    [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
    
}

- (void)wxBtnAction {
    [self  getAuthWithUserInfoFromWechat];
}

- (void)loginBtnAction {
    
    if ([self checkContent]) {
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:self.phnoeField.text forKey:@"mobile"];
        [parameters setObject:self.yanZMField.text forKey:@"pwd"];
        [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(MemberPwdLoginHttp) needToken:NO success:^(id responseObject) {
            
            NSLog(@"%@",responseObject);
            NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            NSDictionary *dic = responseObject[@"data"];
            if ([@"2000" isEqualToString:codeStr]) {
                NSLog(@"登录成功");
                MyUser.comInfoArea = [NSString stringWithFormat:@"%@",dic[@"comInfo"][@"contactArea"]];
                MyUser.comInfoPerson = [NSString stringWithFormat:@"%@",dic[@"comInfo"][@"contactPerson"]];
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
    
    if (self.yanZMField.text.length > 15 || self.yanZMField.text.length < 6 || [self.yanZMField.text containStr:@" "] ) {
        [self showHint:@"您输入的密码有误"];
        return NO;
    }
    return YES;
}

- (void)cancelBtnAction {
    
    [self.navigationController setCanGestureBack:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getAuthWithUserInfoFromWechat
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            self.wxReqModel = [wxLoginRequestModel new];
            
            
            // 授权信息
            
            self.wxReqModel.openid = resp.openid;
            self.wxReqModel.headImgUrl = resp.iconurl;
            self.wxReqModel.nickName = resp.name;
            self.wxReqModel.mobile = @"";
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            //            NSLog(@"Wechat unionid: %@", resp.unionId);
            //            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            //            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            //            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            //            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            //            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            [self wxLoginRequestWith:self.wxReqModel];
        }
    }];
}

- (void)wxLoginRequestWith:(wxLoginRequestModel *)model {
    
    NSMutableDictionary *dic = [model keyValues];
    [self showLoadingWithMessage:@""];
    [NetworkClient RequestWithParameters:dic withUrl:BASE_URLWith(WxLoginHttp) needToken:NO success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSDictionary *dic = responseObject[@"data"];
        if ([@"2000" isEqualToString:codeStr]) {
            
            NSLog(@"登录成功");
            MyUser.comInfoArea = [NSString stringWithFormat:@"%@",dic[@"comInfo"][@"contactArea"]];
            MyUser.comInfoPerson = [NSString stringWithFormat:@"%@",dic[@"comInfo"][@"contactPerson"]];
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
            [self hideHud];
            [self postNotication];
            NSLog(@"登录成功");
        } else if ([@"2040" isEqualToString:codeStr]) {
            // 去绑定手机号
            
            [self goBindMobile];
            
        } else {
            [self hideHud];
            [self showHint:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)goBindMobile {
    [self hideHud];
    BindphoneViewController *vc = [BindphoneViewController new];
    vc.openid = self.wxReqModel.openid;
    NSLog(@"来了几次～～～～～～～～～～～～～～～～");
    [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
    
}


@end
