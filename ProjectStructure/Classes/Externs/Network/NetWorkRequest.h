//
//  NetWorkRequest.h
//  PHFinancial
//
//  Created by fanxiaobin on 2017/11/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface NetWorkRequest : NSObject

@property (nonatomic,copy) void (^block) (AFNetworkReachabilityStatus netStatus);

///网络状态监测
+ (void)networkReachabilityStatusMonitoring:(void (^) (AFNetworkReachabilityStatus netStatus))block;
///停止网络状态监测
+ (void)networkReachabilityStopMonitoring;


///GET请求
+ (NSURLSessionDataTask *)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView;

///POST请求
+ (NSURLSessionDataTask *)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView;

+ (NSURLSessionDataTask *)PUT:(NSString *)url parameters:(id )parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView;

+ (NSURLSessionDataTask *)DELETE:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView;

+ (NSURLSessionDataTask *)Upload:(NSString *)url parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBody success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView;


///上传图片
+ (void)uploadImages:(NSArray *)images url:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^) (NSError *error))failure;

///获取网络请求失败相应的提示文本
+(NSString *)messageWithNetworkError:(NSError *)error;

+(void)cancelAllNetworkRequest;


@end
