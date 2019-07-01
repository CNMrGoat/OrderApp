//
//  BCSSliderView.m
//  CSDirectBank
//
//  Created by 邹永进 on 16/9/5.
//  Copyright © 2016年 tim. All rights reserved.
//

#import "BCSSliderView.h"

@interface BCSSliderView () {
    void (^tempBlc)(UIButton *button,NSInteger index);
}
@property (nonatomic, strong) UIButton *tempButton;
//@property (nonatomic, strong) UIButton *centerButton;


@property (nonatomic, strong) UIView *lineView;   /**<下部线条滑块*/

@end


@implementation BCSSliderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

#pragma mark -
#pragma mark Private Method
- (void)setUp
{
    self.backgroundColor = [UIColor whiteColor];
    [self addView];
}

- (UIButton *)buttonWithTitle:(NSString *)title andTag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = Demon_13_Font;
    return button;
}



#pragma mark -
#pragma mark Event Response
- (void)buttonClicked:(UIButton *)sender {
    _tempButton.selected = NO;
    sender.selected = YES;
    _tempButton = sender;
    
    if (tempBlc) {
        tempBlc(sender,sender.tag - 1100);
    }
    
//    if (sender.tag == 1100) {
//        [self lineViewToLeft:sender];
//    }else if (sender.tag == 1101) {
//        
//        [self lineViewToCenter:sender];
//    }else if (sender.tag == 1102) {
//        [self lineViewToRight:sender];
//    }
    
    if (sender.tag == 1100) {
        [self lineViewToLeft:sender];
    }
    else if (sender.tag == 1101) {
        [self lineViewToRight:sender];
    }
}

- (void)lineViewToLeft:(UIButton *)sender {
    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftButton.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).with.multipliedBy(0.5);
    }];
    [self lineViewToleftAndRightLayout];
}

//- (void)lineViewToCenter:(UIButton *)sender {
//    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_centerButton.mas_bottom);
//        make.left.equalTo(self.mas_left).offset(self.frame.size.width * 0.33);
//        make.bottom.equalTo(self);
//        make.width.equalTo(self.mas_width).with.multipliedBy(0.33);
//    }];
//    [self lineViewToleftAndRightLayout];
//}

- (void)lineViewToRight:(UIButton *)sender {
    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftButton.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).with.multipliedBy(0.5);
    }];
    [self lineViewToleftAndRightLayout];
}

- (void)lineViewToleftAndRightLayout {
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];//需要时自动调用布局
    } completion:nil];
}

- (void)whichButtonClicked:(void (^)(UIButton *button, NSInteger index))blc {
    
    tempBlc = ^(UIButton *button,NSInteger index)
    {
        
        blc(button,index);
    };
}

- (void)setWhichIndex:(NSInteger)whichIndex {
    
    UIButton *tempButton = (UIButton *)[self viewWithTag:whichIndex + 1100];
    
    _tempButton.selected = NO;
    tempButton.selected = YES;
    _tempButton = tempButton;
    
//    if (whichIndex == 0) {
//        [self lineViewToLeft:tempButton];
//    }else if (whichIndex == 1){
//        [self lineViewToCenter:tempButton];
//    }else if (whichIndex == 2) {
//        [self lineViewToRight:tempButton];
//    }
    
    if (whichIndex == 0) {
        [self lineViewToLeft:tempButton];
    }
    else if (whichIndex == 1) {
        [self lineViewToRight:tempButton];
    }
    _whichIndex = whichIndex;
}

#pragma mark -
#pragma mark addView
- (void)addView {
    [self addSubview:self.leftButton];
//    [self addSubview:self.centerButton];
    [self addSubview:self.rightButton];
    [self addSubview:self.lineView];
    [self updateViewConstraints];
}

#pragma mark -
#pragma mark Masongry
- (void)updateViewConstraints {
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).with.offset(-2);
        make.width.equalTo(self.mas_width).with.multipliedBy(0.5);
    }];
    
//    [_centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self);
//        make.bottom.equalTo(self.mas_bottom).with.offset(-2);
//        make.left.equalTo(_leftButton.mas_right);
//        make.width.equalTo(self.mas_width).with.multipliedBy(0.33);
//    }];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).with.offset(-2);
        make.width.equalTo(self.mas_width).with.multipliedBy(0.5);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftButton.mas_bottom);
        make.left.and.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).with.multipliedBy(0.5);
    }];
    
}



#pragma mark -
#pragma mark Setter & Gettet
- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [self buttonWithTitle:@"待确认" andTag:1100];
        _leftButton.selected = YES;
        _tempButton = _leftButton;
    }
    return _leftButton;
}

//- (UIButton *)centerButton
//{
//    if (!_centerButton) {
//        _centerButton = [self buttonWithTitle:@"稳健投资" andTag:1101];
//    }
//    return _centerButton;
//}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [self buttonWithTitle:@"持有中" andTag:1101];
    }
    return _rightButton;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}


@end
