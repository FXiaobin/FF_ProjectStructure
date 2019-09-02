//
//  CommonUtils.m
//  dfds
//
//  Created by fanxiaobin on 17/3/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "CommonUtils.h"
#import <CoreText/CoreText.h>

#define HISTORY_SEARCH_STRING   @"historySearchString"


@implementation CommonUtils



+(CommonUtils *)manager{
    return [[CommonUtils alloc] init];
}

#pragma mark --- 添加 边框 圆角 点击事件
+ (void)cornerRadius:(CGFloat)cornerRadius forView:(UIView *)aview{
    
    aview.clipsToBounds = YES;
    aview.layer.cornerRadius = cornerRadius;
}

/// UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
+ (void)cornersByRounding:(UIRectCorner)rectCorner viewBounds:(CGRect)viewBounds cornerRadius:(CGFloat)cornerRadius  forView:(UIView *)aview{

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = viewBounds;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:viewBounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius,cornerRadius)];
    maskLayer.path = maskPath.CGPath;
    
    aview.layer.mask = maskLayer;
}

+ (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor forView:(UIView *)aview{
    aview.layer.borderColor = borderColor.CGColor;
    aview.layer.borderWidth = borderWidth;
}

+ (void)shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)size forView:(UIView *)aview{
    aview.layer.shadowColor = shadowColor.CGColor;
    aview.layer.shadowOffset = size;
    aview.layer.shadowOpacity = 0.5;
    aview.layer.shadowRadius = 2.0;
    //aview.layer.masksToBounds=YES
}

///按钮设置默认和选中图片后 点击按钮高亮显示图片错误的修改
+ (void)bttonStateWithButton:(UIButton *)button image:(NSString *)imageName selImage:(NSString *)selImageName{
    [button setImage:[UIImage imageNamed:imageName] forState: UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selImageName] forState: UIControlStateSelected];
    [button setImage:[UIImage imageNamed:imageName] forState: UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:selImageName] forState:UIControlStateSelected | UIControlStateHighlighted];
}

+ (void)addTarget:(id)target selector:(SEL)selector forView:(UIView *)aView{
    aView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [aView addGestureRecognizer:tap];
}

+ (CGFloat)heightWithText:(NSString *)text textSize:(CGSize)textSize attributes:(NSDictionary *)attributes{
    CGFloat txh = [text boundingRectWithSize:textSize
                       options:NSStringDrawingUsesLineFragmentOrigin
                            | NSStringDrawingUsesDeviceMetrics
                            | NSStringDrawingUsesLineFragmentOrigin
                            | NSStringDrawingTruncatesLastVisibleLine
                    attributes:attributes
                       context:nil].size.height + kSCALE(10);
    return txh;
}

#pragma mark --- 属性字符串
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)text color:(UIColor *)color fontSize:(CGFloat)fontSize range:(NSRange)range{
    
    NSMutableAttributedString *attribitedStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attribitedStr addAttributes:@{NSForegroundColorAttributeName : color, NSFontAttributeName : kFont(kSCALE(fontSize))} range:range];
    
    return attribitedStr;
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)text color:(UIColor *)color font:(UIFont *)font range:(NSRange)range{
    
    NSMutableAttributedString *attribitedStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attribitedStr addAttributes:@{NSForegroundColorAttributeName : color, NSFontAttributeName : font} range:range];
    
    return attribitedStr;
}

+ (NSAttributedString *)paragraphStyleWithContent:(NSString *)content lineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = lineSpacing;
    paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName : paragraph}];
    return attributedStr;
}

+ (NSAttributedString *)paragraphStyleWithContent:(NSString *)content lineSpacing:(CGFloat)lineSpacing textColor:(UIColor *)textColor{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = lineSpacing;
    paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName : paragraph, NSForegroundColorAttributeName : textColor}];
    return attributedStr;
}

+ (NSAttributedString *)paragraphStyleWithContent:(NSString *)content lineSpacing:(CGFloat)lineSpacing lineHeight:(CGFloat)lineHeight{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = lineSpacing;
    paragraph.minimumLineHeight = lineHeight;
    paragraph.maximumLineHeight = lineHeight;
    paragraph.lineHeightMultiple = lineHeight;
    paragraph.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName : paragraph}];
    return attributedStr;
}

+ (NSAttributedString *)paragraphStyleWithContent:(NSString *)content lineSpacing:(CGFloat)lineSpacing text:(NSString *)text textColor:(UIColor *)textColor{
    
    NSRange range = [content rangeOfString:text];
    NSMutableParagraphStyle *type = [[NSMutableParagraphStyle alloc] init];
    type.lineSpacing = lineSpacing;
    type.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content];
    [str addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    [str addAttributes:@{NSParagraphStyleAttributeName : type} range:NSMakeRange(0, content.length)];
    
    return str;
}

+ (CGSize)sizeWithContent:(NSString *)content attributed:(NSDictionary *)attributedDic limitedSize:(CGSize)limitSize{
    
    CGRect rect = [content boundingRectWithSize:limitSize
                                        options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                     attributes:attributedDic context:nil];
    
    return rect.size;
}


#pragma mark --- 导航条颜色修改
+ (void)navigationBarSetWithTargetColor:(UIColor *)mainColor{
    
    //UIColor *mainColor = MAIN_COLOR;
    UIColor *tintColor = [UIColor whiteColor];
    NSString *indicatorImage = @"nav_back_white";
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"PingFang SC" size:17]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [[UINavigationBar appearance] setTintColor:tintColor ];
    [[UINavigationBar appearance] setBarTintColor:mainColor];
    
    [UINavigationBar appearance].backIndicatorImage = [UIImage imageNamed:indicatorImage];
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [UIImage imageNamed:indicatorImage];
    
//    [targetVC.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:mainColor] forBarMetrics:UIBarMetricsDefault];
//    [targetVC.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:mainColor]];
}

+ (void)navigationBarDefaultStyleWithNavigationBar:(UINavigationBar *)navigationBar{

    NSMutableDictionary * textAttrs =[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]=kHexColor(0x333333);
    textAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:kSCALE(52)];
    textAttrs[NSShadowAttributeName]=[[NSShadow alloc]init];
    [navigationBar setTitleTextAttributes:textAttrs];
    navigationBar. barTintColor = kHexColor(0xfed21b);
    [navigationBar setTintColor:kHexColor(0x333333)];
}

+ (void)navigationBarStockStyleWithNavigationBar:(UINavigationBar *)navigationBar{

    navigationBar.barTintColor = kHexColor(0x1e2128);
    navigationBar.tintColor = [UIColor whiteColor];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : kFont(kSCALE(56))}];
}

#pragma mark --- 保存图片至相册
- (void)saveImageToPhotoLibraryWithImage:(UIImage *)image completeBlock:(resultBlock)block{
    self.commonUtilsBlock = block;
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    if (self.commonUtilsBlock) {
        self.commonUtilsBlock(error);
    }
}

///去除HTML标签
+ (NSString *)removeHtmlString:(NSString *)string {
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n|&nbsp" options:0 error:nil];
    string=[regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}

///去除HTML标签且过滤空格
+(NSString *)removeHtmlAndSpaceString:(NSString *)string {
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n|&nbsp" options:0 error:nil];
    string=[regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除首位空格
    
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];  //去除中间空格
    
//    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];  //去除换行符
    return string;
}

#pragma mark ---  添加的 常用的
#pragma mark --- NSDate

#define Date_MINUTE	    60
#define Date_HOUR		3600
#define Date_DAY		86400
#define Date_WEEK		604800
#define Date_YEAR		31556926

+ (NSString *)timeStringGetWithDate:(NSDate *)date{
    NSString *timeStr;
    NSDate *todayDate = [NSDate date];
    NSTimeInterval seconds = [todayDate timeIntervalSinceDate:date];
    
    if (seconds < Date_MINUTE) {
        timeStr = [NSString stringWithFormat:@"%d秒前",(int)seconds];
    }else if (seconds < Date_HOUR){
        seconds /= Date_MINUTE;
        timeStr = [NSString stringWithFormat:@"%d分钟前",(int)seconds];
    }else if (seconds < Date_DAY){
        seconds /= Date_HOUR;
        timeStr = [NSString stringWithFormat:@"%d小时前",(int)seconds];
    }else if (seconds < Date_WEEK){
        seconds /= Date_DAY;
        timeStr = [NSString stringWithFormat:@"%d天前",(int)seconds];
    }else if (seconds < Date_YEAR){
        seconds /= Date_WEEK;
        timeStr = [NSString stringWithFormat:@"%d周前",(int)seconds];
    }else{
        seconds /= Date_YEAR;
        timeStr = [NSString stringWithFormat:@"%d年前",(int)seconds];
    }
    return timeStr;
}

//某个日期对应的时间戳，精确到毫秒
+ (NSTimeInterval)timeIntervalNowTo1970WithDate:(NSDate *)date{
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return timeInterval * 1000.0;
}

// dateFormatter字符串yyyyMMddTHHmmss，记住你中间有个T dateStr 2019-09-02 11:48:22
+ (NSDate *)dateWithTimeDateFormatter:(NSString *)dateStr{
    NSDate *date = [self dateWithTimeDateFormatter:dateStr dateFormatter:@"yyyy-MM-dd HH:mm:ss"];
    return date;
}

// dateFormatter字符串yyyyMMddTHHmmss，记住你中间有个T dateStr 2019-09-02 11:48:22
+ (NSDate *)dateWithTimeDateFormatter:(NSString *)dateStr dateFormatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    // 设置为UTC时区
    // 这里如果不设置为UTC时区，会把要转换的时间字符串定为当前时区的时间（东八区）转换为UTC时区的时间
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    return date;
}

/**
 *  日期格式化
 *
 *  @param date          某个日期
 *  @param dateFormatter 要显示的格式 常用的有：YYYY-MM-dd HH:mm:ss  YYYY/MM/dd HH:mm:ss 和 yyyyMMddHHmmssSSS
 *
 *  @return 某个格式的日期字符串
 */
+ (NSString *)timeFormatterStringWithDate:(NSDate *)date dateFormatter:(NSString *)dateFormatter{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormatter;
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *timeStr = [formatter stringFromDate:date];
    
    return timeStr;
}

//将时间戳格式化成字符串
+ (NSString *)timeFormatterStringWithTimestamp:(NSTimeInterval)timestamp dateFormatter:(NSString *)dateFormatter{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp / 1000.0];
    NSString *timeFormatterStr = [self timeFormatterStringWithDate:date dateFormatter:dateFormatter];
    return timeFormatterStr;
}

+ (NSString *)crazyTimeToEndDate:(NSDate *)endDate{
    NSDate *relNowDate = [NSDate dateWithTimeIntervalSinceNow:8 * 3600];
    
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:relNowDate toDate: endDate options:0];
    NSInteger Hour = [cps hour];
    NSInteger Min = [cps minute];
    NSInteger Sec = [cps second];
    NSInteger Day = [cps day];
    //NSInteger nanosecond = [cps nanosecond];
    //NSInteger Mon = [cps month];
    //NSInteger Year = [cps year];
    //NSLog( @" From Now to %@, diff: Years: %ld  Months: %ld, Days; %ld, Hours: %ld, Mins:%ld, sec:%ld",[nowDate description], (long)Year, (long)Mon, (long)Day, (long)Hour, (long)Min,(long)Sec );
  
    NSString *countdown = [NSString stringWithFormat:@"%02zi:%02zi:%02zi:%02zi",Day,Hour,Min, Sec];
    if (Sec < 0) {
        countdown=[NSString stringWithFormat:@"00:00:00:00"];
    }
    return countdown;
    
}

+ (NSString*)remainingTimeToEndDate:(NSDate *)endDate text:(NSString *)text{
    //得到当前时间
    //NSDate *nowDate = [NSDate date];
    NSDate *relNowDate = [NSDate dateWithTimeIntervalSinceNow:8 * 3600];
   
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:relNowDate toDate: endDate options:0];
    NSInteger Hour = [cps hour];
    NSInteger Min = [cps minute];
    NSInteger Sec = [cps second];
    NSInteger Day = [cps day];
    //NSInteger Mon = [cps month];
    //NSInteger Year = [cps year];
    //NSLog( @" From Now to %@, diff: Years: %ld  Months: %ld, Days; %ld, Hours: %ld, Mins:%ld, sec:%ld",[nowDate description], (long)Year, (long)Mon, (long)Day, (long)Hour, (long)Min,(long)Sec );
    
    NSString *countdown = [NSString stringWithFormat:@"%@ %02zi天 %02zi:%02zi:%02zi", text,Day,Hour, Min, Sec];
    if (Sec < 0) {
        countdown=[NSString stringWithFormat:@"00天 00:00:00"];
    }
    return countdown;
}

+ (NSInteger)isSalingWithDate:(NSDate *)date{
    
    //NSDate *nowDate = [NSDate date];
    NSDate *relNowDate = [NSDate dateWithTimeIntervalSinceNow:8 * 3600];
    
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:date toDate:relNowDate options:0];
   
    NSInteger Sec = [cps second];
  
    return Sec;
}

#pragma mark --- 搜索
+ (void)saveSearchString:(NSString *)searchString{
    
    NSArray *historyArr = [self fetchHistorySearchResultArray];
    
    NSMutableArray *array = [NSMutableArray array];
    if (historyArr.count ) {
        [array addObjectsFromArray:historyArr];
    }
    [array addObject:searchString];
    
    NSSet *set = [NSSet setWithArray:array];
    NSArray *hArray = [NSArray arrayWithArray:set.allObjects];
    
    NSData *historyData = [NSKeyedArchiver archivedDataWithRootObject:hArray];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:historyData forKey:HISTORY_SEARCH_STRING];
    [ud synchronize];
}

+ (NSArray *)fetchHistorySearchResultArray{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *historyData = [ud objectForKey:HISTORY_SEARCH_STRING];
    NSArray *historyArr = [NSKeyedUnarchiver unarchiveObjectWithData:historyData];
    
    return historyArr;
}

+ (void)clearAllHistorySearchString{
    
    NSArray *historyArr = @[];
    NSData *historyData = [NSKeyedArchiver archivedDataWithRootObject:historyArr];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:historyData forKey:HISTORY_SEARCH_STRING];
    [ud synchronize];
}

/*
 转场类型type：
 
 Fade = 1,                   //淡入淡出
 Push,                       //推挤
 Reveal,                     //揭开
 MoveIn,                     //覆盖
 Cube,                       //立方体
 SuckEffect,                 //吮吸（水滴）
 OglFlip,                    //翻转
 RippleEffect,               //波纹
 （默认以父类为参照，所以一般我们使用一个和子控件一样大的父控件来修改这个效果）
 PageCurl,                   //翻页
 PageUnCurl,                 //反翻页
 CameraIrisHollowOpen,       //开镜头
 CameraIrisHollowClose,      //关镜头
 CurlDown,                   //下翻页
 CurlUp,                     //上翻页
 FlipFromLeft,               //左翻转
 FlipFromRight,              //右翻转

 转场子类型subtype：
 
 kCAMediaTimingFunctionLinear            线性即匀速
 kCAMediaTimingFunctionEaseIn            先慢后快
 kCAMediaTimingFunctionEaseOut           先快后慢
 kCAMediaTimingFunctionEaseInEaseOut     先慢后快再慢
 kCAMediaTimingFunctionDefault           实际效果是动画中间比较快
 
 */
#pragma mark ---  转场动画
+ (void)transationAnimationForViewWithType:(NSString *)type subType:(NSString *)subType forView:(UIView *)aView{
    
    CATransition *transtion = [CATransition animation];
    //[transtion setStartProgress:0.2];
    //[transtion setEndProgress:0.8];
    transtion.duration = 1.0;
    [transtion setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [transtion setType:type];
    
    //kCATransitionFromTop
    [transtion setSubtype:subType];
    
    [aView.layer addAnimation:transtion forKey:@"transtionKey"];
}

#pragma mark --- 核心动画
/// 左右抖动
+ (void)shakeAnimationWithAnimationView:(UIView *)animationView{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];

    [animation setDuration:0.1];
    //抖动角度
    animation.fromValue = @(-M_1_PI/2);
    animation.toValue = @(M_1_PI/2);
    //重复次数，2次
    animation.repeatCount = 2;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    animationView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [animationView.layer addAnimation:animation forKey:@"rotation"];
}

/// 点赞放大缩小
+ (void)scaleAnimationWithAnimationView:(UIView *)animationView{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@2.0 ,@1.4, @1.8,@1.2,@1.5, @2.0,@1.5,@1.0];
    animation.duration = 1.0;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:@"transform.scale"];
}

+ (void)rotationAnimationWithAnimationView:(UIView *)animationView{
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI*2.0);
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    //rotationAnimation.repeatCount = MAXFLOAT;//一直旋转
    [animationView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

//获取当前屏幕显示的viewcontroller
/** 获取当前View的控制器对象 */
+(UIViewController *)getCurrentViewControllerWithView:(UIView *)aView{
    UIResponder *next = [aView nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}


+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

+ (UIViewController *)currentViewController{
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    if (vc.presentedViewController) {
        while (vc.presentedViewController)
        {
            vc = vc.presentedViewController;
            
            if ([vc isKindOfClass:[UINavigationController class]])
            {
                vc = [(UINavigationController *)vc visibleViewController];
            }
            else if ([vc isKindOfClass:[UITabBarController class]])
            {
                vc = [(UITabBarController *)vc selectedViewController];
            }
        }
        
    }else if([vc isKindOfClass:[UINavigationController class]]) {
        vc = [(UINavigationController *)vc visibleViewController];
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        vc = [(UITabBarController *)vc selectedViewController];
        if([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)vc visibleViewController];
        }
    }
    
    return vc;
}

+ (UINavigationController *)currentNavigationController{
    return [self currentViewController].navigationController;
}



@end
