//
//  APPVersionUpdate.m
//  FFCommonProject
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "APPVersionUpdate.h"
#import "AppDelegate.h"

#define APPStore_APPID     @"1193941380"

@interface APPVersionUpdate ()

@property (nonatomic,strong) NSString *releaseNotes;
@property (nonatomic,strong) NSString *trackName;
@property (nonatomic,strong) NSString *trackViewUrl;

@end

@implementation APPVersionUpdate

+ (void)checkAppVersionUpdateFromAppStore{
    
    //定义的app的地址
    NSString *urld = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",APPStore_APPID];
    
    //网络请求app的信息，主要是取得我说需要的Version
    NSURL *url = [NSURL URLWithString:urld];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data) {
            //data是有关于App所有的信息
            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([[receiveDic valueForKey:@"resultCount"] intValue] > 0) {
                
                NSArray *results = receiveDic[@"results"];
                NSDictionary *resultDic = results[0];
                
                //请求的有数据，进行版本比较
                [self showAlertWithDic:resultDic];
            }
        }
    }];
    
    [task resume];
}

+(void)showAlertWithDic:(NSDictionary *)dic{
    
    NSString *releaseNotes = dic[@"releaseNotes"];
    NSString *trackName = dic[@"trackName"];
    NSString *trackViewUrl = dic[@"trackViewUrl"];
    NSString *latestVersion = dic[@"version"];
    
    NSString *currentVersion = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    ///版本不一样就要更新了
    if (![latestVersion isEqualToString:currentVersion]) {
        NSString *title = [NSString stringWithFormat:@"版本更新\n%@",trackName];
        UIAlertController *av = [UIAlertController alertControllerWithTitle:title message:releaseNotes preferredStyle:UIAlertControllerStyleAlert];
        [av addAction:[UIAlertAction actionWithTitle:@"稍后更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [av addAction:[UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:trackViewUrl]];
            if (canOpen) {
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl] options:@{} completionHandler:nil];
                } else {
                    // Fallback on earlier versions
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
                }
            }
        }]];
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIViewController *rootVC = delegate.window.rootViewController;
        
        [rootVC presentViewController:av animated:YES completion:nil];
    }
}

@end
