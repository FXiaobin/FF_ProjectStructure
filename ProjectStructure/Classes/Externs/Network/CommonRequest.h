//
//  CommonRequest.h
//  ProjectStructure
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 healifeGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NetWorkServerURL.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^successBlock)(id responseObject);
typedef void(^failuerBlock)(NSError *error);

@interface CommonRequest : NSObject

+(void)deleteMyVideoRequestWithVideoId:(NSString *)videoId completed:(dispatch_block_t)completed;

+(void)deleteMyVideoRequestWithVideoId:(NSString *)videoId success:(successBlock)success failuer:(failuerBlock)failuer;


@end

NS_ASSUME_NONNULL_END
