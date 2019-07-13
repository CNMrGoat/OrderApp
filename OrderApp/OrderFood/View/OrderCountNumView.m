//
//  OrderCountNumView.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/30.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderCountNumView.h"

@interface OrderCountNumView()
@property(nonatomic ,strong)UIButton *subBtn;
@property(nonatomic ,strong)UILabel *showLabel;
@property(nonatomic ,strong)UIButton *addBtn;

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
    [self addSubview:self.subBtn];
    [self addSubview:self.addBtn];
    [self addSubview:self.showLabel];
    [self makeUpContraints];
}
#pragma 约束适配
-(void)makeUpContraints{
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
-(UIButton *)subBtn{
    if (!_subBtn) {
        _subBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_subBtn setBackgroundImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [_subBtn bk_addEventHandler:^(id sender) {
            [self count:sender];
        } forControlEvents:UIControlEventTouchUpInside];
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
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
        [_addBtn bk_addEventHandler:^(id sender) {
            [self count:sender];
        } forControlEvents:UIControlEventTouchUpInside];
       
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
-(void)count:(UIButton *)btn{
    if (btn ==self.subBtn) {
        if (self.count >0) {
            self.count--;
            if ([self.localDelegate respondsToSelector:@selector(subNum)]) {
                [self.localDelegate subNum] ;
            }
            if(self.count <1){
                [self.showLabel setText:@""];
                [self.subBtn setHidden:YES];
                return;
            }
           
        }
        
    }else{
        self.count++;
        if ([self.localDelegate respondsToSelector:@selector(addNum)]) {
            [self.localDelegate addNum];
        }
        if (self.count > 0) {
            [self.subBtn setHidden:NO];
        }
        
    }
    [self.showLabel setText:[NSString stringWithFormat:@"%zd",self.count]];
   
}
@end
