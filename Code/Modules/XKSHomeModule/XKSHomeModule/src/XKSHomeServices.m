//
//  XKSHomeServices.m
//  XKSHomeModule
//
//  Created by _Finder丶Tiwk on 16/6/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSHomeServices.h"
#import <XKSCommonSDK/XKSCommonFunction.h>

NSString *const XKSHomeModuleBundleName = @"XKSHomeModule";

@implementation XKSHomeServices

+ (XKSHomeViewController *)homeController{
    UIStoryboard *storyboard = customStoryBoard(XKSHomeModuleBundleName, @"XKSHomeViewController");
    return [storyboard instantiateInitialViewController];
}

@end
