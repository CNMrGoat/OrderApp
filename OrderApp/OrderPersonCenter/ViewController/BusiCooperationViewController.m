//
//  BusiCooperationViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "BusiCooperationViewController.h"

@interface BusiCooperationViewController ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UILabel *lab5;
@property (nonatomic, strong) UILabel *lab6;
@property (nonatomic, strong) UILabel *lab7;
@property (nonatomic, strong) UILabel *lab8;

@end

@implementation BusiCooperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商务合作";
    [self addView];
}

- (void)addView {
    
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.lab1];
    [self.backView addSubview:self.lab2];
    [self.backView addSubview:self.lab3];
    [self.backView addSubview:self.lab4];
    [self.backView addSubview:self.lab5];
    [self.backView addSubview:self.lab6];
    [self.backView addSubview:self.lab7];
    [self.backView addSubview:self.lab8];

    [self makeUpconstraint];
    
}

#pragma mark -
#pragma mark getter


- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = CS_Color_BackZhuti;
        [_backView border:CS_Color_BackZhuti width:4];
    }
    return _backView;
}

- (UILabel *)lab1
{
    if (!_lab1) {
        _lab1 = [[UILabel alloc] init];
        _lab1.textColor = [UIColor whiteColor];
        _lab1.font = Demon_13_Font;
        _lab1.text = @"联系电话";
        _lab1.textAlignment = NSTextAlignmentRight;
    }
    return _lab1;
}

- (UILabel *)lab2
{
    if (!_lab2) {
        _lab2 = [[UILabel alloc] init];
        _lab2.textColor = [UIColor whiteColor];
        _lab2.font = Demon_15_Font;
        _lab2.text = @"0371-83293790";
    }
    return _lab2;
}

- (UILabel *)lab3
{
    if (!_lab3) {
        _lab3 = [[UILabel alloc] init];
        _lab3.textColor = [UIColor whiteColor];
        _lab3.font = Demon_13_Font;
        _lab3.text = @"QQ号";
        _lab3.textAlignment = NSTextAlignmentRight;
    }
    return _lab3;
}

- (UILabel *)lab4
{
    if (!_lab4) {
        _lab4 = [[UILabel alloc] init];
        _lab4.textColor = [UIColor whiteColor];
        _lab4.font = Demon_15_Font;
        _lab4.text = @"1731805755";
    }
    return _lab4;
}

- (UILabel *)lab5
{
    if (!_lab5) {
        _lab5 = [[UILabel alloc] init];
        _lab5.textColor = [UIColor whiteColor];
        _lab5.font = Demon_13_Font;
        _lab5.text = @"微信号";
        _lab5.textAlignment = NSTextAlignmentRight;
    }
    return _lab5;
}

- (UILabel *)lab6
{
    if (!_lab6) {
        _lab6 = [[UILabel alloc] init];
        _lab6.textColor = [UIColor whiteColor];
        _lab6.font = Demon_15_Font;
        _lab6.text = @"1731805755";
    }
    return _lab6;
}

- (UILabel *)lab7
{
    if (!_lab7) {
        _lab7 = [[UILabel alloc] init];
        _lab7.textColor = [UIColor whiteColor];
        _lab7.font = Demon_13_Font;
        _lab7.text = @"公司地址";
        _lab7.textAlignment = NSTextAlignmentRight;
    }
    return _lab7;
}

- (UILabel *)lab8
{
    if (!_lab8) {
        _lab8 = [[UILabel alloc] init];
        _lab8.textColor = [UIColor whiteColor];
        _lab8.numberOfLines = 0;
        _lab8.font = Demon_15_Font;
        _lab8.text = @"湖南省长沙市岳麓区恒大华府26栋";
    }
    return _lab8;
}




#pragma mark -
#pragma mark 约束适配
- (void)makeUpconstraint {
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(SafeAreaTopHeight +10);
        make.height.mas_equalTo(200);
        make.width.mas_equalTo(SCREEN_WIDTH -30);
    }];
    
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.height.mas_equalTo(self.lab1);
        make.left.mas_equalTo(self.lab1.mas_right).offset(20);
    }];
    
    [self.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.mas_equalTo(self.lab1);
        make.top.mas_equalTo(self.lab1.mas_bottom).offset(15);
    }];
    
    [self.lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.mas_equalTo(self.lab2);
        make.top.mas_equalTo(self.lab3);
    }];
    
    [self.lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.mas_equalTo(self.lab1);
        make.top.mas_equalTo(self.lab3.mas_bottom).offset(15);
    }];
    
    [self.lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.mas_equalTo(self.lab2);
        make.top.mas_equalTo(self.lab5);
    }];
    
    [self.lab7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.mas_equalTo(self.lab1);
        make.top.mas_equalTo(self.lab5.mas_bottom).offset(15);
    }];
    
    [self.lab8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.lab2);
        make.top.mas_equalTo(self.lab7);
        make.height.mas_equalTo(50);
    }];
    
}

@end
