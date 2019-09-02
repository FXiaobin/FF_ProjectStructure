//
//  CommonInputView.m
//  JinGuFinance
//
//  Created by IOS开发 on 2018/4/13.
//  Copyright © 2018年 JinGuCaiJing. All rights reserved.
//

#import "CommonInputView.h"

@implementation CommonInputView

-(void)dealloc{
    [self removeObserverForKeyboardNotifications];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kHexColor(0xf9f9f9);
        [CommonUtils borderWidth:0.5 borderColor:kSeperatorColor forView:self];
        
        [self addSubview:self.textView];
        [self addSubview:self.sendBtn];
        
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(kSCALE(10), kSCALE(30), kSCALE(10), kSCALE(100)));
        }];
        
        [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(kSCALE(-10));
            make.centerY.equalTo(self);
            make.width.mas_equalTo(kSCALE(80));
            make.height.mas_equalTo(kSCALE(80));
        }];
        
        ///在这里来检测评论框的位置变化 外部控制器就不需要再来检测通知了 
        [self registerForKeyboardNotifications];
 
    }
    return self;
}

#pragma mark - <UIKeyboard 评论框弹出和下落>
- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeObserverForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --- 显示 隐藏 键盘
- (void)keyboardWillShown:(NSNotification *)notification{
    
    NSDictionary *dict = [notification userInfo];
    CGSize kbSize = [[dict objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGFloat keyboardHeight = kbSize.height;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.targetVC.view.mas_bottom).with.offset(-keyboardHeight);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification{
    ///这里要让他放到屏幕外面 所以偏移50 不然全屏的时候就露馅了
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.targetVC.view.mas_bottom).offset(-kSafeAreaBottomHeight);
        make.height.mas_equalTo(kSCALE(100));
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark - <UITextViewDelegate>

-(void)textViewDidChange:(UITextView *)textView{
    //750 - 100 - 30 = 620
    CGFloat height = [textView sizeThatFits:CGSizeMake(kSCALE(620.0), kSCALE(150))].height;
    if (height < kSCALE(80.0)) {
        height = kSCALE(80.0);
    }else if (height > kSCALE(150)){
        height = kSCALE(150.0);
    }
    
    ///总高度是kSCALE(100)
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height+kSCALE(20));
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    
    if (self.textViewDidChangedBlock) {
        self.textViewDidChangedBlock(self.textView);
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        if (self.textView.text.length == 0) {
            [MBProgressHUD showAlert:@"请输入评论内容" toView:self.targetVC.view];
            return NO;
        }
        
        if (self.sendMessageBlock) {
            self.sendBtn.userInteractionEnabled = NO;
            self.sendMessageBlock(self.textView);
        }
        return NO;
    }
    return YES;
}

#pragma mark - <Button Click>
- (void)sendBtnAction:(UIButton *)sender{
    
    if (self.textView.text.length == 0) {
        [MBProgressHUD showAlert:@"请输入评论内容" toView:self.targetVC.view];
        return ;
    }
    
    if (self.sendMessageBlock) {
        self.sendBtn.userInteractionEnabled = NO;
        self.sendMessageBlock(self.textView);
    }
}

#pragma mark - <Lazy>

-(SZTextView *)textView{
    if (_textView == nil) {
        _textView = [[SZTextView alloc] init];
        _textView.font = kFont(kSCALE(28));
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeySend;
        [CommonUtils borderWidth:0.5 borderColor:kSeperatorColor forView:_textView];
        ///添加图片
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = [UIImage imageNamed:@"comment"];
        textAttachment.bounds = CGRectMake(0, 0, kSCALE(44), kSCALE(32));
        
        NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@" 我想说两句..." attributes:@{NSForegroundColorAttributeName : kSubTitleColor, NSFontAttributeName : kFont(kSCALE(28))}];
        [str insertAttributedString:attrStringWithImage atIndex:0];
        
        _textView.attributedPlaceholder = str;
        _textView.placeholderTextColor = kSubTitleColor;
    }
    return _textView;
}

-(UIButton *)sendBtn{
    if (_sendBtn == nil) {
        _sendBtn = [UIViewUtils createButtomWithFrame:CGRectZero title:@"发送" titleColor:kMainColor font:kFont(kSCALE(28)) target:self action:@selector(sendBtnAction:)];
    }
    return _sendBtn;
}

@end
