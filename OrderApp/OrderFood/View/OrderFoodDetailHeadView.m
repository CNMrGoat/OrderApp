//
//  OrderFoodDetailHeadView.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodDetailHeadView.h"
@interface OrderFoodDetailHeadView()
@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UIImageView *topImg;
@property (nonatomic ,strong) UIButton *backbtn;
@property (nonatomic ,strong) UIImageView *shareImg;
@property (nonatomic ,strong) UIImageView *imgLogo;
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) UILabel *notifyLabel;
@end
@implementation OrderFoodDetailHeadView

-(id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}

#pragma 添加视图
-(void)addView{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.topImg];
    [self.bgView addSubview:self.imgLogo];
    [self.bgView addSubview:self.backbtn];
    [self.bgView addSubview:self.shareImg];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.timeLabel];
    [self.bgView addSubview:self.notifyLabel];
    [self makeUpContraints];
}
#pragma 约束适配
-(void)makeUpContraints{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    [self.topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView);
        make.right.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.bgView);
        make.bottom.mas_equalTo(self.bgView.mas_centerY);
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
    [self.imgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.bgView);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imgLogo);
        make.top.mas_equalTo(self.imgLogo.mas_bottom).offset(5);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
    }];
    [self.notifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.timeLabel);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(5);
    }];
}
#pragma getter
-(UIView *)bgView{
    if (!_bgView) {
        _bgView =[[UIView alloc]init];
        [_bgView setBackgroundColor:[UIColor whiteColor]];
    }
    return _bgView;
}
-(UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo =[[UIImageView alloc]init];
        [_imgLogo setImage:[UIImage imageNamed:@"商家logo"]];
    }
    return _imgLogo;
}
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
        [_topImg setImage:[UIImage imageNamed:@"店招"]];
    }
    return _topImg;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel =[[UILabel alloc]init];
        [_nameLabel setFont:Demon_15_Font];
        [_nameLabel setText:@"海底捞：金星北路汽车站"];
    }
    return _nameLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel =[[UILabel alloc]init];
        [_timeLabel setFont:Demon_13_Font];
        [_timeLabel setText:@"点餐时间：9：00-20：00（第二天中午送到）"];
    }
    return _timeLabel;
}
-(UILabel *)notifyLabel{
    if (!_notifyLabel) {
        _notifyLabel =[[UILabel alloc]init];
        [_notifyLabel setFont:Demon_13_Font];
        [_notifyLabel setText:@"公告：本餐厅所有订单，有海底捞宅急送官方品牌配送"];
        [_notifyLabel setTextColor:CS_Color_MidGray];
    }
    return _notifyLabel;
}
@end
