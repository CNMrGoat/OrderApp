//
//  NetUrlHeader.h
//  OrderApp
//
//  Created by zhangfan on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#ifndef NetUrlHeader_h
#define NetUrlHeader_h


//用户登录
#define MemberVerifyLoginHttp             @"/memberVerifyLogin"     //验证码登录
#define MemberPwdLoginHttp     @"/memberPwdLogin"         //密码登录
#define MemTokenLoginHttp     @"/memTokenLogin"         //token登录

//找回密码
#define MemberFindPwdHttp     @"/memberFindPwd"         //找回密码

//注册
#define WxLoginHttp     @"/wxLogin"         //微信授权登录
#define WxBindMobileHttp     @"​/wxBindMobile"         //微信手机捆绑

//用户
#define OrderMercListHttp     @"/orderMercList"         //点餐商家列表
#define MercGoodsInfoHttp     @"/mercGoodsInfo"         //商家店铺点单界面
#define AddGoodsCacheHttp     @"​/addGoodsCache"         //单个商品每次加减触发提交
#define SubOrderAndPayHttp     @"/SubOrderAndPay"         //确认提交订单
#define ShowOrderDetailHttp     @"/showOrderDetail"         //订单展示
#define DelOrderHttp     @"/delOrder"         //删除订单
#define OrderInfoHttp     @"/orderInfo"         //订单详情
#define SubAdviceHttp     @"/subAdvice"         //意见反馈
#define UserInfoHttp     @"/userInfo"         //用户信息获取
#define EditUserInfoHttp     @"/editUserInfo"         //编辑用户信息
#define ChangeMobileHttp     @"/changeMobile"         //更换手机号


//用户推出登录
#define MemLayoutHttp     @"/memLayout"         //推出登录

//七牛云
#define QntokenHttp     @"/qntoken"  //七牛上次token

//短信发送
#define SendCodeHttp     @"/sendCode"  //发送短信

#endif /* NetUrlHeader_h */
