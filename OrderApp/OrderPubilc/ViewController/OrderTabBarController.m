//
//  CSTabBarController.m
//  CSDirectBank
//
//  Created by 彭小坚 on 15/8/14.
//  Copyright (c) 2015年 彭小坚. All rights reserved.
//

#import "OrderTabBarController.h"
#import "DemonTabbarItem.h"
#import "MineCenterViewController.h"
#import "OrderViewController.h"
#import "OrderFoodViewController.h"
//#import "OrderMenuViewController.h"



//NSString *const kSwitchTabNotification = @"SwitchTabNotification";

@interface OrderTabBarController()

@property(nonatomic,copy) NSArray *normalImageArray;
@property(nonatomic,copy) NSArray *selectedImageArray;
@property(nonatomic,copy) DemonTabbarItem *selectedItem;

@property(nonatomic,strong) OrderFoodViewController *orderFoodVC;

@property(nonatomic,strong) OrderViewController *orderVC;

@property(nonatomic,strong) MineCenterViewController *MineVC;



@end

@implementation OrderTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getOldViewControllers];
        [self setUp];
    }
    return self;
}

#pragma mark -
#pragma mark life Cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    //写了init方法，在init方法里面对属性赋值，会调用一次viewDidLoad方法，所以最好在init做初始化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifySwitchTab:) name:@"SwitchTabNotification" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SwitchTabNotification" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    NSArray *subViews = self.tabBar.subviews;
    for (UIView *view in subViews) {
        //此函数能获取该字符串指代的类
        Class cla = NSClassFromString(@"UITabBarButton");
        //判断该视图的类型是否属于cla所指的类型
        if ([view isKindOfClass:cla]) {
            [view removeFromSuperview];
        }
        
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


#pragma mark -
#pragma mark Private Method
- (void)setUp
{
    [self createTabbar];
}


///去掉tabbar顶部线条
- (void)changeTabbarBackgroundImg
{
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
}

///添加阴影
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    //    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.tabBar.clipsToBounds = NO;
}

-(void)getOldViewControllers
{
    DemonNavigationController *orderFoodNav = [[DemonNavigationController alloc]initWithRootViewController:self.orderFoodVC];
    [self addChildViewController:orderFoodNav];
    DemonNavigationController *orderNav = [[DemonNavigationController alloc]initWithRootViewController:self.orderVC];
    [self addChildViewController:orderNav];
    //    DemonNavigationController *lifeNav = [[DemonNavigationController alloc]initWithRootViewController:self.LifeVC];
    //    [self addChildViewController:lifeNav];
    DemonNavigationController *mineNav = [[DemonNavigationController alloc]initWithRootViewController:self.MineVC];
    [self addChildViewController:mineNav];
    
}


- (void)createTabbar
{
    
    //    _normalImageArray = @[@"点餐", @"购物车-1",@"订单-1", @"我的-1"];
    //    _selectedImageArray = @[@"点餐 点中", @"购物车",@"订单", @"我的"];
    _normalImageArray = @[@"点餐",@"订单-1", @"我的-1"];
    _selectedImageArray = @[@"点餐 点中",@"订单", @"我的"];
    
    
    
    // 按钮的标题数组
    NSArray *titleArray = @[@"点餐", @"订单", @"我的"];
    
    UIColor *normalFontColor = [UIColor colorWithHex:0x666666];
    UIColor *selectedFontColor = [UIColor colorWithHex:0xDF2100];// [UIColor colorWithHex:0xEF3D3D];
    
    
    // 按钮的宽、高
    CGFloat width = SCREEN_WIDTH / (float)titleArray.count;
    CGFloat height = SafeAreaBottomHeight;
    for (int i = 0; i < titleArray.count; i++) {
        
        CGRect frame = CGRectMake(width * i, 0, width, height);
        //使用自定义的按钮样式
        DemonTabbarItem *item = [[DemonTabbarItem alloc] initWithFrame:frame
                                                       normalImageName:_normalImageArray[i]
                                                     selectedImageNemd:_selectedImageArray[i]
                                                       normalFontColor:normalFontColor
                                                     selectedFontColor:selectedFontColor
                                                                 title:titleArray[i]];
        item.tag = i+1;
        item.isSelected = NO;
        
        // 设置选中效果
        if (i == 0) {
            item.isSelected = YES;
            _selectedItem = item;
        }
        [item addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:item];
    }
    
}


#pragma mark -
#pragma mark 切换页面

- (void)notifySwitchTab:(NSNotification *)notification
{
    NSIndexPath *indexPath = [notification object];
    [self switchTab:indexPath];
}

- (void)itemTapped:(DemonTabbarItem *)item
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:item.tag];
    [self switchTab:indexPath];
}

- (void)switchTab:(NSIndexPath *)indexPath
{
    
    
    DemonTabbarItem *item = [self.tabBar viewWithTag:indexPath.section];
    if (item == _selectedItem) return;
    
    item.isSelected = YES;
    _selectedItem.isSelected = NO;
    _selectedItem = item;
    
    self.selectedIndex = item.tag - 1;
}

#pragma mark -
#pragma mark getter & setter
- (OrderViewController *)orderVC
{
    if (!_orderVC) {
        _orderVC = [[OrderViewController alloc] init];
        _orderVC.title = @"订单";
    }
    return _orderVC;
}
- (OrderFoodViewController *)orderFoodVC
{
    if (!_orderFoodVC) {
        _orderFoodVC = [[OrderFoodViewController alloc] init];
        _orderFoodVC.title = @"";
    }
    return _orderFoodVC;
}

//- (DemonViewController *)LifeVC
//{
//    if (!_LifeVC) {
//        _LifeVC = [[OrderMenuViewController alloc] init];
//        _LifeVC.title = @"订单";
//    }
//    return _LifeVC;
//}


- (MineCenterViewController *)MineVC
{
    if (!_MineVC) {
        _MineVC = [[MineCenterViewController alloc]init];
        _MineVC.title = @"";
    }
    return _MineVC;
}


@end
