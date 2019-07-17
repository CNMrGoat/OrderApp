//
//  MyCompanyViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/7/17.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "MyCompanyViewController.h"

@interface MyCompanyViewController ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UIButton *btn3;



@end

@implementation MyCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的公司";
    [self addView];
}

- (void)addView {
    
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.lab1];
    [self.backView addSubview:self.lab2];
    [self.backView addSubview:self.lab3];
    [self.backView addSubview:self.lab4];
    [self.backView addSubview:self.btn3];
    [self makeUpconstraint];
    
}

#pragma mark -
#pragma mark getter

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}


- (UILabel *)lab1
{
    if (!_lab1) {
        _lab1 = [[UILabel alloc] init];
        _lab1.font = Demon_18_MediumFont;
        _lab1.text = MyUser.comInfoName;
    }
    return _lab1;
}

- (UILabel *)lab2
{
    if (!_lab2) {
        _lab2 = [[UILabel alloc] init];
        _lab2.textColor = CS_Color_DeepBlack;
        _lab2.font = Demon_16_Font;
        _lab2.text = [NSString stringWithFormat:@"电话：%@",MyUser.comInfoMobile];
    }
    return _lab2;
}

- (UILabel *)lab3
{
    if (!_lab3) {
        _lab3 = [[UILabel alloc] init];
        _lab3.textColor = CS_Color_DeepBlack;
        _lab3.font = Demon_16_Font;
        _lab3.text = [NSString stringWithFormat:@"联系人：%@",MyUser.comInfoPerson];
    }
    return _lab3;
}



- (UILabel *)lab4
{
    if (!_lab4) {
        _lab4 = [[UILabel alloc] init];
        _lab4.textColor = CS_Color_DeepBlack;
        _lab4.font = Demon_14_Font;
        _lab4.numberOfLines = 0;
        _lab4.text = [NSString stringWithFormat:@"地址：%@",MyUser.comInfoArea];
    }
    return _lab4;
}



- (UIButton *)btn3
{
    if (!_btn3) {
        _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn3 setTitle:@"删除" forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn3.backgroundColor = [UIColor whiteColor];
        _btn3.titleLabel.font = Demon_15_Font;
        [_btn3 border:CS_Color_MidGray width:1 CornerRadius:2];

        [_btn3 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btn3;
}




#pragma mark -
#pragma mark 约束适配
- (void)makeUpconstraint {
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.mas_equalTo(self.view);
        make.top.mas_equalTo(SafeAreaTopHeight +10);
        make.height.mas_equalTo(150);
    }];
    
    
    [self.lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH - 30-50);
        make.left.top.mas_equalTo(15);
        make.height.mas_equalTo(30);
    }];
    
    [self.lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.lab1);
        make.top.mas_equalTo(self.lab1.mas_bottom).offset(5);
        make.height.mas_equalTo(22);
    }];
    
    [self.lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.lab1);
        make.top.mas_equalTo(self.lab2.mas_bottom).offset(5);
        make.height.mas_equalTo(22);
    }];
    
    
    [self.lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(SCREEN_WIDTH -30);
        make.top.mas_equalTo(self.lab3.mas_bottom).offset(2);
        make.height.mas_equalTo(38);
    }];
    
    
    
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(self.lab1);
        make.width.mas_equalTo(50);
        make.right.mas_equalTo(self.lab4);
    }];
    
    

    
}


#pragma mark -
#pragma mark 点击事件

- (void)btn1Action {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定解除和该公司的关系吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
     [alert addAction:action0];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self deletaCom];
        
    }];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
    

    
}

- (void)deletaCom {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:MyUser.comInfoUid forKey:@"comId"];

    [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(DelBindComHttp) needToken:YES success:^(id responseObject) {

        NSLog(@"%@",responseObject);
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];

        if ([@"2000" isEqualToString:codeStr]) {

            [MyDefaults removeObjectForKey:@"comInfoArea"];
            [MyDefaults removeObjectForKey:@"comInfoPerson"];
            [MyDefaults removeObjectForKey:@"comInfoMobile"];
            [MyDefaults removeObjectForKey:@"comInfoName"];
            [MyDefaults removeObjectForKey:@"comInfoUid"];

            [self.navigationController popViewControllerAnimated:YES];
            [self showHint:responseObject[@"msg"]];
        } else {

            [self showHint:responseObject[@"msg"]];
        }

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



@end
