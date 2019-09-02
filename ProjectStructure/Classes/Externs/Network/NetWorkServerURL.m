//
//  NetWorkServerURL.m
//  FFCommonProject
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "NetWorkServerURL.h"

/// 0 测试 1 正式
#define kServerIsProduction     0

#define kServerURL(subURL)   [NSString stringWithFormat:@"%@/%@", [self Main_Server_URL] , subURL]

@implementation NetWorkServerURL

///服务器地址
+ (NSString *)Main_Server_URL{
    if (kServerIsProduction) {
        return @"http://xxh.mqcll.cn/";
        
    }else{
        return @"http://192.168.13.88/mqcll.cn";
    }
    
}

///不带参数的
+ (NSString *)homePage_URL{
    return kServerURL(@"homePage/getData/page");
}

///带参数的
+ (NSString *)collectionGoodsWithGoodsId:(NSString *)goodsId{
    NSString *urlStr = kServerURL(@"collection/goods");
    return [NSString stringWithFormat:@"%@/%@",urlStr,goodsId];
}

///不带参数的
+ (NSString *)delete_my_video{
    return kServerURL(@"delete/my/video");
}

@end
