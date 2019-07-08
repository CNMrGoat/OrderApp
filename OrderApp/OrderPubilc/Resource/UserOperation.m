//
//  UserOperation.m
//  EightCat
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UserOperation.h"

@implementation UserOperation

SingletonM(user);

- (void)setComInfoMobile:(NSString *)comInfoMobile{
    [MyDefaults setObject:comInfoMobile forKey:@"comInfoMobile"];
    [MyDefaults synchronize];
}
- (NSString *)comInfoMobile
{
    NSString *comInfoMobile = [MyDefaults objectForKey:@"comInfoMobile"];
    if (!comInfoMobile) {
        comInfoMobile = @"";
    }
    return comInfoMobile;
}

- (void)setComInfoName:(NSString *)comInfoName{
    [MyDefaults setObject:comInfoName forKey:@"comInfoName"];
    [MyDefaults synchronize];
}

- (NSString *)comInfoName
{
    NSString *comInfoName = [MyDefaults objectForKey:@"comInfoName"];
    if (!comInfoName) {
        comInfoName = @"";
    }
    return comInfoName;
}


- (void)setComInfoUid:(NSString *)comInfoUid{
    [MyDefaults setObject:comInfoUid forKey:@"comInfoUid"];
    [MyDefaults synchronize];
}

- (NSString *)comInfoUid
{
    NSString *comInfoUid = [MyDefaults objectForKey:@"comInfoUid"];
    if (!comInfoUid) {
        comInfoUid = @"";
    }
    return comInfoUid;
}

- (void)setPassword:(NSString *)password{
    [MyDefaults setObject:password forKey:@"password"];
    [MyDefaults synchronize];
}

- (NSString *)password
{
    NSString *password = [MyDefaults objectForKey:@"password"];
    if (!password) {
        password = @"";
    }
    return password;
}


- (void)setCtime:(NSString *)ctime{
    [MyDefaults setObject:ctime forKey:@"ctime"];
    [MyDefaults synchronize];
}

- (NSString *)ctime
{
    NSString *ctime = [MyDefaults objectForKey:@"ctime"];
    if (!ctime) {
        ctime = @"";
    }
    return ctime;
}



- (void)setHeadImgUrl:(NSString *)headImgUrl{
    [MyDefaults setObject:headImgUrl forKey:@"headImgUrl"];
    [MyDefaults synchronize];
}
- (NSString *)headImgUrl
{
    NSString *headImgUrl = [MyDefaults objectForKey:@"headImgUrl"];
    if (!headImgUrl) {
        headImgUrl = @"";
    }
    return headImgUrl;
}


- (void)setMobile:(NSString *)mobile{
    [MyDefaults setObject:mobile forKey:@"mobile"];
    [MyDefaults synchronize];
}
- (NSString *)mobile
{
    NSString *mobile = [MyDefaults objectForKey:@"mobile"];
    if (!mobile) {
        mobile = @"";
    }
    return mobile;
}



- (void)setNickName:(NSString *)nickName{
    [MyDefaults setObject:nickName forKey:@"nickName"];
    [MyDefaults synchronize];
}
- (NSString *)nickName
{
    NSString *nickName = [MyDefaults objectForKey:@"nickName"];
    if (!nickName) {
        nickName = @"";
    }
    return nickName;
}


- (void)setOpenid:(NSString *)openid{
    [MyDefaults setObject:openid forKey:@"openid"];
    [MyDefaults synchronize];
}

- (NSString *)openid
{
    NSString *openid = [MyDefaults objectForKey:@"openid"];
    if (!openid) {
        openid = @"";
    }
    return openid;
}



- (void)setSignature:(NSString *)signature{
    [MyDefaults setObject:signature forKey:@"signature"];
    [MyDefaults synchronize];
}
- (NSString *)signature
{
    NSString *signature = [MyDefaults objectForKey:@"signature"];
    if (!signature) {
        signature = @"";
    }
    return signature;
}



/*
 *用户登录鉴权Token
 *
 */
- (void)setToken:(NSString *)token{
    [MyDefaults setObject:token forKey:@"token"];
    [MyDefaults synchronize];
}
- (NSString *)token
{
    NSString *token = [MyDefaults objectForKey:@"token"];
    if (!token) {
        token = @"";
    }
    return token;
}

- (void)setUid:(NSString *)uid{
    [MyDefaults setObject:uid forKey:@"uid"];
    [MyDefaults synchronize];
}
- (NSString *)uid
{
    NSString *uid = [MyDefaults objectForKey:@"uid"];
    if (!uid) {
        uid = [NSString stringWithFormat:@"%@",@""];
    }
    return uid;
}

- (void)setWallet:(NSString *)wallet{
    [MyDefaults setObject:wallet forKey:@"wallet"];
    [MyDefaults synchronize];
}
- (NSString *)wallet{
    NSString *wallet = [MyDefaults objectForKey:@"wallet"];
    if (!wallet) {
        wallet = [NSString stringWithFormat:@"%@",@""];
    }
    return wallet;
}


@end
