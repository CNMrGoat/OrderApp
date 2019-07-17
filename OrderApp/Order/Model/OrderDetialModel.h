//
//Created by ESJsonFormatForMac on 19/07/09.
//

#import <Foundation/Foundation.h>

@class DetailData,DetailList;
@interface OrderDetialModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) DetailData *data;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, copy) NSString *interfaceName;

@end
@interface DetailData : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *ctime;

@property (nonatomic, copy) NSString *canelTime;

@property (nonatomic, copy) NSString *sendTime;

@property (nonatomic, copy) NSString *qrCodeParam;

@property (nonatomic, copy) NSString *mercname;

@property (nonatomic, copy) NSString *comname;

@property (nonatomic, copy) NSString *orderNum;

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *userDesc;

@end

@interface DetailList : NSObject

@property (nonatomic, copy) NSString *orderNum;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *goodName;

@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) NSString *ctime;

@property (nonatomic, copy) NSString *mercname;

@property (nonatomic, copy) NSString *comname;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger goodsId;

@end

