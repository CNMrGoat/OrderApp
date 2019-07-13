//
//  UserOperation.h
//  EightCat
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface UserOperation : NSObject
SingletonH(user);


@property(nonatomic,copy)NSString *comInfoMobile;
@property(nonatomic,copy)NSString *comInfoName;
@property(nonatomic,copy)NSString *comInfoUid;

@property(nonatomic,copy)NSString *ctime;
@property(nonatomic,copy)NSString *headImgUrl;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *openid;
@property(nonatomic,copy)NSString *signature;
@property(nonatomic,copy)NSString *password;

@property (nonatomic ,copy) NSString *isLogin;

/**
 *登录token
 */
@property(nonatomic,copy)NSString *token;


@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *wallet;



@end
