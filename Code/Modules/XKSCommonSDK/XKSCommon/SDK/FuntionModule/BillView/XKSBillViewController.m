//
//  XKSBillViewController.m
//  XKSCommonSDK
//
//  Created by wangyangcc on 16/5/13.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSBillViewController.h"
#import "XKSBillCustomViews.h"
#import "UIImage+Xkeshi.h"
#import "XKSCommonFunction.h"
#import "XKSAlertWindow.h"

#define XKSMainScreenHeight CGRectGetHeight([[UIScreen mainScreen] bounds])
#define XKSMainScreenWidth  CGRectGetWidth([[UIScreen mainScreen]  bounds])

@interface XKSBillViewController () <XKSBillNumberKeyboardViewDelegate, XKSBillSettingViewDelegate>

@property (nonatomic, strong) XKSBillNavigationBar   *titleView;

@property (strong, nonatomic) XKSBillSettingView        *settingView;

@property (strong, nonatomic) XKSBillNumberKeyboardView *keyboardView;

@property (strong, nonatomic) NSMutableString *PHnumber;

@end

@implementation XKSBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewSetup];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义方法

- (void)viewSetup
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航条
    [self.view addSubview:self.titleView];
    self.titleView.frame = CGRectMake(0, 20, XKSMainScreenWidth, 60);
    UIView *borderView = [[UIView alloc] init];
    borderView.backgroundColor = [UIColor lightGrayColor];
    borderView.frame = CGRectMake(0, 59, XKSMainScreenWidth, 1);
    [self.titleView addSubview:borderView];
    //end
    
    //左侧界面
    [self.view addSubview:self.settingView];
    self.settingView.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.frame), XKSMainScreenWidth - 380, XKSMainScreenHeight - CGRectGetMaxY(self.titleView.frame));
    borderView = [[UIView alloc] init];
    borderView.backgroundColor = [UIColor lightGrayColor];
    borderView.frame = CGRectMake(XKSMainScreenWidth - 380 - 1, 0, 1, CGRectGetMaxY(self.settingView.frame));
    [self.settingView addSubview:borderView];
    //end
    
    //数字键盘
    [self.view addSubview:self.keyboardView];
    self.keyboardView.frame = CGRectMake(CGRectGetMaxX(self.settingView.frame), CGRectGetMaxY(self.titleView.frame), XKSMainScreenWidth, XKSMainScreenHeight - CGRectGetMaxY(self.titleView.frame));
    //end
    
    //设置背景图片
    UIImage *mainBackgroundImage = [[UIImage xks_imageNamed:@"commonVC_Backgound_BarImage" fromBundle:XKSCommonSDKBundleName] resizableImageWithCapInsets:UIEdgeInsetsMake(100, 0, 100, 0) resizingMode:UIImageResizingModeTile];
    self.keyboardView.backgroundColor = [UIColor colorWithPatternImage:mainBackgroundImage];
    //end
}

#pragma mark - XKSBillSettingViewDelegate

/**
 *  @author wangyangcc, 16-05-13 15:05:13
 *
 *  @brief 回调，通常最多一个参数为YES
 *
 *  @param printPaperBill      是否打印纸质账单
 *  @param printElectronicbill 是否打印电子账单
 */
- (void)settingViewWithPrintPaperBill:(BOOL)printPaperBill
                  printElectronicbill:(BOOL)printElectronicbill
{
    //不打印账单
    if (!printPaperBill && !printElectronicbill) {
        //调用返回按钮回调
        self.titleView.backCallBlock();
        return;
    }
    //打印电子账单
    if (printElectronicbill && self.submitBlock) {
        //验证手机号码
        if (validateMobileNumber(self.settingView.textField.text) == NO) {
            [XKSAlertWindow showWithType:XKSAlertType_WARNING message:@"请输入正确的手机号"];
            return;
        }
        self.submitBlock(self.settingView.textField.text);
        return;
    }
    //打印纸质账单
    if (printPaperBill) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kXKSBillView_PrintPaperBill_Notification object:self.printDic];
    }
    //调用返回按钮回调
    self.titleView.backCallBlock();
}

#pragma mark - XKSBillNumberKeyboardViewDelegate

- (void)numberButtonTaped:(NSInteger)number
{
    [self.PHnumber appendFormat:@"%d",(int)number];
    self.settingView.textField.text = self.PHnumber;
}

- (void)deleteButtonTaped
{
    if ([self.PHnumber length] <= 0) {
        return;
    }
    self.PHnumber = [[self.PHnumber substringToIndex:self.PHnumber.length - 1] mutableCopy];
    self.settingView.textField.text = self.PHnumber;
}

- (void)deleteAllButtonTaped
{
    self.PHnumber = [NSMutableString string];
    self.settingView.textField.text = self.PHnumber;
}

- (void)doneButtonTaped
{
    [self settingViewWithPrintPaperBill:NO printElectronicbill:YES];
}

#pragma mark - getters

- (XKSBillNavigationBar *)titleView
{
    if (_titleView == nil) {
        _titleView = [XKSBillNavigationBar new];
        _titleView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        [_titleView setBackCallBlock:^{
            if (weakSelf.dismissBlock) {
                weakSelf.dismissBlock();
            }
            else {
                if ([weakSelf.navigationController presentingViewController]) {
                    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:NULL];
                }
                else {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }
        }];
        _titleView.title = @"账单";
    }
    return _titleView;
}

- (XKSBillSettingView *)settingView
{
    if (_settingView == nil) {
        _settingView = [XKSBillSettingView new];
        _settingView.delegate = self;
        _settingView.backgroundColor = [UIColor whiteColor];
    }
    return _settingView;
}

- (XKSBillNumberKeyboardView *)keyboardView
{
    if (_keyboardView == nil) {
        _keyboardView = [XKSBillNumberKeyboardView new];
        _keyboardView.delegate = self;
    }
    return _keyboardView;
}

- (NSMutableString *)PHnumber
{
    if (_PHnumber == nil) {
        _PHnumber = [NSMutableString new];
    }
    return _PHnumber;
}

@end
