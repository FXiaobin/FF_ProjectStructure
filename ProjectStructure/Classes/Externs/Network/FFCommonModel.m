//
//  FFCommonModel.m
//  FFCommonProject
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "FFCommonModel.h"
#import <MJExtension.h>

///要根据自己后台返回的状态码来决定
#define SUCCESS_CODE    0

@implementation FFCommonModel


- (BOOL)isSuccess {
    return self.error_code == SUCCESS_CODE;
}

+(FFCommonModel *)commonWithResponseObject:(id)responseObject dataClass:(Class)cls{
    FFCommonModel *model = nil;
    
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        model = [FFCommonModel mj_objectWithKeyValues:responseObject];
    }
    
    if (model.entity && cls) {
        model.entity = [cls mj_objectWithKeyValues:model.entity];
    }
    
    if (model.data && cls) {
        model.data = [cls mj_objectArrayWithKeyValuesArray:model.data];
    }
  
    return model;
}

+(FFCommonModel *)commonWithResponseObject:(id)responseObject{
    return [self commonWithResponseObject:responseObject dataClass:nil];
}

@end
