//
//  ViewController.m
//  XKSDeviceBindingViewController
//
//  Created by YrionPlus on 12/23/15.
//  Copyright © 2015 Xkeshi. All rights reserved.
//

#import "XKSDeviceBindingViewController.h"

#import "XKSCommonTips.h"
#import "XKSNetworking.h"
#import "XKSCommonMacro.h"
#import "XKSAlertWindow.h"
#import "XKSCommonFunction.h"

NSString *const kDeviceBindedShopID      = @"shopId";
NSString *const kDeviceBindedMobile      = @"phone";
NSString *const kDeviceBindedShopName    = @"shopName";
NSString *const kDeviceBindedShopAddress = @"address";

/*! 设备唯一标识存储的文件名*/
static NSString *const kXKSBindingDeviceInomationFileName = @"kXKSBindingDeviceInomation";
/*! 商户信息存储的文件名*/
static NSString *const kXKSBindingShopInfomationFileName  = @"kXKSBindingShopInfomation";
/*! 绑定接口*/
static NSString *const kXKSBindingApi                     = @"/api/xpos/terminal/bind";

@interface XKSDeviceBindingViewController ()

@property (weak, nonatomic) IBOutlet UITextField *serialNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *bindingBtn;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, copy) void(^finishBlock)(NSDictionary *resultInfo);

@end

@implementation XKSDeviceBindingViewController {
    UIViewController  *_displayController;
}

#pragma mark - 构造方法
- (instancetype)initWithParentViewController:(UIViewController *)controller {
    UIStoryboard *storyBoard = customStoryBoard(XKSCommonSDKBundleName, @"XKSDeviceBindingViewController");
    NSCParameterAssert(storyBoard);
    self = [storyBoard instantiateInitialViewController];
    if (self) {
        _displayController = controller?:currentViewController();
    }
    return self;
}

#pragma mark - OpenAPI
#pragma mark ########绑定SDK初始化
+ (instancetype)controllerWithDisplayController:(UIViewController *)controller{
    return [[self alloc] initWithParentViewController:controller];
}

#pragma mark ########获取绑定信息
+ (NSDictionary *)getShopInfomation {
    NSString *path = filePathInDocuments(kXKSBindingShopInfomationFileName);
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

#pragma mark ########绑定设备
- (void)bindingWithBlock:(void (^)(NSDictionary *))block{
    
    NSString *deviceNumber = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    
    NSString *path = filePathInDocuments(kXKSBindingDeviceInomationFileName);
    NSString *storedDeviceNumber = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    if ([deviceNumber isEqualToString:storedDeviceNumber]) {
        if (block) {
            block([[self class] getShopInfomation]);
        }
        return;
    }
    self.finishBlock = block;
    if (!_displayController) {
        _displayController = currentViewController();
    }
    [_displayController presentViewController:self animated:YES completion:nil];
}

#pragma mark ########重置绑定关系
- (void)reset{
    NSError *error = nil;
    {
        NSString *paht = filePathInDocuments(kXKSBindingDeviceInomationFileName);
        [[NSFileManager defaultManager] removeItemAtPath:paht error:&error];
    }
    
    {
        NSString *paht = filePathInDocuments(kXKSBindingShopInfomationFileName);
        [[NSFileManager defaultManager] removeItemAtPath:paht error:&error];
    }
    [self bindingWithBlock:nil];
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUIDisplay];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];

    [self.view addGestureRecognizer:tapGesture];
}

#pragma mark - getter
- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];;
        _indicatorView.center = self.view.center;
        [self.view addSubview:_indicatorView];
    }
    return _indicatorView;
}


#pragma mark - Actions
#pragma mark 隐藏键盘
- (void)hideKeyboard:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

#pragma mark 绑定按钮点击事件
- (IBAction)bind:(UIButton *)sender {
    
    if (self.serialNumberTextField.isFirstResponder) {
        [self.serialNumberTextField resignFirstResponder];
    }
    
    NSString *serialNumber = self.serialNumberTextField.text;
    if (!isStringWithAnyText(serialNumber) || serialNumber.length != 32) {
        [XKSAlertWindow showWithType:XKSAlertType_WARNING message:@"请输入32位长度的序列号"];
        return;
    }
    
    NSString *deviceNumber = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    
    
    XKSRequestParameter *parameter = [[XKSRequestParameter alloc] init];
    parameter.apiString = kXKSBindingApi;
    parameter.requestMethod = XKSRequestMethod_POST;
    parameter.parameterDictionary =
    [@{@"serialNumber":serialNumber,@"deviceNumber":deviceNumber} mutableCopy];
    
    @xWeakify
    [XKSNetworking syncWithParameter:parameter start:^{
        @xStrongify
        [self.indicatorView startAnimating];
    } success:^(id collection) {
        @xStrongify
        [self.indicatorView stopAnimating];
        NSDictionary *serverResult = (NSDictionary *)collection;
        NSString *codeString       = serverResult[@"code"];
        NSString *description      = serverResult[@"description"];
        if ([codeString isEqualToString:@"0"]) {
            [self saveInfomationWithDictionary:serverResult];
            [self exitWithMessage:description];
        }else{
            [XKSAlertWindow showWithType:XKSAlertType_FAILURE message:description];
        }

    } failure:^(NSDictionary *userInfo) {
        @xStrongify
        [self.indicatorView stopAnimating];
        [XKSAlertWindow showWithType:XKSAlertType_FAILURE message:userInfo[@"msg"]];
    }];
}

- (void)exitWithMessage:(NSString *)message{
    @xWeakify
    [XKSAlertWindow showWithType:XKSAlertType_SUCCESS message:message action:^{
        @xStrongify
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.finishBlock) {
                self.finishBlock([[self class] getShopInfomation]);
            }
        }];
    }];
}

#pragma mark - 私有方法: 初始化界面设置, 生成签名, 设备绑定验证, 信息提示等
- (void)setUpUIDisplay {
    _serialNumberTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];;
    _serialNumberTextField.leftViewMode = UITextFieldViewModeAlways;
    _serialNumberTextField.layer.borderColor = RGBCOLOR(167, 167, 171).CGColor;
    [_serialNumberTextField setValue:RGBCOLOR(167, 167, 171) forKeyPath:@"placeholderLabel.textColor"];
    _bindingBtn.layer.cornerRadius = 5;
}

#pragma mark - 辅助方法
#pragma mark 设备验证成功后, 保存信息
- (void)saveInfomationWithDictionary:(NSDictionary *)dict {
    {
        NSError *error = nil;
        NSString *deveiceNumber = [[UIDevice currentDevice] identifierForVendor].UUIDString;
        NSString *path = filePathInDocuments(kXKSBindingDeviceInomationFileName);
        [xks_md5(deveiceNumber) writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    
    {
        NSDictionary *shopInfo = dict[@"result"];
        NSString *paht = filePathInDocuments(kXKSBindingShopInfomationFileName);
        [shopInfo writeToFile:paht atomically:YES];
        
    }
}

@end
