//
//  XKSLoginViewController.m
//  XKSLoginModule
//
//  Created by _Finder丶Tiwk on 16/6/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSLoginViewController.h"

#import <XKSCommonSDK/XKSAlertWindow.h>
#import <XKSCommonSDK/XKSCommonFunction.h>

#import <MBProgressHUD/MBProgressHUD.h>

#import "XKSOperator.h"

@interface XKSLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UIButton *setttingButton;

@end

@implementation XKSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.showSetting) {
        _setttingButton.hidden = NO;
    }
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(putupKeyBoard)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)putupKeyBoard{
    [self.view endEditing:YES];
}


- (IBAction)loginAction:(UIButton *)sender {
    NSCParameterAssert(self.successBlock);
    
    if([_nameField.text isEqualToString:@"admin"]){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSDictionary *response = @{@"name":@"admin",@"operatorID":@"7329gf1g63gr"};
            XKSOperator *operator = [XKSOperator shareXKSOperator];
            [operator convertFromCollection:response];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            self.successBlock(@"登录成功");
        });
        
    }else{
        [XKSAlertWindow showWithType:XKSAlertType_FAILURE message:@"用户名密码错误"];
    }
}



- (IBAction)settingAction:(UIButton *)sender {
    self.showSetting(self);
}

@end
