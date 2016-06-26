//
//  XKSSettingServices.m
//  XKSSettingModule
//
//  Created by _Finder丶Tiwk on 16/6/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSSettingServices.h"
#import <XKSCommonSDK/XKSCommonFunction.h>

NSString *const XKSSettingModuleBundleName = @"XKSSettingModule";

@implementation XKSSettingServices

+ (XKSSettingViewController *)settingController{
    UIStoryboard *storyBoard = customStoryBoard(XKSSettingModuleBundleName, @"XKSSettingViewController");
    return [storyBoard instantiateInitialViewController];
}

@end
