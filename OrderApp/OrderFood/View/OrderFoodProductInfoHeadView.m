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
@property (nonatomic ,strong) UIButton *backbtn1;
@property (nonatomic ,strong) UIButton *backbtn;
@property (nonatomic ,strong) UIButton *shareImg;
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
    [self.topImg addSubview:self.backbtn1];
    [self.topImg addSubview:self.backbtn];
    [self.topImg addSubview:self.shareImg];
    [self makeUpContraints];
}
#pragma 约束适配
-(void)makeUpContraints{
    
    CGFloat navBarHeight = 0.f;
    if (iPhoneX_Series) {
        navBarHeight = SafeAreaTopHeight - 64.f;
    }

    [self.topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
    [self.backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).mas_offset(0);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(80);
        make.top.mas_equalTo(5 + navBarHeight);
        
    }];
    
    
    [self.backbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).mas_offset(20);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(10);
        make.centerY.equalTo(self.shareImg);
        
    }];
    
    [self.shareImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self).mas_offset(10);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(80);
        make.top.mas_equalTo(20 + navBarHeight);
        
    }];
    

    
   
}
#pragma getter


-(UIButton *)backbtn{
    if (!_backbtn) {
        _backbtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _backbtn.backgroundColor = [UIColor clearColor];
        [_backbtn bk_addEventHandler:^(id sender) {
            if ([self.localDelegate respondsToSelector:@selector(backAction)]) {
                [self.localDelegate backAction];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _backbtn;
}

-(UIButton *)backbtn1{
    if (!_backbtn1) {
        _backbtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
        [_backbtn1 setBackgroundImage:[UIImage imageNamed:@"backWhite"] forState:UIControlStateNormal];
    }
    return _backbtn1;
}

-(UIButton *)shareImg{
    
    if (!_shareImg) {
        _shareImg = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareImg setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        [_shareImg addTarget:self action:@selector(setBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareImg;
    
}

- (void)setBtnAction {
    
    if ([self.localDelegate respondsToSelector:@selector(shareAction)]) {
        [self.localDelegate shareAction];
    }
    
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
