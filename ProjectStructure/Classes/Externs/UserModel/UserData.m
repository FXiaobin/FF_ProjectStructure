//
//  UserData.m
//  FFWisdomSchool
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "UserData.h"

#define UserModel_Key @"userModelKey"

@implementation UserData

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        //解档
        unsigned int count = 0;
        //取出所有的属性
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        
        for (int i = 0; i < count; i++) {
            //获取到属性的C字符串名称
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            NSString *key = [NSString stringWithUTF8String:propertyName];
            //解档
            id value = [aDecoder decodeObjectForKey:key];
            // 利用KVC赋值
            [self setValue:value forKey:key];
        }
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{

    unsigned int count = 0;//表示对象的属性个数
    //取出所有的属性
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        //获取到属性的C字符串名称
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        //转成对应的OC名称
        NSString *key = [NSString stringWithUTF8String:propertyName];
        //归档 -- 利用KVC
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

+(UserData *)saveModelWithUsersDic:(NSDictionary *)dic{

    UserData *user = [self objectWithKeyValues:dic];
  
    //UserData *user = [UserData mj_objectWithKeyValues:dic];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:UserModel_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return user;
}

+ (UserData *)getUserModel{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:UserModel_Key];
    UserData *userModel = nil;
    if (data) {
        userModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return userModel;
}

+ (NSString *)getUserId{
    UserData *userModel = [self getUserModel];
    return userModel.userId ? [NSString stringWithFormat:@"%@",userModel.userId] : nil;
}

+(BOOL)isLogin{
    UserData *userModel = [self getUserModel];
    if (userModel.userId) {
        return YES;
    }
    return NO;
}


+ (UserData *)updateUserModelWithNewModel:(UserData *)newModel{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newModel];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:UserModel_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UserData *model = [self getUserModel];
    
    return model;
}

+(void)clearUserModel{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserModel_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - Private
///类方法
+ (id)objectWithKeyValues:(NSDictionary *)dict {
    Class cla = self.class;
    // count:成员变量个数
    unsigned int outCount = 0;
    // 获取成员变量数组
    Ivar *ivars = class_copyIvarList(cla, &outCount);
    
    id object = [[cla alloc] init];
    
    // 遍历所有成员变量
    for (int i = 0; i < outCount; i++) {
        // 获取成员变量
        Ivar ivar = ivars[i];
        // 获取成员变量名字
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 成员变量名转为属性名（去掉下划线 _ ）
        key = [key substringFromIndex:1];
        // 取出字典的值
        id value = dict[key];
        // 如果模型属性数量大于字典键值对数理，模型属性会被赋值为nil而报错
        if (value == nil) continue;
        // 利用KVC将字典中的值设置到模型上
        /// [self setValue:value forKeyPath:key];
        
        [object setValue:value forKey:key];
    }
    //需要释放指针，因为ARC不适用C函数
    free(ivars);
    
    return object;
}

///对象方法
- (void)transformDict:(NSDictionary *)dict {
    Class cla = self.class;
    // count:成员变量个数
    unsigned int outCount = 0;
    // 获取成员变量数组
    Ivar *ivars = class_copyIvarList(cla, &outCount);
    // 遍历所有成员变量
    for (int i = 0; i < outCount; i++) {
        // 获取成员变量
        Ivar ivar = ivars[i];
        // 获取成员变量名字
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 成员变量名转为属性名（去掉下划线 _ ）
        key = [key substringFromIndex:1];
        // 取出字典的值
        id value = dict[key];
        // 如果模型属性数量大于字典键值对数理，模型属性会被赋值为nil而报错
        if (value == nil) continue;
        // 利用KVC将字典中的值设置到模型上
        [self setValue:value forKeyPath:key];
    }
    //需要释放指针，因为ARC不适用C函数
    free(ivars);
}

@end
