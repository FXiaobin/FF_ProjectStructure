//
//  NetWorkRequest.m
//  PHFinancial
//
//  Created by fanxiaobin on 2017/11/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "NetWorkRequest.h"
#import "MBProgressHUD+Alert.h"

typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGet = 0,
    RequestTypePost,
    RequestTypeUpload,
    RequestTypePut,
    RequestTypeDelete
};

@interface NetWorkRequest ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation NetWorkRequest


///网络状态监测
+ (void)networkReachabilityStatusMonitoring:(void (^) (AFNetworkReachabilityStatus netStatus))block{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (block) {
            block(status);
        }
    }];
}

///停止网络状态监测
+ (void)networkReachabilityStopMonitoring{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

-(instancetype)init{
    if (self = [super init]) {
        self.manager = [AFHTTPSessionManager manager] ;
        [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.manager.requestSerializer.timeoutInterval = 20.f;
        [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        NSSet *set = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json", @"application/json;charset=UTF-8", @"application/x-www-form-urlencoded", nil];
        self.manager.responseSerializer.acceptableContentTypes = set;
        
        // 开始设置请求头
        //[self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static NetWorkRequest *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[NetWorkRequest alloc] init];
    });
    return _sharedInstance;
}

/// GET
+ (NSURLSessionDataTask *)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView {
    
    return [NetWorkRequest requestUrl:url parameters:parameters requestType:RequestTypeGet constructingBodyWithBlock:nil success:success failure:failure withShowView:showView];
}

/// POST
+ (NSURLSessionDataTask *)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView {
    
    return [NetWorkRequest requestUrl:url parameters:parameters requestType:RequestTypePost constructingBodyWithBlock:nil success:success failure:failure withShowView:showView];
}

/// PUT
+ (NSURLSessionDataTask *)PUT:(NSString *)url parameters:(id )parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView {
    
    return [NetWorkRequest requestUrl:url parameters:parameters requestType:RequestTypePut constructingBodyWithBlock:nil success:success failure:failure withShowView:showView];
}

/// DELETE
+ (NSURLSessionDataTask *)DELETE:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView {
    
    return [NetWorkRequest requestUrl:url parameters:parameters requestType:RequestTypeDelete constructingBodyWithBlock:nil success:success failure:failure withShowView:showView];
}

/// Upload
+ (NSURLSessionDataTask *)Upload:(NSString *)url parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBody success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView {
    
    return [NetWorkRequest requestUrl:url parameters:parameters requestType:RequestTypeUpload constructingBodyWithBlock:constructingBody success:success failure:failure withShowView:showView];
}


+ (NSURLSessionDataTask *)requestUrl:(NSString *)urlString parameters:(NSDictionary *)parameters requestType:(RequestType)type constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBody success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure withShowView:(UIView *)showView{
    
    NetWorkRequest *network = [NetWorkRequest sharedInstance];
    // 处理中文和空格问题
    NSString *url = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    switch (type) {
        case RequestTypeGet: {
            
            NSURLSessionDataTask *task = [network.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                ///隐藏loading
                [MBProgressHUD hiddenHUDWithShowView:showView];
                
                if (success) {
                    success(responseObject);
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
                
                [self showErrorInfoWithError:error showView:showView];
                
            }];
            return task;
            
        }   break;
            
        case RequestTypePost: {
            NSURLSessionDataTask *task = [network.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                ///隐藏loading
                [MBProgressHUD hiddenHUDWithShowView:showView];
                
                if (success) {
                    success(responseObject);
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
                
                [self showErrorInfoWithError:error showView:showView];
                
            }];
            return task;
            
        }   break;
            
        case RequestTypePut: {
            NSURLSessionDataTask *task = [network.manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                ///隐藏loading
                [MBProgressHUD hiddenHUDWithShowView:showView];
                
                if (success) {
                    success(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure) {
                    failure(error);
                }
                [self showErrorInfoWithError:error showView:showView];
            }];
            return task;
            
        }   break;
            
        case RequestTypeDelete: {
            NSURLSessionDataTask *task = [network.manager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                ///隐藏loading
                [MBProgressHUD hiddenHUDWithShowView:showView];
                
                if (success) {
                    success(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure) {
                    failure(error);
                }
                [self showErrorInfoWithError:error showView:showView];
            }];
            return task;
            
        }   break;
            
        case RequestTypeUpload: {
            NSURLSessionDataTask *task = [network.manager POST:url parameters:parameters constructingBodyWithBlock:constructingBody progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                ///隐藏loading
                [MBProgressHUD hiddenHUDWithShowView:showView];
                
                if (success) {
                    success(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure) {
                    failure(error);
                }
                [self showErrorInfoWithError:error showView:showView];
            }];
            return task;
            
        }   break;
            
        default:
            break;
    }
   
    return nil;
}

+ (void)uploadImages:(NSArray *)images url:(NSString *)urlString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^) (NSError *error))failure{
    
    NetWorkRequest *network = [NetWorkRequest sharedInstance];
    
    [network.manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < images.count; i++) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            ///name:@"image"中的image为后台接收图片的参数 要根据后台字段来修改
            [formData appendPartWithFileData:UIImageJPEGRepresentation(images[i],0.5) name:@"image" fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DDLog(@"%@", error.localizedDescription);
        failure(error);
    }];
    
}

// 暂时用不到
+ (void)showErrorInfoWithError:(NSError *)error showView:(UIView *)showView {
    if (!showView) return;
    
    [MBProgressHUD hiddenHUDWithShowView:showView];
    
    NSString *message = [self messageWithNetworkError:error];
    [MBProgressHUD showAlert:message image:nil toView:showView];
}

///获取网络请求失败相应的提示文本
+(NSString *)messageWithNetworkError:(NSError *)error{
    
    NSHTTPURLResponse *httpResponse = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
    NSInteger statusCode = httpResponse.statusCode;
    NSString *message = nil;
    
    switch (statusCode) {
        case 401: {} break;
            
        case 500: { message = @"服务器异常！";} break;
            
        case -1001: { message = @"网络请求超时，请稍后重试！";} break;
            
        case -1002: { message = @"不支持的URL！";} break;
            
        case -1003: { message = @"未能找到指定的服务器！";} break;
            
        case -1004: { message = @"服务器连接失败！";} break;
            
        case -1005: { message = @"连接丢失，请稍后重试！";} break;
            
        case -1009: { message = @"互联网似乎是离线的哦";} break;
            
        case -1012: { message = @"操作无法完成！";} break;
            
        default: { message = @"网络请求发生未知错误！";} break;
    }
    
    return message;
}

+(void)cancelAllNetworkRequest{
    [[NetWorkRequest sharedInstance].manager.operationQueue cancelAllOperations];
}

@end
