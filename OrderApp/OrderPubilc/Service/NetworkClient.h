//
//  NetworkClient.h
//  TheBase
//
//  Created by zhangfan on 2016/12/26.
//  Copyright © 2016年 MrGoat. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FinishBlock)(id responseObject);
typedef void(^ErrorBlock)(NSError *error);



@interface NetworkClient : NSObject


+ (void)RequestWithParameters:(NSMutableDictionary *)requestParameters withUrl:(NSString *)url needToken:(BOOL)needToken success:(FinishBlock)success failure:(ErrorBlock)failure;

+ (void)ImageuploadWithRquest:(NSMutableDictionary *)requestParameters withUrl:(NSString *)url  withArray1:(NSArray *)array1 success:(FinishBlock)success failure:(ErrorBlock)failure;

+ (void)ImageRequestWithUrl:(NSString *)url withArray:(NSArray *)array success:(FinishBlock)success failure:(ErrorBlock)failure;


//+ (void)ImageRequestWithParameters:(NSMutableDictionary *)requestParameters withUrl:(NSString *)url withDeltaString:(NSString *)str  withArray1:(NSArray *)array1 withArray2:(NSArray *)array2 withArray3:(NSArray *)array3  withArray4:(NSArray *)array4 withArray5:(NSArray *)array5 withArray6:(NSArray *)array6 withArray7:(NSArray *)array7 withArray8:(NSArray *)array8 success:(FinishBlock)success failure:(ErrorBlock)failure;


@end


