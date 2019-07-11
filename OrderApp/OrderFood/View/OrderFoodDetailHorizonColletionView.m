//
//  OrderFoodDetailHorizonColletionView.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "OrderFoodDetailHorizonColletionView.h"
#import "OrderFoodDetailHorizonCollectionCell.h"
#import "OrderFoodModel.h"
@interface OrderFoodDetailHorizonColletionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,OrderFoodDetailHorizonCollectionCellDelegate>
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic,strong)UICollectionView *collectionView;

@end
@implementation OrderFoodDetailHorizonColletionView

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
    [self addSubview:self.collectionView];
    [self makeUpcontraints];
}
#pragma mark -
#pragma mark

- (void)makeUpcontraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self).offset(10);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self);
    }];
}
-(void)reloadData{
    [self.collectionView reloadData];
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
        [_collectionView registerClass:[OrderFoodDetailHorizonCollectionCell class] forCellWithReuseIdentifier:@"kOrderFoodDetailHorizonCollectionCell"];
    }
    return _collectionView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc]init];
        [_titleLabel setText:@"招牌美味"];
        [_titleLabel setFont:Demon_17_Font];
    }
    return _titleLabel;
}
-(void)setHotList:(NSArray *)hotList{
    _hotList =hotList;
}
#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.hotList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OrderFoodDetailHorizonCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kOrderFoodDetailHorizonCollectionCell" forIndexPath:indexPath];
    
    mercGoodsInfoResponseSubListModel *sublistModel =[mercGoodsInfoResponseSubListModel objectWithKeyValues:self.hotList[indexPath.row]];
    [cell setSubListModel:sublistModel];
    [cell setLocalDelegate:self];
    return cell;
}

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(130 , 173);
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

#pragma OrderFoodDetailHorizonCollectionCellDelegate
-(void)collectionCellCountNum:(NSInteger)count andMoney:(NSString *)moneyStr{
    if ([self.LocalDelegate respondsToSelector:@selector(colletionViewCountNum:andMoney:)]) {
        [self.LocalDelegate colletionViewCountNum:count andMoney:moneyStr];
    }
}
@end
