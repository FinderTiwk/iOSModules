//
//  XKSSystemObj.m
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/14.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSSystemObj.h"

static BOOL _XKSLogEnable = NO;

/*! 开发环境*/
static NSString *const APP_DOMAIN_DEBUG        = @"http://vip.test.xkeshi.so:8082";
/*! 内测环境*/
static NSString *const APP_DOMAIN_BETA         = @"http://vip.prepub.xkeshi.net";
/*! 发布环境*/
static NSString *const APP_DOMAIN_RELEASE      = @"http://vip.xkeshi.net";

static NSString *const kSignType_MD5 = @"MD5";
static NSString *const kSignType_RSA = @"RSA";
static NSString *const kSignType_DSA = @"DSA";

@implementation XKSSystemObj{
    NSString *_currentDomain; /**< 当前生效的域名*/
}

singletonImpl(XKSSystemObj)

- (void)setEnviroment:(XKSSDKEnvironment)enviroment{
    _enviroment = enviroment;
    switch (enviroment) {
        case XKSSDKEnvironment_Debug: {
            _XKSLogEnable = YES;
            _currentDomain = APP_DOMAIN_DEBUG;
            break;
        }
        case XKSSDKEnvironment_Beta: {
            _currentDomain = APP_DOMAIN_BETA;
            break;
        }
        case XKSSDKEnvironment_Release: {
            _currentDomain = APP_DOMAIN_RELEASE;
            break;
        }
        case XKSSDKEnvironment_Custom: {
            _XKSLogEnable = YES;
            if (_customDomain && _currentDomain.length >0) {
                _currentDomain = _customDomain;
            }else{
                _currentDomain = APP_DOMAIN_DEBUG;
            }
            break;
        }
    }
}

- (void)setCustomDomain:(NSString *)customDomain{
    _customDomain = customDomain;
    [self setEnviroment:XKSSDKEnvironment_Custom];
}

- (NSString *)currentDomain{
    return _currentDomain?:APP_DOMAIN_DEBUG;
}

- (NSString *)encrypTypeString{
    if (self.encryptType == XKSEncryptType_MD5) {
        return kSignType_MD5;
    }else if (self.encryptType == XKSEncryptType_RSA){
        return kSignType_RSA;
    }else if (self.encryptType == XKSEncryptType_DSA){
        return kSignType_DSA;
    }
    return nil;
}
@end


void XKSLog (NSString *format, ...){
    if (!_XKSLogEnable) {
        return;
    }
    const char *dateString = [[NSString stringWithFormat:@"%@",[NSDate date]] UTF8String];
    if (format == nil) {
        printf("%19.19s [🌴XKSLog] : nil \n",dateString);
        return;
    }
    va_list argList;
    va_start(argList, format);
    @autoreleasepool {
        NSString *parsedFormatString = [[NSString alloc] initWithFormat:format arguments:argList];
        printf("%19.19s [🌴XKSLog] : %s \n",dateString,parsedFormatString.UTF8String);
    }
    va_end(argList);
}

