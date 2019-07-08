//
//  OrderCarTableViewCell.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderTableViewCell.h"

static NSString *footIdentifier = @"OrderDFooterView";

@interface OrderTableViewCell()

@property (strong, nonatomic) UIImageView *imgView;/**<时间*/
@property (strong, nonatomic) UILabel *nameLab;/**<描述*/
@property (strong, nonatomic) UILabel *fenshuLabel;/**<时间*/
@property (strong, nonatomic) UILabel *amoubtLabel;/**<时间*/

@end

@implementation OrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpAllChirdView];
    }
    return self;
}

- (void)setUpAllChirdView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.fenshuLabel];
    [self.contentView addSubview:self.amoubtLabel];
    
    [self makeViewsConstraints];
}

- (void)makeViewsConstraints
{
    
    //写死数据
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@8);
        make.height.equalTo(@60);
        make.width.mas_equalTo(60);
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(8);
        make.top.equalTo(@15);
        make.height.equalTo(@18);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
    }];
    
    [self.fenshuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(self.nameLab);
        make.top.mas_equalTo(self.nameLab.mas_bottom).offset(10);
    }];
    
    [self.amoubtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(@28);
        make.height.equalTo(@18);
        make.width.mas_equalTo(300);
    }];
    
    
}

#pragma mark -
#pragma mark getter & setter
- (void)setSunlistModel:(SunlistModel *)sunlistModel{
    if (_sunlistModel != sunlistModel) {
        _sunlistModel = sunlistModel;
        
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:_sunlistModel.pic]];
        _nameLab.text = [NSString stringWithFormat:@"%@",_sunlistModel.goodName];
        _fenshuLabel.text = [NSString stringWithFormat:@"X%@",_sunlistModel.num];
        _amoubtLabel.text =  [NSString stringWithFormat:@"%@",_sunlistModel.price];
        
    }
}





- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [UIImageView new];
    }
    return _imgView;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.font = Demon_14_MediumFont;
        _nameLab.textColor = [UIColor blackColor];
    }
    return _nameLab;
}


- (UILabel *)fenshuLabel
{
    if (!_fenshuLabel) {
        _fenshuLabel = [UILabel new];
        _fenshuLabel.font = Demon_14_Font;
        _fenshuLabel.textColor = CS_Color_MidGray;
    }
    return _fenshuLabel;
}

- (UILabel *)amoubtLabel
{
    if (!_amoubtLabel) {
        _amoubtLabel = [UILabel new];
        _amoubtLabel.font = Demon_16_Font;
        _amoubtLabel.textColor = CS_Color_BackZhuti;
        _amoubtLabel.textAlignment = NSTextAlignmentRight;
    }
    return _amoubtLabel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
