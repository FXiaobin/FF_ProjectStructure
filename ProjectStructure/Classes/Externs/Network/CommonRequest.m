//
//  CommonRequest.m
//  ProjectStructure
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import "CommonRequest.h"

#import "NetWorkRequest.h"
#import "NetWorkServerURL.h"
#import "FFCommonModel.h"

@implementation CommonRequest

+(void)deleteMyVideoRequestWithVideoId:(NSString *)videoId completed:(dispatch_block_t)completed{
    
    NSString *url = [NetWorkServerURL delete_my_video];
    NSDictionary *para = @{@"videoId" : videoId};
    
    [NetWorkRequest DELETE:url parameters:para success:^(id responseObject) {
        
        if (completed) {
            completed();
        }
        
    } failure:^(NSError *error) {
        
    } withShowView:nil];
    
}

+(void)deleteMyVideoRequestWithVideoId:(NSString *)videoId success:(successBlock)success failuer:(failuerBlock)failuer{
    
    NSString *url = [NetWorkServerURL delete_my_video];
    NSDictionary *para = @{@"videoId" : videoId};
    
    [NetWorkRequest DELETE:url parameters:para success:^(id responseObject) {
                
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSError *error) {
        if (failuer) {
            failuer(error);
        }
        
    } withShowView:nil];
    
}



@end
