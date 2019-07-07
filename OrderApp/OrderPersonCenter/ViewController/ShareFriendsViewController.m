//
//  ShareFriendsViewController.m
//  OrderApp
//
//  Created by zhangfan on 2019/6/26.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import "ShareFriendsViewController.h"
#import "UIButton+Extend.h"

#import <UShareUI/UShareUI.h>

@interface ShareFriendsViewController ()

@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UIView *backView;

@end

@implementation ShareFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"推荐好友";
    [self addView];
}

- (void)addView {
    
    [self.view addSubview:self.logoView];
    [self.view addSubview:self.backView];
    
    
    [self makeUpconstraint];
    [self addBtnView];
}

#pragma mark -
#pragma mark getter

- (UIImageView *)logoView
{
    if (!_logoView) {
        _logoView = [[UIImageView alloc] init];
        [_logoView border:CS_Color_BackZhuti width:4];
        _logoView.image = [UIImage imageNamed:@"APP端下载"];
    }
    return _logoView;
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UILabel alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}


- (void)btnClick:(UIButton *)sender {
    
    NSLog(@"%ld",sender.tag);
    
    
    switch (sender.tag) {
        case 1001:
        {
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
        }
            break;
        case 1002:
        {
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
        }
            break;
            
        case 1003:
        {
            [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];
        }
            break;
            
        case 1004:
        {
            [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
        }
            break;
            
        default:
            break;
    }
    
    //    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone)]];
    //    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
    //        // 根据获取的platformType确定所选平台进行下一步操作
    //    }];
    
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

#pragma mark -
#pragma mark 约束适配
- (void)makeUpconstraint {
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-SafeAreaBottomHeight+49);
        make.height.mas_equalTo(120);
    }];
    

    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.top.mas_equalTo(SafeAreaTopHeight+10);
        make.bottom.mas_equalTo(self.backView.mas_top).offset(-10);
        make.width.mas_equalTo(SCREEN_WIDTH-120);
    }];
}

-(void)addBtnView {
    
    
    CGFloat btnWH = 60;

    CGFloat margin = (SCREEN_WIDTH - 60*4)/4;

    CGFloat x = 0;

    NSArray *titleArr = @[@"朋友圈",@"微信",@"QQ好友",@"QQ空间"];
    NSArray *imgArr = @[@"朋友圈",@"微信",@"qq",@"QQ空间"];

    for (int i = 0 ; i < titleArr.count; i++) {

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 1001 + i;
        x =   margin/2 + i * (btnWH + margin);

        btn.frame = CGRectMake(x,SCREEN_HEIGHT - 90-SafeAreaBottomHeight+49 -15, btnWH,90);

        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = Demon_13_Font;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];

        [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:8];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:btn];

    }
    
}

@end
