//
//  XKSLoginServices.m
//  XKSLoginModule
//
//  Created by _Finder丶Tiwk on 16/6/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSLoginServices.h"
#import <XKSCommonSDK/XKSCommonFunction.h>

NSString *const XKSLoginModuleBundleName = @"XKSLoginModule";

@implementation XKSLoginServices

__weak XKSLoginViewController *__loginController;
void (^__loginSuccessBlock)();

+ (XKSLoginViewController *)loginController{
    if (!__loginController) {
        UIStoryboard *storyBoard = customStoryBoard(XKSLoginModuleBundleName, @"XKSLoginViewController");
        NSCParameterAssert(storyBoard);
        __loginController = [storyBoard instantiateInitialViewController];
    }
    return __loginController;
}

+ (void)loginSuccess:(void (^)(NSString *))success{
    NSCParameterAssert(success);
    __loginSuccessBlock = success;
    [self loginController].successBlock = success;
}


+ (void)logout{
    CATransition *animation = [CATransition animation];
    animation.type =@"rippleEffect";
    [animation setDuration:0.6];
    [animation setRepeatCount:1.0];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow.layer addAnimation:animation forKey:@"rippleEffect"];
    
    [self loginController].successBlock = __loginSuccessBlock;
    keyWindow.rootViewController = [self loginController];
}

+ (void)showSetting:(void (^)(UIViewController *))block{
    [self loginController].showSetting = block;
}

+ (XKSOperator *)LoginOperator{
    return [XKSOperator shareXKSOperator];
}

+ (void)excessiveAnimation:(BOOL)animation{
    NSLog(@"只是用来举个栗子");
}


+ (void)deprecateFunction{
    NSLog(@"此方法已经废弃");
}

@end
