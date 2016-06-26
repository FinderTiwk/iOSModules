//
//  AppDelegate+XKSLoginModule.m
//  XKSLoginModule
//
//  Created by _Finder丶Tiwk on 16/6/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "AppDelegate+XKSLoginModule.h"

#import <XKSCommonSDK/XKSCommonMacro.h>
#import <XKSCommonSDK/XKSAlertWindow.h>

#import "XKSLoginServices.h"
#import "ViewController.h"


@implementation AppDelegate (XKSLoginModule)

- (void)setupLoginModule{
    XKSLoginViewController *loginController = [XKSLoginServices loginController];
    
    @xWeakify
    [XKSLoginServices loginSuccess:^(NSString *message) {
        @xStrongify
        [self loginSuccess:message];
    }];
    
    self.window.rootViewController = loginController;
}

- (void)loginSuccess:(NSString *)message{
    
    @xWeakify
    [XKSAlertWindow showWithType:XKSAlertType_SUCCESS message:message action:^{
        @xStrongify
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ViewController" bundle:nil];
        ViewController *contoller = storyBoard.instantiateInitialViewController;
        
        CATransition *animation = [CATransition animation];
        animation.type = @"rippleEffect";
        [animation setDuration:0.6];
        [animation setRepeatCount:1.0];
        [self.window.layer addAnimation:animation forKey:@"rippleEffect"];
        self.window.rootViewController = contoller;
    }];
}


- (void)apiDemo{
//    XKSLoginServices *services = [[XKSLoginServices alloc] init];
//    [XKSLoginServices deprecateFunction];
}


@end
