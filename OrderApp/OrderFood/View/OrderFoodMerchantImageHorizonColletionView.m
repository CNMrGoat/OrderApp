//
//  OrderFoodDetailHorizonColletionView.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodMerchantImageHorizonColletionView.h"
#import "OrderFoodMerchantImageHorizonCollectionCell.h"
@interface OrderFoodMerchantImageHorizonColletionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *introduceLabel;
@property(nonatomic, strong)UICollectionView *collectionView;

@end
@implementation OrderFoodMerchantImageHorizonColletionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addView];
    }
    return self;
}
-(void)addView{
    [self addSubview:self.titleLabel];
    [self addSubview:self.introduceLabel];
    [self addSubview:self.collectionView];
    [self makeUpcontraints];
}
#pragma mark -
#pragma mark

- (void)makeUpcontraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self);
    }];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.introduceLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self);
    }];
}
#pragma mark -
#pragma mark getter
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator =NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[OrderFoodMerchantImageHorizonCollectionCell class] forCellWithReuseIdentifier:@"kOrderFoodMerchantImageHorizonCollectionCell"];
    }
    return _collectionView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc]init];
        [_titleLabel setText:@"商家信息"];
        [_titleLabel setFont:Demon_15_Font];
    }
    return _titleLabel;
}
-(UILabel *)introduceLabel{
    if (!_introduceLabel) {
        _introduceLabel =[[UILabel alloc]init];
        [_introduceLabel setText:@"文字介绍+图片最多4张"];
        [_introduceLabel setFont:Demon_13_Font];
        [_introduceLabel setTextColor:CS_Color_MidGray];
    }
    return _introduceLabel;
}
#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OrderFoodMerchantImageHorizonCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kOrderFoodMerchantImageHorizonCollectionCell" forIndexPath:indexPath];

    return cell;
}

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100 , 143);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 0, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.0f;
}

#pragma mark -
#pragma mark UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"kAssertCollectionDidSelectItemNotification" object:self userInfo:@{@"categoryModel":self.totalList[indexPath.row]}];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end