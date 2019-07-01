//
//  TanChuanMessageView.m
//  TheBase
//
//  Created by zhangfan on 2019/5/16.
//  Copyright © 2018年 MrGoat. All rights reserved.
//

#import "TanChuanMessageView.h"

@implementation TanChuanMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHex:0000000 alpha:0.5];
        self.alpha = 1;
        //初始化子视图
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{

    UIView *midView = [UIView new];
    [self addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH-100);
        make.height.mas_equalTo(350);
    }];
    [midView border:[UIColor clearColor] width:0.1 CornerRadius:5];
    [midView setBackgroundColor:[UIColor whiteColor]];
    
    self.headImage = [UIImageView new];
    [midView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.centerX.equalTo(midView);
        make.height.equalTo(@38);
        make.width.equalTo(@36);
    }];
    
    self.titleLabel = [UILabel new];
    [midView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).offset(10);
        make.centerX.width.equalTo(midView);
        make.height.equalTo(@30);
    }];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = Demon_19_MediumFont;
    
    
    self.titleLabel1 = [UILabel new];
    [midView addSubview:self.titleLabel1];
    [self.titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.centerX.equalTo(midView);
        make.width.mas_equalTo(SCREEN_WIDTH-130);
        make.height.equalTo(@190);
    }];

    self.titleLabel1.font = Demon_15_Font;
    self.titleLabel1.numberOfLines = 0;
    self.titleLabel1.textColor = CS_Color_DeepGray;
    

    self.quxiaobtn = [UIButton new];
    [self addSubview:self.quxiaobtn];
    self.quxiaobtn.backgroundColor = [UIColor whiteColor];
    self.quxiaobtn.titleLabel.font = Demon_16_Font;
    [self.quxiaobtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.quxiaobtn setTitle:@"以后再说" forState:UIControlStateNormal];
    [self.quxiaobtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(midView);
        make.width.mas_equalTo((SCREEN_WIDTH-100)/2);
        make.height.equalTo(@46);
    }];
    [self.quxiaobtn border:[UIColor clearColor] width:0.1 CornerRadius:5];
    
    UILabel *line = [UILabel new];
    [self.quxiaobtn addSubview:line];
    line.backgroundColor = CS_Color_BackGroundGray;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self.quxiaobtn );
        make.height.equalTo(@0.8);
    }];
    

    self.querenbtn = [UIButton new];
    [self addSubview:self.querenbtn];
    self.querenbtn.backgroundColor = CS_Color_BackZhuti;
    [self.querenbtn setTitle:@"立即更新" forState:UIControlStateNormal];
    self.querenbtn.titleLabel.font = Demon_16_Font;
    [self.querenbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(midView);
        make.width.mas_equalTo((SCREEN_WIDTH-100)/2);
        make.height.equalTo(@46);
    }];
    
    [self.querenbtn border:[UIColor clearColor] width:0.1 CornerRadius:5];
    
    UILabel *line2 = [UILabel new];
    [self addSubview:line2];
    line2.backgroundColor = CS_Color_BackZhuti;
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.querenbtn);
        make.height.width.equalTo(@5);
    }];
    
    UILabel *line3 = [UILabel new];
    [self addSubview:line3];
    line3.backgroundColor = CS_Color_BackZhuti;
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.querenbtn);
        make.height.width.equalTo(@5);
    }];
    
    UILabel *line4 = [UILabel new];
    [self addSubview:line4];
    line4.backgroundColor = CS_Color_BackZhuti;
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.querenbtn);
        make.height.width.equalTo(@5);
    }];
    


}
@end
