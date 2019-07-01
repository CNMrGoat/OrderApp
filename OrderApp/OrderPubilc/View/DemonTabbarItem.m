//
//  DemonTabbarItem.m
//  PerAcc
//
//  Created by tim on 15-3-28.
//  Copyright (c) 2015年. All rights reserved.
//

#import "DemonTabbarItem.h"
#import "UIImageView+WebCache.h"

@implementation DemonTabbarItem {
    
    UIImageView *imgView;
    UILabel *titleLabel;
    
    UIColor *_normalFontColor;
    UIColor *_selectedFontColor;
}

- (id)initWithFrame:(CGRect)frame
    normalImageName:(NSString *)normalImageName
  selectedImageNemd:(NSString *)selectedImageName
    normalFontColor:(UIColor *)normalFontColor
  selectedFontColor:(UIColor *)selectedFontColor
              title:(NSString *)title
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _normalImageName = normalImageName;
        _selectedImageName = selectedImageName;
        
        _normalFontColor = normalFontColor;
        _selectedFontColor = selectedFontColor;
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        // 设置背景图片
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-20)/2, 8, 20, 25)];
        // 设置图片模式
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = [UIImage imageNamed:normalImageName];
        [self addSubview:imgView];
        
        //设置title
        CGFloat imageViewBottom = CGRectGetMaxY(imgView.frame);
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageViewBottom, CGRectGetWidth(self.frame), 15)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = Demon_RegularFont_(10);
        titleLabel.textColor = normalFontColor;
        [self addSubview:titleLabel];
        
        //设置小红点
        CGFloat imageViewRight = CGRectGetMaxX(imgView.frame);
        self.pointImageView.frame = CGRectMake(imageViewRight-8, 5, 9, 9);
        [self addSubview:self.pointImageView];
    }
    return self;
}

- (void)showRedPointAtItem:(BOOL)flag
{
    self.pointImageView.hidden = !flag;
}

// 设置选中状态和非选中状态
- (void)setIsSelected:(BOOL) selected
{
    _isSelected = selected;
    if (selected)// 设置选中效果
    {
        imgView.image = [UIImage imageNamed:_selectedImageName];
        titleLabel.textColor = _selectedFontColor;
    }
    else// 设置未选中状态下的效果
    {
        imgView.image = [UIImage imageNamed:_normalImageName];
        titleLabel.textColor = _normalFontColor;
    }
    
}

- (UIImageView *)pointImageView
{
    if (!_pointImageView)
    {
        _pointImageView = [[UIImageView alloc] init];
        _pointImageView.backgroundColor = [UIColor redColor];
        _pointImageView.contentMode = UIViewContentModeScaleToFill;
        _pointImageView.layer.cornerRadius = 4.5;
        _pointImageView.layer.masksToBounds = YES;
        _pointImageView.hidden  = YES;
    }
    return _pointImageView;
}

@end
