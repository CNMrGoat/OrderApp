//
//  EditInfoViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/7/7.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "EditInfoViewController.h"

@interface EditInfoViewController ()

@property (nonatomic, strong) UITextField *inputField;
@property (nonatomic, strong) UIView *backView;

@end

@implementation EditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRightItem];
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight +15, SCREEN_WIDTH, 44)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    [_backView addSubview:self.inputField];
    [self makeUpconstraint];
 
}


- (UITextField *)inputField
{
    if (!_inputField) {
        _inputField = [[UITextField alloc] init];
        _inputField.textColor = CS_Color_DeepBlack;
        _inputField.font = Demon_16_Font ;
        if ([self.title isEqualToString:@"签名编辑"]) {
            _inputField.placeholder = @"请输入签名";
        } else {
            _inputField.placeholder = @"请输入昵称";
        }
    
    }
    return _inputField;
}

- (void)makeUpconstraint {
    
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.centerY.mas_equalTo(self.backView);
        make.width.mas_equalTo(SCREEN_WIDTH -30);
    }];
}

- (void)addRightItem
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(SureItemAction)];
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName : CS_Color_BackZhuti,
                          NSFontAttributeName : Demon_16_Font
                          };
    [rightItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)SureItemAction {
    
    if ([self checkContent]) {
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
 
        if ([self.title isEqualToString:@"签名编辑"]) {
            [parameters setObject:@"signature" forKey:@"filedName"];
        } else {
            [parameters setObject:@"nickName" forKey:@"filedName"];
        }
        
        [parameters setObject:self.inputField.text forKey:@"filedValue"];
        
        [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(EditUserInfoHttp) needToken:YES success:^(id responseObject) {
            
            NSLog(@"%@",responseObject);
            NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            [self showHint:responseObject[@"msg"]];
            if ([@"2000" isEqualToString:codeStr]) {
                
                if ([self.title isEqualToString:@"签名编辑"]) {
                    MyUser.signature = self.inputField.text;
                } else {
                    MyUser.nickName = self.inputField.text;
                }
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }
    
}

- (BOOL)checkContent {
    
    
    
    if (self.inputField.text.length<1) {
        
        [self showHint:@"您还未输入"];
        return NO;
    }
    

    if ([self.inputField.text containStr:@" "]) {
        
        [self showHint:@"输入内容不能包含空格" ];
        return NO;
    }
    
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
