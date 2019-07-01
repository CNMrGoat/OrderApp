//
//  MineCenterTableViewCell.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "MineCenterTableViewCell.h"

@implementation MineCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setDemonSeparatorStyle:DemonTableViewCellSeparatorFull];
        self.textLabel.font = Demon_RegularFont_(15);
        self.textLabel.textColor = UIColorFromHex(0x666666);
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setBackgroundView:[[UIView alloc] init]];
        [self showCellIndicator:YES];
        [self addView];
    }
    return self;
}

#pragma mark -
#pragma mark 添加视图
-(void)addView{
    [self.contentView addSubview:self.lineV];
    [self makeUpstraints];
}

#pragma mark -
#pragma mark 添加约束
-(void)makeUpstraints{
    
    
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(SCREEN_WIDTH - 15);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

- (UIView *)lineV
{
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = [UIColor colorWithHexString:@"#dedede"];
    }
    return _lineV;
}

@end
