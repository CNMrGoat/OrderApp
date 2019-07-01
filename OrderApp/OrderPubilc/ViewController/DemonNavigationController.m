//
//  DemonNavigationController.m
//  CSDirectBank
//
//  Created by 彭小坚 on 15/8/14.
//  Copyright (c) 2015年 彭小坚. All rights reserved.
//

#import "DemonNavigationController.h"

@interface DemonNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
{
    CGPoint startPoint;
}
@property(nonatomic,assign) NavigationPushType navigationPushType;
@property(nonatomic,assign) NavigationPopType navigationPopType;
@property(nonatomic,strong) UIPanGestureRecognizer *SysNormalPanGesture;/**<覆盖系统自带手势*/
@property(nonatomic,assign) BOOL canGestureBack;/**<是否手势滑动返回*/

#pragma mark - 自定义手势动画
@property (nonatomic,strong) UIPanGestureRecognizer *backPanGesture;/**<添加返回手势,子类可禁用此手势来禁用滑动返回*/
@property (nonatomic,strong) NSMutableArray *screenShotList;/**<缓存上级页面拍照*/
@property (nonatomic,strong) UIView *backGroundView;/**<中间遮罩*/
@property (nonatomic,strong) UIImageView *lastScreenShotView;/**<屏幕快照*/
@property (nonatomic,assign) BOOL isMoving;/**<是否滑动*/


-(void)handleNavigationTransition:(UIGestureRecognizer *)gesture;
@end

@implementation DemonNavigationController

#pragma mark -
#pragma mark life Cycle

+(void)initialize
{
    [self setNavigationBar];
    [self setBarItem];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationPopType = NavigationPopNormal;
    self.navigationPushType = NavigationPushCorver;
    [self setCanGestureBack:NO];
    self.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.backPanGesture.enabled = YES;
}

#pragma mark -
#pragma mark UINavBar 样式设置

+(void)setNavigationBar/**<设置导航背景，标题属性*/
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    shadow.shadowColor = nil;
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:[UIColor whiteColor]];
    bar.tintColor = [UIColor whiteColor];
    [bar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName : [UIColor whiteColor],
                                  NSShadowAttributeName : shadow,
                                  NSFontAttributeName : Demon_24_Font
                                  }];

    //    if (iOS8) {
    //        [bar setTranslucent:NO];
    //    }
}

+(void) setBarItem/**<设置barItem的样式*/
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setTintColor:CS_Color_DeepGray/*[UIColor whiteColor]*/];
    [barItem setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : CS_Color_DeepGray/*[UIColor whiteColor]*/,
                                      NSShadowAttributeName :
                                          shadow,
                                      NSFontAttributeName:Demon_16_Font

                                      } forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : CS_Color_DeepGray/*[UIColor whiteColor]*/,
                                      NSShadowAttributeName :
                                          shadow,
                                      NSFontAttributeName:Demon_16_Font

                                      } forState:UIControlStateHighlighted];
}

-(UIBarButtonItem *)createBackItem:(UIViewController *)viewController/**<返回按钮*/
{
    if(self.navigationPopType == NavigationPopToIgnore)
    {
        return nil;
    }
    UIImage *backImage = [UIImage imageNamed:@"nav_btn_back_black"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton setImage:backImage forState:UIControlStateHighlighted];
    backButton.imageEdgeInsets=UIEdgeInsetsMake(8, -8, 8, 24);
    if ([viewController isKindOfClass:[DemonViewController class]]) {
        [backButton addTarget:viewController action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)actionBack /**<返回方法*/
{
    [self.navigationController setCanGestureBack:NO];
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)setTitle:(NSString *)title/**<设置标题*/
{
    [super setTitle:title];
    NSDictionary *textAttr = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttr];
}

#pragma mark -
#pragma mark 父类方法重载

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated/**<重载推送方法,设置返回按钮*/
{
    if(!self.canGestureBack)
    {
        if (self.childViewControllers.count > 0) {
            viewController.hidesBottomBarWhenPushed = YES;
        }
        [super pushViewController:viewController animated:animated];
        return;
    }

    switch (self.navigationPushType)
    {
        case NavigationPushNormal:
        {
            [self.view addGestureRecognizer:self.SysNormalPanGesture];
        }
            break;
        case NavigationPushLinkage:
        {
            [self.view removeGestureRecognizer:self.SysNormalPanGesture];
            [self.screenShotList addObject:[self capture]];
            [self.view addGestureRecognizer:self.backPanGesture];

        }
            break;
        case NavigationPushCorver:
        {
            [self.view removeGestureRecognizer:self.SysNormalPanGesture];
            [self.screenShotList addObject:[self capture]];
            [self.view addGestureRecognizer:self.backPanGesture];
        }
            break;
    }
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1 && viewController.navigationItem.leftBarButtonItem == nil)
    {
        viewController.navigationItem.leftBarButtonItem = [self createBackItem:viewController];
        if (viewController.navigationItem.leftBarButtonItem == nil) {
            [viewController.navigationItem setHidesBackButton:YES];
        }
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (!self.canGestureBack && _navigationPopType != NavigationPopToRoot) {
        [super popViewControllerAnimated:animated];
        return nil;
    }
    if (_navigationPopType == NavigationPopToRoot)
    {
        [self popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self customPopViewControllerAnimated:animated];
    }
    return nil;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    self.backPanGesture.enabled = YES;
    [self.screenShotList removeAllObjects];
    return [super popToRootViewControllerAnimated:animated];
}

-(void)customPopViewControllerAnimated:(BOOL)animated
{
    switch (self.navigationPushType)
    {
        case NavigationPushNormal:
        {
            [super popViewControllerAnimated:animated];
        }
            break;
        case NavigationPushLinkage:
        {
            [self popAnimation];
        }
            break;
        case NavigationPushCorver:
        {
            [self popAnimation];
        }
            break;
    }
}

#pragma mark -
#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 1 && viewController.navigationItem.leftBarButtonItem == nil)
    {
        viewController.navigationItem.leftBarButtonItem = [self createBackItem:viewController];
        if (viewController.navigationItem.leftBarButtonItem == nil) {
            [viewController.navigationItem setHidesBackButton:YES];
        }
    }
}

#pragma mark -
#pragma mark Hanlde Action

- (void)backButtonAction /**<返回方法*/
{
    self.canGestureBack = NO;
    [self popViewControllerAnimated:YES];

}


#pragma mark -
#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count == 1)/**<表示用户在根控制器界面，就不需要触发滑动手势*/
    {
        return NO;
    }
    self.canGestureBack = YES;
    return YES;
}

#pragma mark -
#pragma mark 自定义手势 & 返回动画

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width

static CGFloat offset_float = 0.1;/**<拉伸参数*/
static CGFloat min_distance = 120;/**<最小回弹距离*/

- (void)popAnimation/**<自定义动画*/
{
    if (self.viewControllers.count == 1) return;

    [self createBackgroundView];

    [UIView animateWithDuration:0.4 animations:^{
        [self moveViewWithX:MainScreenWidth];
    }
                     completion:^(BOOL finished)
     {
         [self gestureAnimation:NO];
         _isMoving = NO;
         [_backGroundView setBackgroundColor:[UIColor purpleColor]];
         [_backGroundView removeFromSuperview];
     }];
}

- (void)addViewShadow:(UIView *)view/**<添加阴影*/
{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:view.bounds];
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    view.layer.shadowOpacity = 0.5f;
    view.layer.shadowPath = shadowPath.CGPath;
}

- (void)removeShadow:(UIView *)view/**<删除阴影*/
{
    view.layer.masksToBounds = YES;
    view.layer.shadowColor = nil;
    view.layer.shadowPath = nil;
    view.layer.shadowOpacity = 0.0f;
    view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (UIImage *)capture/**<获取屏幕快照*/
{
    UIGraphicsBeginImageContextWithOptions(KEY_WINDOW.bounds.size, KEY_WINDOW.opaque, 0.0);

    [KEY_WINDOW.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return img;
}

- (void)moveViewWithX:(float)x/**<动画 核心代码*/
{
    x = x>MainScreenWidth?MainScreenWidth:x;

    x = x<0?0:x;

    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;

    if (self.navigationPushType == NavigationPushLinkage)
    {
        self.lastScreenShotView.frame = (CGRect){-(MainScreenWidth*offset_float)+x*offset_float,0,MainScreenWidth,MainScreenHeight};
    }
}

- (void)gestureAnimation:(BOOL)animated/**<动画结束时处理*/
{
    [self removeShadow:self.view];
    [self.screenShotList removeLastObject];
    [super popViewControllerAnimated:animated];
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    self.view.frame = frame;
}

- (void)createBackgroundView /**<创建中间遮罩*/
{
    [self addViewShadow:self.view];
    [self.view.superview insertSubview:self.backGroundView belowSubview:self.view];

    [self.lastScreenShotView setImage:[self.screenShotList lastObject]];

    [self.backGroundView addSubview:self.lastScreenShotView];

    _backGroundView.hidden = NO;
}

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer/**<手势滑动处理*/
{
    if (self.viewControllers.count <= 1) return; /**<根视图不能滑动返回*/

    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];/**<获取手势触摸点*/

    if (recoginzer.state == UIGestureRecognizerStateBegan) /**<开始滑动*/
    {
        _isMoving = YES;

        startPoint = touchPoint;

        [self createBackgroundView];
    }
    else if (recoginzer.state == UIGestureRecognizerStateEnded)/**<滑动结束，判断是左还是右*/
    {
        if (touchPoint.x - startPoint.x > min_distance)
        {
            [UIView animateWithDuration:0.3 animations:^{

                [self moveViewWithX:MainScreenWidth];

            } completion:^(BOOL finished) {
                [self gestureAnimation:NO];

                CGRect frame = self.view.frame;

                frame.origin.x = 0;

                self.view.frame = frame;

                _isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;

                self.backGroundView.hidden = YES;
            }];

        }
        return;
    }
    else if (recoginzer.state == UIGestureRecognizerStateCancelled)/**<滑动取消时复原*/
    {

        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;

            self.backGroundView.hidden = YES;
        }];

        return;
    }
    if (_isMoving)/**<根据手势移动UI*/
    {
        [self moveViewWithX:touchPoint.x - startPoint.x];
    }
}

#pragma mark -
#pragma mark 系统滑动手势

-(void)handleNavigationTransition:(UIGestureRecognizer *)gesture/**<只是为了消除警告*/
{

}

#pragma mark -
#pragma mark setter & getter

-(UIPanGestureRecognizer *)backPanGesture
{
    if (_backPanGesture == nil && _canGestureBack)
    {
        self.interactivePopGestureRecognizer.enabled = NO;
        _backPanGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
        [_backPanGesture delaysTouchesBegan];
    }
    return _backPanGesture;
}

- (UIPanGestureRecognizer *)SysNormalPanGesture
{
    if (_SysNormalPanGesture == nil && _canGestureBack)
    {
        id target = self.interactivePopGestureRecognizer.delegate;
        _SysNormalPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
        _SysNormalPanGesture.delegate = self;
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return _SysNormalPanGesture;
}

-(NSMutableArray *)screenShotList
{
    if (!_screenShotList)
    {
        _screenShotList = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return _screenShotList;
}

- (UIView *)backGroundView
{
    if (!_backGroundView)
    {
        CGRect frame = self.view.frame;
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        _backGroundView.backgroundColor = [UIColor clearColor];
    }
    return _backGroundView;
}

-(UIImageView *)lastScreenShotView
{
    if (!_lastScreenShotView)
    {
        _lastScreenShotView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }

    if (self.navigationPushType == NavigationPushCorver)
    {
        _lastScreenShotView.frame = (CGRect){0,0,MainScreenWidth,MainScreenHeight};
    }
    else if (self.navigationPushType == NavigationPushLinkage)
    {
        _lastScreenShotView.frame = (CGRect){-(MainScreenWidth*offset_float),0,MainScreenWidth,MainScreenHeight};
    }
    return _lastScreenShotView;
}

- (void)setNavigationPopType:(NavigationPopType)navigationPopType
{
    _navigationPopType = navigationPopType;

    if (navigationPopType == NavigationPopToRoot)
    {
        [self.screenShotList removeAllObjects];
        self.canGestureBack = NO;
        [self.view removeGestureRecognizer:self.backPanGesture];
        [self.view removeGestureRecognizer:self.SysNormalPanGesture];
    }
    else if (navigationPopType ==NavigationPopToIgnore) {
        return;
    }
}

- (void)setCanGestureBack:(BOOL)canGestureBack
{
    _canGestureBack = canGestureBack;
    if (!canGestureBack)
    {
        [self.view removeGestureRecognizer:self.SysNormalPanGesture];
        [self.view removeGestureRecognizer:self.backPanGesture];
    }
}


@end


/*!
 *  @author 彭小坚, 15-08-18 11:08:52
 *
 *  @brief  NavigationController 拓展
 *
 *  @since 3.0.1
 */
@implementation UINavigationController (Extend)

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated pushType:(NavigationPushType)type
{
    DemonNavigationController *extenSelf = (DemonNavigationController *)self;
    if ([extenSelf respondsToSelector:@selector(setNavigationPushType:)]) {
        extenSelf.navigationPushType = type;
    }
    [extenSelf pushViewController:viewController animated:animated];
}

-(void)setCanGestureBack:(BOOL)boolValue
{
    DemonNavigationController *navgationController = (DemonNavigationController *)self;
    if ([navgationController respondsToSelector:@selector(setCanGestureBack:)]) {
        navgationController.canGestureBack = boolValue;
    }
}

-(void)setPopType:(NavigationPopType)type
{
    DemonNavigationController *navgationController = (DemonNavigationController *)self;
    if ([navgationController respondsToSelector:@selector(setNavigationPopType:)]) {
        navgationController.navigationPopType = type;
    }
}

-(void)pushToVC:(UIViewController *)vc
{
    vc.hidesBottomBarWhenPushed = YES;
    NSArray *ns = self.viewControllers;
    NSArray *new = @[ns[0], vc];
    [self setViewControllers:new animated:YES];
}

- (void)pushToNextVC:(UIViewController *)vc
{
    vc.hidesBottomBarWhenPushed = YES;
    NSArray *ns = self.viewControllers;
    NSArray *new = @[ns[0],ns[1],vc];
    [self setViewControllers:new animated:YES];
}
- (void)popToVCClass:(Class)VCClass animated:(BOOL)animated
{
    NSArray *controllers =  self.viewControllers;
    [controllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:VCClass]) {
            [self popToViewController:obj animated:animated];
            *stop = YES;
        }
    }];
}

- (void)pushToVC:(UIViewController *)pushVc fromClass:(Class)fromClass animated:(BOOL)animated;
{

    NSArray *ns = self.viewControllers;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [ns enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:vc];
        if ([vc isKindOfClass:[fromClass class]]) {
            *stop = YES;
        }
    }];
    [array addObject:pushVc];
    [self setViewControllers:array animated:animated];


}

- (void)popToBeforeViewController:(NSInteger)integer animated:(BOOL)animated
{
    if (integer <= 0) {
        return;
    }
    
    NSInteger index = self.viewControllers.count - integer - 1;
    if (index < 0) {
        return;
    }
    
    UIViewController *vc = self.viewControllers[index];
    [self popToViewController:vc animated:animated];
}



@end
