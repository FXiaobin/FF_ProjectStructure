//
//  NNValidationView.h
//  NNValidationView
//
//  Created by 柳钟宁 on 2017/7/31.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

#import <UIKit/UIKit.h>

///注册 - 字母数字验证码

typedef void(^NNChangeValidationCodeBlock)(NSString *charString);

@interface NNValidationView : UIView

@property (nonatomic, strong) NSMutableString *charString;

@property (nonatomic, copy) NNChangeValidationCodeBlock changeValidationCodeBlock;

/**
 *  @pram  charCount 需要显示的字符的个数
 *  @pram  lineCount 需要显示的横线的个数
 */
- (instancetype)initWithFrame:(CGRect)frame andCharCount:(NSInteger)charCount andLineCount:(NSInteger)lineCount;

///不区分大小写字母比较时 两个字符串是否一样
+ (BOOL)isCorrectWithString:(NSString *)string otherString:(NSString *)otherString;


@end
