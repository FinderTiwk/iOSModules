//
//  XKSHomeServices.h
//  XKSHomeModule
//
//  Created by _Finder丶Tiwk on 16/6/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSHomeViewController.h"
#import <XKSCommonSDK/XKSCommonMacro.h>

UIKIT_EXTERN NSString *const XKSHomeModuleBundleName;

@interface XKSHomeServices : NSObject

- (instancetype)init XKS_UNAVAILABLE(1.1.0,"此模块的所有API请调用类方法");

+ (XKSHomeViewController *)homeController;

@end
