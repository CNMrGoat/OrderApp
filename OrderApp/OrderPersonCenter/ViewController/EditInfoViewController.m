//
//  EditInfoViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/7/7.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "EditInfoViewController.h"

@interface EditInfoViewController ()

@end

@implementation EditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRightItem];
 
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
