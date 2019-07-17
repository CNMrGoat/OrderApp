//
//  AppDelegate.m
//  OrderApp
//
//  Created by 豪锅锅 on 2019/6/24.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "AppDelegate.h"
#import "OrderTabBarController.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import "IQKeyboardManager.h"

@interface AppDelegate ()
@property(nonatomic,strong) DemonNavigationController *tabNavigationVC;
@property(nonatomic,strong) OrderTabBarController *tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    /**<给islogin*/   
    if ( [NSString isNilOrEmpty:MyUser.token]) {
        [MyDefaults removeObjectForKey:@"isLogin"];
    } else  {
        
        [self loginByToken];
        
    }
    
    [self keyboardSet];
    //开发者需要显式的调用此函数，日志系统才能工作
//    [UMCommonLogManager setUpUMCommonLogManager];
    [UMConfigure setLogEnabled:YES];
    
    [UMConfigure initWithAppkey:@"5d1aca124ca3576af50011a7" channel:@"App Store"];
    // U-Share 平台设置
    [self configUSharePlatforms];
    self.window.rootViewController = self.tabNavigationVC;
    return YES;
    
}

- (void)keyboardSet
{
    IQKeyboardManager * manager = [IQKeyboardManager sharedManager];
    // 点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //设置键盘textField的距离
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:10];
    //控制整个功能是否启用
    manager.enable = YES;

    //控制键盘上的工具条文字颜色是否用户自定义
    //    manager.shouldToolbarUsesTextFieldTintColor = YES;
    //控制是否显示键盘上的工具条
    manager.enableAutoToolbar = NO;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSLog(@"~~~~~~woyao~~~~~~~~~~~");
    
    
    if ( [NSString isNilOrEmpty:MyUser.token]) {
        [MyDefaults removeObjectForKey:@"isLogin"];
    } else  {
        
        [self loginByToken];
        
    }
    
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)loginByToken {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:MyUser.token forKey:@"token"];
    NSLog(@"~~~~~~~~~~~MyUser.token~~~ %@~~~~~~",MyUser.token);
    [NetworkClient RequestWithParameters:parameters withUrl:BASE_URLWith(MemTokenLoginHttp) needToken:NO success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSDictionary *dic = responseObject[@"data"];
        if ([@"2000" isEqualToString:codeStr]) {
            NSLog(@"登录成功");
            MyUser.comInfoArea = [NSString stringWithFormat:@"%@",dic[@"comInfo"][@"contactArea"]];
            MyUser.comInfoPerson = [NSString stringWithFormat:@"%@",dic[@"comInfo"][@"contactPerson"]];
            MyUser.comInfoMobile = [NSString stringWithFormat:@"%@",dic[@"comInfo"][@"mobile"]];
            MyUser.comInfoName = [NSString stringWithFormat:@"%@",dic[@"comInfo"][@"name"]];
            MyUser.comInfoUid = [NSString stringWithFormat:@"%@",dic[@"comInfo"][@"uid"]];
            MyUser.ctime = [NSString stringWithFormat:@"%@",dic[@"ctime"]];
            MyUser.headImgUrl = [NSString stringWithFormat:@"%@",dic[@"headImgUrl"]];
            MyUser.mobile = [NSString stringWithFormat:@"%@",dic[@"mobile"]];
            MyUser.nickName = [NSString stringWithFormat:@"%@",dic[@"nickName"]];
            MyUser.openid = [NSString stringWithFormat:@"%@",dic[@"openid"]];
            MyUser.signature = [NSString stringWithFormat:@"%@",dic[@"signature"]];
            MyUser.token = [NSString stringWithFormat:@"%@",dic[@"token"]];
            MyUser.uid = [NSString stringWithFormat:@"%@",dic[@"uid"]];
            MyUser.wallet = [NSString stringWithFormat:@"%@",dic[@"wallet"]];
            MyUser.isLogin = [NSString stringWithFormat:@"1"];
    
            
        } else {
            [MyDefaults removeObjectForKey:@"comInfoArea"];
            [MyDefaults removeObjectForKey:@"comInfoPerson"];
            [MyDefaults removeObjectForKey:@"comInfoMobile"];
            [MyDefaults removeObjectForKey:@"comInfoName"];
            [MyDefaults removeObjectForKey:@"comInfoUid"];
            [MyDefaults removeObjectForKey:@"ctime"];
            [MyDefaults removeObjectForKey:@"headImgUrl"];
            [MyDefaults removeObjectForKey:@"mobile"];
            [MyDefaults removeObjectForKey:@"nickName"];
            [MyDefaults removeObjectForKey:@"openid"];
            [MyDefaults removeObjectForKey:@"signature"];
            [MyDefaults removeObjectForKey:@"token"];
            [MyDefaults removeObjectForKey:@"uid"];
            [MyDefaults removeObjectForKey:@"wallet"];
            [MyDefaults removeObjectForKey:@"isLogin"];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark 友盟操作

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx10131f267a34f481" appSecret:@"894bcf7dd72d7da84dfdccc48ea82837" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1109591444"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
}

//#define __IPHONE_10_0    100000
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响。
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#pragma mark -
#pragma mark getter
- (UIWindow *)window
{
    if (!_window)
    {
        _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
        [_window makeKeyAndVisible];
    }
    return _window;
}

- (DemonNavigationController *)tabNavigationVC
{
    if (!_tabNavigationVC) {
        _tabNavigationVC = [[DemonNavigationController alloc]initWithRootViewController:self.tabBarController];
    }
    return _tabNavigationVC;
}

-(OrderTabBarController *)tabBarController
{
    if (!_tabBarController) {
        _tabBarController = [[OrderTabBarController alloc] init];
    }
    return _tabBarController;
}

@end
