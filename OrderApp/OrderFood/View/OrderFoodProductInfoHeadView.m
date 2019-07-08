//
//  OrderFoodProductInfoHeadView.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/8.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodProductInfoHeadView.h"

@interface OrderFoodProductInfoHeadView()
@property (nonatomic ,strong) UIImageView *topImg;
@property (nonatomic ,strong) UIButton *backbtn;
@property (nonatomic ,strong) UIImageView *shareImg;
@end

@implementation OrderFoodProductInfoHeadView

-(id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}

#pragma 添加视图
-(void)addView{
    [self addSubview:self.topImg];
    [self.topImg addSubview:self.backbtn];
    [self.topImg addSubview:self.shareImg];
    [self makeUpContraints];
}
#pragma 约束适配
-(void)makeUpContraints{

    [self.topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    [self.backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(40);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(13);
    }];
    [self.shareImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(40);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    
   
}
#pragma getter

-(UIButton *)backbtn{
    if (!_backbtn) {
        _backbtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_backbtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_backbtn bk_addEventHandler:^(id sender) {
            if ([self.localDelegate respondsToSelector:@selector(backAction)]) {
                [self.localDelegate backAction];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _backbtn;
}
-(UIImageView *)shareImg{
    if (!_shareImg) {
        _shareImg =[[UIImageView alloc]init];
        [_shareImg setImage:[UIImage imageNamed:@"分享"]];
        [_shareImg setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            if ([self.localDelegate respondsToSelector:@selector(shareAction)]) {
                [self.localDelegate shareAction];
            }
        }];
        [_shareImg addGestureRecognizer:tap];
    }
    return _shareImg;
}
-(UIImageView *)topImg{
    if (!_topImg) {
        _topImg =[[UIImageView alloc]init];
        [_topImg setImage:[UIImage imageNamed:@"菜品1"]];
        [_topImg setUserInteractionEnabled:YES];
    }
    return _topImg;
}

@end
