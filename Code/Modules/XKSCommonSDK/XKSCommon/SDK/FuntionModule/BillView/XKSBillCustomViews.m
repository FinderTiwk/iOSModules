//
//  XKSBillCustomViews.m
//  XKSCommonSDK
//
//  Created by wangyangcc on 16/5/13.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSBillCustomViews.h"
#import "UIImage+Xkeshi.h"

#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *导航栏*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

@implementation XKSBillNavigationBar
{
    UILabel *titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self myInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self myInit];
        
    }
    return self;
}

- (void)myInit
{
    
    //返回按钮
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 80, 60)];
    b.backgroundColor = [UIColor clearColor];
    [b setImage:[UIImage xks_imageNamed:@"back" fromBundle:XKSCommonSDKBundleName] forState:UIControlStateNormal];
    [b addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:b];
    
    //标题
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:118/255.0 green:130/255.0 blue:142/255.0 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:21];
    [self addSubview:label];
    label.frame = CGRectMake(0, 0, 1024, 60);
    titleLabel = label;
}

- (void)tapButton:(UIButton*)b
{
    if (self.backCallBlock) {
        self.backCallBlock();
    }
}

- (void)setTitle:(NSString *)title
{
    if (_title) {
        _title = nil;
    }
    _title = title;
    titleLabel.text = title;
}

@end

#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *账单键盘*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝


@implementation XKSBillNumberKeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self myInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self myInit];
    }
    return self;
}

- (void)myInit
{
    /*!九个数字布局 */
    CGFloat leftSpace = (380 - 101*3)/2;
    CGFloat topSpace = 100;
    NSUInteger but_x = 0;
    NSUInteger but_y = 0;
    for (NSUInteger i = 0; i < 12; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage xks_imageNamed:[NSString stringWithFormat:@"xks_billNumberKeyboard%d",(int)(i+1)] fromBundle:XKSCommonSDKBundleName] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage xks_imageNamed:[NSString stringWithFormat:@"xks_billNumberKeyboard%d+",(int)(i+1)] fromBundle:XKSCommonSDKBundleName] forState:UIControlStateHighlighted];
        button.tag = 1 + i;
        if (i == 11) {
            [button addTarget:self action:@selector(deleteButtonTaped) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (i == 10)
        {
            [button addTarget:self action:@selector(zeroButtonTaped) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (i == 9)
        {
            [button addTarget:self action:@selector(deleteAllButtonTaped) forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            [button addTarget:self action:@selector(numberButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self addSubview:button];
        button.frame = CGRectMake(leftSpace + 101*but_x, topSpace + 101*but_y, 101, 101);
        but_x ++;
        if (but_x == 3) {
            but_y ++;
            but_x = 0;
        }
    }
    
    UIButton *affirmButton=[UIButton new];
    [affirmButton setImage:[UIImage xks_imageNamed:@"xks_billNumberKeyboard_done" fromBundle:XKSCommonSDKBundleName] forState:UIControlStateNormal];
    [affirmButton addTarget:self action:@selector(doneButtonTaped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:affirmButton];
    affirmButton.frame = CGRectMake(37, 530, 306, 70);
}

#pragma mark - 自定义方法

- (void)numberButtonTaped:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberButtonTaped:)]) {
        [self.delegate numberButtonTaped:button.tag];
    }
}

- (void)zeroButtonTaped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberButtonTaped:)]) {
        [self.delegate numberButtonTaped:0];
    }
}

- (void)deleteAllButtonTaped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAllButtonTaped)]) {
        [self.delegate deleteAllButtonTaped];
    }
}

- (void)deleteButtonTaped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteButtonTaped)]) {
        [self.delegate deleteButtonTaped];
    }
}

- (void)doneButtonTaped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(doneButtonTaped)]) {
        [self.delegate doneButtonTaped];
    }
}

@end


#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *账单左侧设置界面*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝



@interface XKSBillSettingView ()

@property (strong, nonatomic) UITextField *textField;

@end

@implementation XKSBillSettingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self myInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self myInit];
    }
    return self;
}

- (void)myInit
{
    [self addSubview:self.textField];
    self.textField.frame = CGRectMake(150, 160, 350, 60);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(150, CGRectGetMaxY(self.textField.frame) + 30, 350, 60);
    [button setBackgroundImage:[UIImage xks_imageNamed:@"xks_billSelButton" fromBundle:XKSCommonSDKBundleName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage xks_imageNamed:@"xks_billSelButton_s" fromBundle:XKSCommonSDKBundleName] forState:UIControlStateHighlighted];
    button.tag = 111;
    [button addTarget:self action:@selector(buttonSendTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    UIButton *buttonT = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonT.frame = CGRectMake(150, CGRectGetMaxY(button.frame) + 30, 350, 60);
    [buttonT setAttributedTitle:[self buttonAttributedStringWithTitle:@"我有短信提醒,不要账单" button:buttonT width:226] forState:UIControlStateNormal];
    buttonT.tag = 112;
    [buttonT addTarget:self action:@selector(buttonSendTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonT];
    
    UIButton *buttonS = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonS.frame = CGRectMake(150, CGRectGetMaxY(buttonT.frame) + 20, 350, 60);
    [buttonS setAttributedTitle:[self buttonAttributedStringWithTitle:@"我坚持打印纸质账单" button:buttonS width:200] forState:UIControlStateNormal];
    buttonS.tag = 113;
    [buttonS addTarget:self action:@selector(buttonSendTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonS];
}

#pragma mark - 自定义方法

- (NSMutableAttributedString *)buttonAttributedStringWithTitle:(NSString *)title
                                                        button:(UIButton *)button
                                                         width:(CGFloat)width
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title?:@""];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0, attributedString.string.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:69.0f/255.0f green:73.0f/255.0f blue:81.0f/255.0f alpha:1] range:NSMakeRange(0, attributedString.string.length)];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(0.5) range:NSMakeRange(0, attributedString.string.length)];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithRed:196.0f/255.0f green:196.0f/255.0f blue:199.0f/255.0f alpha:1];
    line.frame = CGRectMake((350 - width)/2, 45, width, 1);
    [button addSubview:line];
    
    return attributedString;
}

- (void)buttonSendTaped:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingViewWithPrintPaperBill:printElectronicbill:)]) {
        if (button.tag == 111) {
            [self.delegate settingViewWithPrintPaperBill:NO printElectronicbill:YES];
        }
        else if (button.tag == 112) {
            [self.delegate settingViewWithPrintPaperBill:NO printElectronicbill:NO];
        }
        else if (button.tag == 113) {
            [self.delegate settingViewWithPrintPaperBill:YES printElectronicbill:NO];
        }
    }
}

#pragma mark - getters

- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [XKSBillSettingViewField new];
        _textField.layer.cornerRadius = 5;
        _textField.layer.borderWidth = 1;
        _textField.placeholder = @"输入手机号码";
        _textField.font = [UIFont systemFontOfSize:20];
//        _textField.delegate = self;
        _textField.layer.borderColor = [[UIColor colorWithRed:195.0f/255.0f green:195.0f/255.0f blue:195.0f/255.0f alpha:1]CGColor];
        _textField.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _textField;
}

@end

@implementation XKSBillSettingViewField

#pragma mark - 定制输入范围

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    bounds.origin.x = 16;
    bounds.size.width = CGRectGetWidth(bounds) - 40;
    return bounds;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    bounds.origin.x = 16;
    bounds.size.width = CGRectGetWidth(bounds) - 40;
    return bounds;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    bounds.origin.x = 16;
    bounds.size.width = CGRectGetWidth(bounds) - 40;
    return bounds;
}

@end