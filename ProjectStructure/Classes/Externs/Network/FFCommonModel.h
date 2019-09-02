//
//  FFCommonModel.h
//  FFCommonProject
//
//  Created by mac on 2018/6/1.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFCommonModel : NSObject

///请求是否成功
@property (nonatomic,assign) BOOL isSuccess;


///请求获取的数据体
@property (nonatomic,strong)  id data;      //数组
@property (nonatomic, strong) id entity;    // 字典

///请求返回的提示
@property (nonatomic,strong) NSString *message;
///请求是否成功状态码
@property (nonatomic,assign) NSInteger error_code;

/// 总页数
@property (nonatomic, assign) NSInteger totalPages;
/// 当前在第几页
@property (nonatomic, assign) NSInteger pageNum;
/// 每页的数量
@property (nonatomic, assign) NSInteger pageSize;

///对请求的数据解析成FFCommonModel数据模型
+(FFCommonModel *)commonWithResponseObject:(id)responseObject;
+(FFCommonModel *)commonWithResponseObject:(id)responseObject dataClass:(id)cls;


@end
