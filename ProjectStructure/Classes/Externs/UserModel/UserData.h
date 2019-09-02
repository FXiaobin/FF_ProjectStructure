//
//  UserData.h
//  FFWisdomSchool
//
//  Created by mac on 2018/7/13.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject<NSCoding>

@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy) NSString *userPic;
@property (nonatomic,copy) NSString *introDes;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *age;
@property (nonatomic,copy) NSString *sex;


@property (nonatomic,strong) NSDictionary *extra;



+(UserData *)saveModelWithUsersDic:(NSDictionary *)dic;

+ (UserData *)getUserModel;

+ (NSString *)getUserId;

+(BOOL)isLogin;

+(UserData *)updateUserModelWithNewModel:(UserData *)newModel;

+ (void)clearUserModel;


@end
