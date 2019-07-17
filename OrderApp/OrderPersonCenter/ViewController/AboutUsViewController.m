//
//  AboutUsViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UILabel *lab4;


@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
    [self addView];
}

- (void)addView {
    
    [self.view addSubview:self.logoView];
    [self.view addSubview:self.lab1];
    [self.view addSubview:self.lab2];
    [self.view addSubview:self.btn3];
//    [self.view addSubview:self.btn1];
//    [self.view addSubview:self.lab3];
//    [self.view addSubview:self.btn2];
    [self.view addSubview:self.lab4];

    
    [self makeUpconstraint];
    
}

#pragma mark -
#pragma mark getter

- (UIImageView *)logoView
{
    if (!_logoView) {
        _logoView = [[UIImageView alloc] init];
        [_logoView border:CS_Color_BackZhuti width:4];
        _logoView.image = [UIImage imageNamed:@"加餐啦LOGO"];
    }
    return _logoView;
}

- (UILabel *)lab1
{
    if (!_lab1) {
        _lab1 = [[UILabel alloc] init];
        _lab1.font = Demon_20_MediumFont;
        _lab1.text = @"加餐啦";
        _lab1.textAlignment = NSTextAlignmentCenter;
    }
    return _lab1;
}

- (UILabel *)lab2
{
    if (!_lab2) {
        _lab2 = [[UILabel alloc] init];
        _lab2.textColor = CS_Color_MidGray;
        _lab2.font = Demon_16_Font;
        _lab2.textAlignment = NSTextAlignmentCenter;
        NSDictionary *localDic = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = [localDic objectForKey:@"CFBundleShortVersionString"];
        _lab2.text = [NSString stringWithFormat:@"版本%@",currentVersion];
    }
    return _lab2;
}

- (UIButton *)btn1
{
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn1 setTitle:@"服务协议" forState:UIControlStateNormal];
        [_btn1 setTitleColor:CS_Color_MidGray forState:UIControlStateNormal];
        _btn1.titleLabel.font = Demon_13_Font;
        [_btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
    
    }
    return _btn1;
}

- (UIButton *)btn3
{
    if (!_btn3) {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn3 setTitle:@"获取最新版本" forState:UIControlStateNormal];
        [_btn3 setTitleColor:CS_Color_BackZhuti forState:UIControlStateNormal];
        [_btn3 border:CS_Color_BackZhuti width:1 CornerRadius:4];
        _btn3.titleLabel.font = Demon_16_Font;
        [_btn3 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btn3;
}

- (UILabel *)lab3
{
    if (!_lab3) {
        _lab3 = [[UILabel alloc] init];
        _lab3.backgroundColor = CS_Color_MidGray;
    }
    return _lab3;
}

- (UIButton *)btn2
{
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn2 setTitle:@"隐私说明" forState:UIControlStateNormal];
        [_btn2 setTitleColor:CS_Color_MidGray forState:UIControlStateNormal];
        _btn2.titleLabel.font = Demon_13_Font;
        [_btn2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btn2;
}

- (UILabel *)lab4
{
    if (!_lab4) {
        _lab4 = [[UILabel alloc] init];
        _lab4.textColor = CS_Color_MidGray;
        _lab4.font = Demon_14_Font;
        _lab4.textAlignment = NSTextAlignmentCenter;
        _lab4.text = @"Copyright@2019kaolakeji 保留所有版权";
    }
    return _lab4;
}


#pragma mark -
#pragma mark 约束适配
- (void)makeUpconstraint {
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(SafeAreaTopHeight +80);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(80);
    }];
    
    
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.mas_equalTo(self.view);
        make.top.mas_equalTo(self.logoView.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
    }];
    
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.mas_equalTo(self.view);
        make.top.mas_equalTo(self.lab1.mas_bottom).offset(5);
        make.height.mas_equalTo(22);
    }];
    
    
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH -160);
        make.top.mas_equalTo(self.lab2.mas_bottom).offset(50);
        make.height.mas_equalTo(44);
    }];
    
    
    [self.lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-SafeAreaBottomHeight+49-15);
        make.height.mas_equalTo(15);
    }];
    
    
//    [self.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view);
//        make.bottom.mas_equalTo(self.lab4.mas_top).offset(-15);
//        make.height.mas_equalTo(15);
//        make.width.mas_equalTo(0.8);
//    }];
//    
//    
//    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(60);
//        make.right.mas_equalTo(self.lab3.mas_left);
//        make.height.top.mas_equalTo(self.lab3);
//    }];
//    
//    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(60);
//        make.left.mas_equalTo(self.lab3.mas_right);
//        make.height.top.mas_equalTo(self.lab3);
//    }];
    
    
}


#pragma mark -
#pragma mark 点击事件

- (void)btn1Action {
    
}

- (void)btn2Action {
    
}

@end
