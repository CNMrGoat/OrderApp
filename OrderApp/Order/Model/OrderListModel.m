//
//Created by ESJsonFormatForMac on 19/07/08.
//

#import "OrderListModel.h"
@implementation OrderListModel

@end

@implementation DataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [ListModel class]};
}

@end


@implementation ListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"sunList" : [SunlistModel class]};
}

@end


@implementation SunlistModel

@end


