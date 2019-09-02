//
//  CommonInputView.h
//  JinGuFinance
//
//  Created by IOS开发 on 2018/4/13.
//  Copyright © 2018年 JinGuCaiJing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonInputView : UIView<UITextViewDelegate>

@property (nonatomic,weak) UIViewController *targetVC;

@property (nonatomic,strong) SZTextView *textView;

@property (nonatomic,strong) UIButton *sendBtn;

@property (nonatomic,copy) void (^sendMessageBlock) (SZTextView *textV);

@property (nonatomic,copy) void (^textViewDidChangedBlock) (SZTextView *textV);


@end
