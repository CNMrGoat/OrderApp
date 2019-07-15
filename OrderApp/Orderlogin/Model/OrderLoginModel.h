//
//  OrderLoginModel.h
//  OrderApp
//
//  Created by zhangfan on 2019/7/6.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderLoginModel : NSObject

@end

@interface wxLoginRequestModel : NSObject

@property (nonatomic, copy) NSString * openid;
@property (nonatomic, copy) NSString * headImgUrl;
@property (nonatomic, copy) NSString * nickName;
@property (nonatomic, copy) NSString * mobile;

@end

NS_ASSUME_NONNULL_END
