//
//  NetWorkServerURL.h
//  FFCommonProject
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkServerURL : NSObject

///服务器地址
+ (NSString *)Main_Server_URL;

///不带参数的
+ (NSString *)homePage_URL;

///带参数的
+ (NSString *)collectionGoodsWithGoodsId:(NSString *)goodsId;

///不带参数的
+ (NSString *)delete_my_video;

@end
