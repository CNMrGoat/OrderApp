//
//Created by ESJsonFormatForMac on 19/07/08.
//

#import <Foundation/Foundation.h>

@class DataModel,ListModel,SunlistModel;
@interface OrderListModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) DataModel *data;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *interfaceName;

@end
@interface DataModel : NSObject

@property (nonatomic, assign) NSInteger count;//数量

@property (nonatomic, strong) NSArray *list;//列表

@end

@interface ListModel : NSObject

@property (nonatomic, assign) NSInteger status;//状态 int  1已支付    2 已取消   3商家确认订单    4 已完成

@property (nonatomic, copy) NSString *ctime;//下单时间

@property (nonatomic, strong) NSArray *sunList;

@property (nonatomic, copy) NSString *mercname;//商户名称

@property (nonatomic, copy) NSString *comname;//公司名称

@property (nonatomic, copy) NSString *orderNum;//单号

@property (nonatomic, copy) NSString *desc;//描述

@end

@interface SunlistModel : NSObject

@property (nonatomic, copy) NSString *pic;//图片url

@property (nonatomic, copy) NSString *price;//价格

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *mercname;

@property (nonatomic, copy) NSString *num;//数量

@property (nonatomic, copy) NSString *goodName;//物品名称

@property (nonatomic, copy) NSString *desc;//描述

@end

