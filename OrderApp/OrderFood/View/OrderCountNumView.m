//
//  OrderCountNumView.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderCountNumView.h"

@interface OrderCountNumView()
@property(nonatomic ,strong)UIImageView *subBtn;
@property(nonatomic ,strong)UILabel *showLabel;
@property(nonatomic ,strong)UIImageView *addBtn;
@property(nonatomic ,strong)UIView *plusView;
@property(nonatomic ,strong)UIView *subView;

@end

@implementation OrderCountNumView

-(id)init{
    if (self =[super init]) {
        [self addView];
        self.count =0;
        [self.subBtn setHidden:YES];
    }
    return self;
}
#pragma 添加视图
-(void)addView{
    [self addSubview:self.plusView];
    [self addSubview:self.subView];
    [self addSubview:self.subBtn];
    [self addSubview:self.addBtn];
    [self addSubview:self.showLabel];
    [self makeUpContraints];
}
#pragma 约束适配
-(void)makeUpContraints{
    [self.subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
    [self.plusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(17);
        make.centerY.mas_equalTo(self);
    }];
    [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.left.mas_equalTo(self.subBtn.mas_right);
        make.right.mas_equalTo(self.addBtn.mas_left);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(17);
        make.centerY.mas_equalTo(self);
    }];
}
#pragma getter
-(UIView *)subView{
    if (!_subView) {
        _subView =[[UIView alloc]init];
        [_subView setUserInteractionEnabled:YES];
        WEAKSELF;
        [_subView setTag:1001];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
             [weakSelf count:1001];
        }];
        [_subView addGestureRecognizer:tap];
    }
    return _subView;
}
-(UIView *)plusView{
    if (!_plusView) {
        _plusView =[[UIView alloc]init];
        [_plusView setUserInteractionEnabled:YES];
         [_plusView setTag:1002];
         WEAKSELF;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
             [weakSelf count:1002];
        }];
        [_plusView addGestureRecognizer:tap];
    }
    return _plusView;
}
-(UIImageView *)subBtn{
    if (!_subBtn) {
        _subBtn =[[UIImageView alloc]init];
        [_subBtn setImage:[UIImage imageNamed:@"删除"]];
    }
    return _subBtn;
}
-(UILabel *)showLabel{
    if (!_showLabel) {
        _showLabel =[[UILabel alloc]init];
        [_showLabel setText:@""];
        [_showLabel setTextAlignment:NSTextAlignmentCenter];
        [_showLabel setFont:Demon_12_Font];
    }
    return _showLabel;
}
-(UIImageView *)addBtn{
    if (!_addBtn) {
        _addBtn =[[UIImageView alloc]init];
        [_addBtn setImage:[UIImage imageNamed:@"添加"]];
    }
    return _addBtn;
}
-(void)setNum:(NSInteger)count{
    self.count =count;
    if (self.count >0) {
        if(self.count <1){
            [self.showLabel setText:@""];
            [self.subBtn setHidden:YES];
        }else{
            [self.showLabel setText:[NSString stringWithFormat:@"%zd",self.count]];
             [self.subBtn setHidden:NO];
        }
        
    }else{
        [self.showLabel setText:@""];
        [self.subBtn setHidden:YES];
    }
}
-(void)count:(NSInteger )tag{
    if (tag ==1001) {
        if (self.count >0) {
            self.count--;
            if ([self.localDelegate respondsToSelector:@selector(subNum)]) {
                [self.localDelegate subNum] ;
            }
            if(self.count <1){
                [self.showLabel setText:@""];
                [self.subBtn setHidden:YES];
                [self.subView setUserInteractionEnabled:NO];
                return;
            }
            [self.showLabel setText:[NSString stringWithFormat:@"%zd",self.count]];
        }else{
            [self.subView setUserInteractionEnabled:NO];
            [self.showLabel setText:@""];
            [self.subBtn setHidden:YES];
        }
        
    }else{
        self.count++;
        if ([self.localDelegate respondsToSelector:@selector(addNum)]) {
            [self.localDelegate addNum];
        }
        if (self.count > 0) {
             [self.subView setUserInteractionEnabled:YES];
            [self.subBtn setHidden:NO];
        }
         [self.showLabel setText:[NSString stringWithFormat:@"%zd",self.count]];
    }
   
   
}
@end
