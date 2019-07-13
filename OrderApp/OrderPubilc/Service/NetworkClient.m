//
//  NetworkClient.m
//  TheBase
//
//  Created by zhangfan on 2016/12/26.
//  Copyright © 2016年 MrGoat. All rights reserved.
//

#import "NetworkClient.h"
#import "LoginService.h"

@implementation NetworkClient


+ (void)RequestWithParameters:(NSMutableDictionary *)requestParameters withUrl:(NSString *)url needToken:(BOOL)needToken success:(FinishBlock)success failure:(ErrorBlock)failure
{
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = 15;// 十五秒后中断请求
    
    if (needToken == YES) {
        [manager.requestSerializer setValue:MyUser.token forHTTPHeaderField:@"token"];
        
        NSLog(@"--------token--------%@",MyUser.token);
    }
    
    
    [manager POST:url parameters:requestParameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        

        //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject
        //                                                            options:NSJSONReadingAllowFragments
        //                                                              error:&err];
        
        NSString *str =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [self dictionaryWithJsonString:str];
        
        if (dic) {

            success(dic);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSString* errorString;
        if (error.code == NSURLErrorTimedOut){
            errorString = (@"网络不给力，请稍后再试");
        }
        else if (error.code == NSURLErrorNotConnectedToInternet ){
            errorString = (@"无网络连接，请检查网络");

        } else if (error.code == NSURLErrorNetworkConnectionLost ) {
            errorString = (@"网络连接异常，请检查网络");
        }
        else if ( error.code == NSURLErrorCannotConnectToHost) {
            errorString = (@"服务器开小猜了!");
            
        } else if ( error.code == NSURLErrorCannotFindHost) {
            
            errorString = (@"找不到服务器!");
        } else {
            errorString = (@"请求数据失败，请稍后再试");
        }
        failure(error);
        
     
        
    }];
    
}


+ (void)ImageRequestWithUrl:(NSString *)url withArray:(NSArray *)array success:(FinishBlock)success failure:(ErrorBlock)failure
{
    
    NSLog(@"%@",array);
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (UIImage *img in array)
        {
            NSData *data = UIImageJPEGRepresentation(img, 0.5);
            [formData appendPartWithFileData:data
                                        name:@"positiveCard"
                                    fileName:@"filenanme.jpg"
                                    mimeType:@"image/jpeg"
             ];
        }
    } error:nil];
    [self afUrlSessionManagerWithUrlRequest:request object:success];
    
    
    
}


+ (void)ImageuploadWithRquest:(NSMutableDictionary *)requestParameters withUrl:(NSString *)url  withArray1:(NSArray *)array1 success:(FinishBlock)success failure:(ErrorBlock)failure {
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url  parameters:requestParameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        for (UIImage *img in array1)
        {
            NSData *data = UIImageJPEGRepresentation(img, 0.5);
            [formData appendPartWithFileData:data
                                        name:@"userPhoto"
                                    fileName:@"filenanme.jpg"
                                    mimeType:@"image/jpeg"
             ];
        }
    } error:nil];
    NSLog(@"%@",request);
    [self afUrlSessionManagerWithUrlRequest:request object:success];
    
    
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
    
}

+ (void)afUrlSessionManagerWithUrlRequest:(NSMutableURLRequest *)request object:(FinishBlock)completion
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",nil];
    
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          //[progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"上传数据流成功");
                          //                          NSLog(@"%@ %@", response, responseObject);
                          
                          NSError *err;
                          //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject
                          //                                                            options:NSJSONReadingAllowFragments
                          //                                                              error:&err];
                          
                          NSString *str =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                          
                          NSDictionary *dic = [self dictionaryWithJsonString:str];
                          
                          if (dic && !err) {
                              
                              completion(dic);
                          }
                          
                          
                      }
                  }];
    
    [uploadTask resume];
}



//+ (void)ImageRequestWithParameters:(NSMutableDictionary *)requestParameters withUrl:(NSString *)url withDeltaString:(NSString *)str  withArray1:(NSArray *)array1 withArray2:(NSArray *)array2 withArray3:(NSArray *)array3  withArray4:(NSArray *)array4 withArray5:(NSArray *)array5 withArray6:(NSArray *)array6 withArray7:(NSArray *)array7 withArray8:(NSArray *)array8 success:(FinishBlock)success failure:(ErrorBlock)failure{
//
//
//
//    NSString *jsonStr = [NSString convertToJsonData:requestParameters];
//    //加密
//    NSString *encryptDate = [SecurityUtil encryptAESData:jsonStr];
//    //    NSLog(@"%@",[url stringByAppendingString:encryptDate]);
//
//
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString: [url stringByAppendingString:encryptDate]  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//
//        [formData appendPartWithFormData:[str dataUsingEncoding:NSUTF8StringEncoding] name:@"delta"];
//
//        for (UIImage *img in array1)
//        {
//            NSData *data = UIImageJPEGRepresentation(img, 0.5);
//            [formData appendPartWithFileData:data
//                                        name:@"positiveCard"
//                                    fileName:@"filenanme.jpg"
//                                    mimeType:@"image/jpeg"
//             ];
//        }
//
//        for (UIImage *img in array2)
//        {
//            NSData *data = UIImageJPEGRepresentation(img, 0.5);
//            [formData appendPartWithFileData:data
//                                        name:@"backCard"
//                                    fileName:@"filenanme.jpg"
//                                    mimeType:@"image/jpeg"
//             ];
//        }
//
//        for (NSData *data in array3)
//        {
//            //            NSData *data = UIImageJPEGRepresentation(img, 1);
//            [formData appendPartWithFileData:data
//                                        name:@"mvpFile"
//                                    fileName:@"filenanme.jpg"
//                                    mimeType:@"image/jpeg"
//             ];
//        }
//
//        for (UIImage *img in array4)
//        {
//            NSData *data = UIImageJPEGRepresentation(img, 0.5);
//            [formData appendPartWithFileData:data
//                                        name:@"shouCard"
//                                    fileName:@"filenanme.jpg"
//                                    mimeType:@"image/jpeg"
//             ];
//        }
//
//        for (NSData *data in array5)
//        {
//            //            NSData *data = UIImageJPEGRepresentation(img, 1);
//            [formData appendPartWithFileData:data
//                                        name:@"falseFile"
//                                    fileName:@"filenanme.jpg"
//                                    mimeType:@"image/jpeg"
//             ];
//        }
//
//        for (NSData *data in array6)
//        {
//            //            NSData *data = UIImageJPEGRepresentation(img, 1);
//            [formData appendPartWithFileData:data
//                                        name:@"action1"
//                                    fileName:@"filenanme.jpg"
//                                    mimeType:@"image/jpeg"
//             ];
//        }
//
//
//        for (NSData *data in array7)
//        {
//            //            NSData *data = UIImageJPEGRepresentation(img, 1);
//            [formData appendPartWithFileData:data
//                                        name:@"action2"
//                                    fileName:@"filenanme.jpg"
//                                    mimeType:@"image/jpeg"
//             ];
//        }
//
//        for (NSData *data in array8)
//        {
//            //            NSData *data = UIImageJPEGRepresentation(img, 1);
//            [formData appendPartWithFileData:data
//                                        name:@"action3"
//                                    fileName:@"filenanme.jpg"
//                                    mimeType:@"image/jpeg"
//             ];
//        }
//
//
//    } error:nil];
//
//
//    NSLog(@"%@",request);
//    [self afUrlSessionManagerWithUrlRequest:request object:success];
//
//}






@end
