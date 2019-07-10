//
//  OrderFoodDetailHeadView.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodDetailHeadView.h"
#import "OrderFoodModel.h"
@interface OrderFoodDetailHeadView()
@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UIImageView *topImg;
@property (nonatomic ,strong) UIButton *backbtn1;
@property (nonatomic ,strong) UIButton *backbtn;
@property (nonatomic ,strong) UIButton *shareImg;
@property (nonatomic ,strong) UIImageView *imgLogo;
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) UIView *lineView;
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
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        if ([self.localDelegate respondsToSelector:@selector(jumpAction)]) {
            [self.localDelegate jumpAction];
        }
    }];
    [self.imgLogo addGestureRecognizer:tap];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.topImg];
    [self.bgView addSubview:self.imgLogo];
    [self.bgView addSubview:self.backbtn1];
    [self.bgView addSubview:self.backbtn];
    [self.bgView addSubview:self.shareImg];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.timeLabel];
    [self.bgView addSubview:self.notifyLabel];
    [self.bgView addSubview:self.lineView];
    [self makeUpContraints];
}
-(void)setMercInfoDic:(NSDictionary *)mercInfoDic{
    mercGoodsInfoResponseModel *responseModel =[mercGoodsInfoResponseModel objectWithKeyValues:mercInfoDic];
    [self.topImg setImageWithURL:[NSURL URLWithString:responseModel.pic] placeholderImage:nil];
    [self.notifyLabel setText:responseModel.announcement];
    [self.imgLogo setImageWithURL:[NSURL URLWithString:responseModel.logo] placeholderImage:nil];
    [self.nameLabel setText:responseModel.name];
    [self.timeLabel setText:[NSString stringWithFormat:@"点餐时间：%@-%@",responseModel.startTime,responseModel.endTime]];
}
#pragma 约束适配
-(void)makeUpContraints{
    
    CGFloat navBarHeight = 0.f;
    if (iPhoneX_Series) {
        navBarHeight = SafeAreaTopHeight - 64.f;
    }
    
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
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(0.2);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
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
        [_imgLogo setUserInteractionEnabled:YES];
    }
    return _imgLogo;
}
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
        _topImg.backgroundColor = [UIColor blackColor];
        [_topImg setImage:[UIImage imageNamed:@"店招"]];
        [_topImg setUserInteractionEnabled:YES];
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
-(UIView *)lineView{
    if (!_lineView) {
        _lineView =[[UIView alloc]init];
        [_lineView setBackgroundColor:CS_Color_MidGray];
    }
    return _lineView;
}
@end
