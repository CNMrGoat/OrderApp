//
//  CodeLoginViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/28.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "CodeLoginViewController.h"
#import "UIButton+Extend.h"
#import "PasswordViewController.h"
#import "BindphoneViewController.h"
#import <UMShare/UMShare.h>
#import "OrderLoginModel.h"
#import "WebViewViewController.h"

@interface CodeLoginViewController ()

@property (nonatomic, strong) UILabel *titleLab;
//@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UITextField *phnoeField;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UITextField *yanZMField;
@property (nonatomic, strong) UIButton *yanZMBtn;
@property (nonatomic, strong) UILabel *lab3;


@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *gotoMmVCBtn;
@property (nonatomic, strong) UIButton *wxVCBtn;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UIButton *lab4Btn;


@property (nonatomic, strong) wxLoginRequestModel *wxReqModel;

@end

@implementation CodeLoginViewController

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
//    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.phnoeField];
    [self.view addSubview:self.lab2];
    [self.view addSubview:self.yanZMField];
    [self.view addSubview:self.yanZMBtn];
    [self.view addSubview:self.lab3];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.gotoMmVCBtn];
    
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
    }
    
    [self.view addSubview:self.lab4];
    [self.view addSubview:self.lab4Btn];
    

    
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

//- (UIButton *)cancelBtn
//{
//    if (!_cancelBtn) {
//        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_cancelBtn setTitle:@"✕" forState:UIControlStateNormal];
//        _cancelBtn.titleLabel.font = Demon_30_Font;
//        [_cancelBtn setTitleColor:CS_Color_BackZhuti forState:UIControlStateNormal];
//        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _cancelBtn;
//}

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


- (UIButton *)gotoMmVCBtn
{
    if (!_gotoMmVCBtn) {
        _gotoMmVCBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gotoMmVCBtn setTitle:@"密码登录" forState:UIControlStateNormal];
        _gotoMmVCBtn.titleLabel.font = Demon_14_Font;
        [_gotoMmVCBtn setTitleColor:CS_Color_DeepGray forState:UIControlStateNormal];
        [_gotoMmVCBtn addTarget:self action:@selector(gotoMmVCBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gotoMmVCBtn;
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

- (UIButton *)lab4Btn
{
    if (!_lab4Btn) {
        _lab4Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lab4Btn.backgroundColor = [UIColor clearColor];
        [_lab4Btn addTarget:self action:@selector(goToXY) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lab4Btn;
}


- (UILabel *)lab4
{
    if (!_lab4) {
        _lab4 = [[UILabel alloc] init];
        _lab4.textColor = CS_Color_DeepGray;
        _lab4.font = Demon_13_Font ;
        _lab4.text = @"登录代表您已同意用户注册协议，隐私政策";
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
    
//    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.height.mas_equalTo(self.titleLab);
//        make.right.mas_equalTo(-15);
//        make.width.mas_equalTo(44);
//    }];
    
    
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
    
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.width.mas_equalTo(self.lab2);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.lab3.mas_bottom).offset(30);
    }];
    
    
    [self.gotoMmVCBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lab2);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(60);
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(15);
    }];
    
    
    [self.wxVCBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCREEN_HEIGHT- SafeAreaBottomHeight -50);
        make.height.width.mas_equalTo(44);
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    
    
    
    
    [self.lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.lab2);
        make.top.mas_equalTo(SCREEN_HEIGHT- SafeAreaBottomHeight -50+44+15);
        make.height.mas_equalTo(18);

    }];
    
    [self.lab4Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.height.equalTo(self.lab4);
    }];
    
    


}

- (void)goToXY {
    
    WebViewViewController *vc = [WebViewViewController new];
    vc.urlStr = @"http://zhaodian.csjiayu.com/jiacanla_Registration_Agreement.html";

        
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -
#pragma mark 点击事件
- (void)yanZMBtnAction {
    
    if ([self.phnoeField.text checkPhoneNumInput]) {
        [self.yanZMBtn startWithSecondTime:59 title:@"获取验证码"  countDownTitle:@"s" mainColor:CS_Color_BackGroundGray countColor:[UIColor lightGrayColor]];
        
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:self.phnoeField.text forKey:@"mobile"];
        [parameters setObject:@"LOGIN" forKey:@"type"];
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

- (void)gotoMmVCBtnAction {
    
    PasswordViewController *vc = [PasswordViewController new];
    [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
    
}

- (void)wxBtnAction {
    
    [self  getAuthWithUserInfoFromWechat];
    
}


/**
 *  检查输入内容
 *
 *  @return 是否合法输入
 */
- (BOOL)checkContent {
    if (![self.phnoeField.text checkPhoneNumInput]) {
        
        [self showHint:@"手机号码不正确"];
        return NO;
    }
    
    if (self.yanZMField.text.length<3) {
        
        [self showHint:@"请输入正确的验证码" ];
        return NO;
    }
    
    
    return YES;
}

- (void)loginBtnAction {
    
    if ([self checkContent]) {
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:self.phnoeField.text forKey:@"mobile"];
        [parameters setObject:self.yanZMField.text forKey:@"verify"];
        [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(MemberVerifyLoginHttp) needToken:NO success:^(id responseObject) {
            
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

//- (void)cancelBtnAction {
//
//    [self dismissViewControllerAnimated:YES completion:nil];
//}




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

- (void)postNotication {
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:self userInfo:nil];
}

- (void)goBindMobile {
    [self hideHud];
    BindphoneViewController *vc = [BindphoneViewController new];
    vc.openid = self.wxReqModel.openid;
    NSLog(@"来了几次～～～～～～～～～～～～～～～～");
    [self.navigationController pushViewController:vc animated:YES pushType:NavigationPushNormal];
    
}
//-(BOOL) isInstall:(UMSocialPlatformType)platformType;




@end
