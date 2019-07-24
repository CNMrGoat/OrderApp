//
//  OrderCenterModel.h
//  OrderApp
//
//  Created by zhangfan on 2019/6/27.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface OrderheadVCenterModel : NSObject

@property(nonatomic,copy)NSString *headImgUrl;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,copy)NSString *signature;

@end



@class WalletData;
@interface WalletModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *interfaceName;

@end
@interface WalletData : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *changeType;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *cTime;

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, copy) NSString *comName;

@end

NS_ASSUME_NONNULL_END
