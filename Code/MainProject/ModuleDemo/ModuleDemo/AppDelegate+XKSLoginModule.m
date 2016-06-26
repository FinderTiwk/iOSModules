//
//  AppDelegate+XKSLoginModule.m
//  ModuleDemo
//
//  Created by _Finder丶Tiwk on 16/6/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "AppDelegate+XKSLoginModule.h"

#import <XKSCommonSDK/XKSAlertWindow.h>
#import <XKSCommonSDK/XKSCommonMacro.h>
#import <XKSCommonSDK/XKSCommonFunction.h>

#import <XKSLoginModule/XKSLoginServices.h>
#import <XKSSettingModule/XKSSettingServices.h>
#import <XKSHomeModule/XKSHomeServices.h>

#import "ViewController.h"

@implementation AppDelegate (XKSLoginModule)


- (void)xks_setupLoginModule{
    
    XKSLoginViewController *loginController = [XKSLoginServices loginController];
    
    @xWeakify
    [XKSLoginServices loginSuccess:^(NSString *message) {
        @xStrongify
        [self loginSuccess:message];
    }];
    
    
    
    [XKSLoginServices showSetting:^(UIViewController *parent) {
        @xStrongify
        [self showSettingControllerFrom:parent];
    }];
    
    self.window.rootViewController = loginController;
}


- (void)loginSuccess:(NSString *)message{
    
    @xWeakify
    [XKSAlertWindow showWithType:XKSAlertType_SUCCESS message:message action:^{
        @xStrongify
        
        XKSHomeViewController *controller = [XKSHomeServices homeController];
        CATransition *animation = [CATransition animation];
        animation.type = @"rippleEffect";
        [animation setDuration:0.6];
        [animation setRepeatCount:1.0];
        [self.window.layer addAnimation:animation forKey:@"rippleEffect"];
        self.window.rootViewController = controller;
    }];
}



- (void)showSettingControllerFrom:(UIViewController *)parent{
    
    UIStoryboard *storyBoard = customStoryBoard(@"XKSSettingModule", @"XKSSettingViewController");
    XKSSettingViewController *controller = [storyBoard instantiateInitialViewController];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    controller.preferredContentSize   = CGSizeMake(size.width/2, size.height*2/3);
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    controller.modalTransitionStyle   = UIModalTransitionStyleCoverVertical;
    [parent presentViewController:controller animated:YES completion:nil];
}

@end
