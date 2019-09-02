//
//  NSObject+Model.m
//  FinanceInstitute
//
//  Created by IOS开发 on 2018/4/2.
//  Copyright © 2018年 YuanHui. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>

@implementation NSObject (Model)

+(instancetype)makeModelWithDict:(NSDictionary *)dict{
    

    id myObj = [[self alloc] init];
    
    unsigned int outCount;
    
    //获取类中的所有成员属性
    objc_property_t *arrPropertys = class_copyPropertyList([self class], &outCount);
    
    for (NSInteger i = 0; i < outCount; i ++) {
        objc_property_t property = arrPropertys[i];
        
        //获取属性名字符串
        //model中的属性名
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id propertyValue = dict[propertyName];
        
        if (propertyValue != nil) {
            [myObj setValue:propertyValue forKey:propertyName];
        }
    }
    
    free(arrPropertys);
    
    return myObj;
}

@end
