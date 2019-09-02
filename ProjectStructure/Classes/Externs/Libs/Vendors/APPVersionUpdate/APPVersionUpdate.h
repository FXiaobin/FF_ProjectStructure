//
//  APPVersionUpdate.h
//  FFCommonProject
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * 版本更新类  需要放到首页调用 不然可能会由于跟控制器还没加载完成导致弹窗无法弹窗的问题
 */
@interface APPVersionUpdate : NSObject

+ (void)checkAppVersionUpdateFromAppStore;

@end
