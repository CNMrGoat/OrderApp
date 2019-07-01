//
//  MineCenterHeaderView.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "MineCenterHeaderView.h"

struct DelegateFlags{
    unsigned int headAction : 1;

};

@interface MineCenterHeaderView()
@property(nonatomic,assign)struct DelegateFlags delegateFlags;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *phoneNumLabel;
@property(nonatomic,strong)UILabel *signatureLabel;
@property(nonatomic,strong)UIImageView *logoImgView;

@end

@implementation MineCenterHeaderView

-(id)init{
    if (self =[super init]) {
        self.backgroundColor = CS_Color_BackZhuti;
        [self addView];
    }
    return self;
}

- (void)addView {
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.phoneNumLabel];
    [self addSubview:self.signatureLabel];
    [self addSubview:self.logoImgView];
    
    [self makeUpContriant];
    [self addAction];
}

#pragma mark -
#pragma mark 约束适配
-(void)makeUpContriant{
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(SCREEN_WIDTH - 30 -60);
        make.top.mas_equalTo(30);
        make.height.mas_equalTo(17);
    }];
    
    
    [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(8);
        make.height.mas_equalTo(15);
    }];
    
    [self.signatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.mas_equalTo(self.phoneNumLabel);
        make.top.mas_equalTo(self.phoneNumLabel.mas_bottom).offset(8);
    }];
    
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.phoneNumLabel.mas_centerY);
        make.left.mas_equalTo(SCREEN_WIDTH -50- 15);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];

    
    
}

- (void)addAction {
    
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewAction:)];
    [self.logoImgView addGestureRecognizer:headTap];
}

- (void)headViewAction:(UITapGestureRecognizer *)tap {
    if (_delegateFlags.headAction)  {
        [self.delegate headViewAction];
    }
}

#pragma makr -
#pragma mark -- setter
///TODO:如果有新加的delegate方法,请添加到这个set方法里面,缓存了委托对象能否响应协议的某个方法，以此提升方法执行效率
- (void)setDelegate:(id<MineCenterHeadViewDelegate>)delegate
{
    _delegate = delegate;
    if ([delegate conformsToProtocol:@protocol(MineCenterHeadViewDelegate)]) {
        _delegateFlags.headAction = [delegate respondsToSelector:@selector(headViewAction)];
    } else {
        
        _delegateFlags.headAction = NO;
    }
}


-(UIImageView *)logoImgView
{
    if (!_logoImgView) {
        _logoImgView =[[UIImageView alloc]init];
        _logoImgView.backgroundColor = [UIColor whiteColor];
        [_logoImgView setImage:[UIImage imageNamed:@"加餐啦LOGO"]];
        _logoImgView.layer.cornerRadius = 25.0f;
        _logoImgView.layer.masksToBounds = YES;
        _logoImgView.userInteractionEnabled = YES;
    }
    return _logoImgView;
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel =[[UILabel alloc]init];
        [_nameLabel setText:@"唐教授"];
        _nameLabel.font = Demon_16_MediumFont;
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

-(UILabel *)signatureLabel
{
    if (!_signatureLabel) {
        _signatureLabel =[[UILabel alloc]init];
        [_signatureLabel setText:@"人是铁饭是钢，一顿不吃饿得慌"];
        _signatureLabel.font = Demon_13_Font;
        _signatureLabel.textColor = [UIColor whiteColor];
    }
    return _signatureLabel;
}

-(UILabel *)phoneNumLabel
{
    if (!_phoneNumLabel) {
        _phoneNumLabel =[[UILabel alloc]init];
        [_phoneNumLabel setText:@"18573333333"];
        _phoneNumLabel.font = Demon_13_Font;
        _phoneNumLabel.textColor = [UIColor whiteColor];
    }
    return _phoneNumLabel;
}

@end
