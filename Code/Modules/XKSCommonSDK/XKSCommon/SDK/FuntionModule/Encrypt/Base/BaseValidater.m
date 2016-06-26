//
//  BaseValidater.m
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/15.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "BaseValidater.h"

@implementation BaseValidater

+ (BOOL)validateResponseString:(NSString *)aString
                        header:(NSDictionary *)header
                      signType:(NSString *)signType
                         error:(NSError *__autoreleasing *)error
                 validateBlock:(BOOL (^)(NSString *, NSString *))validateBlock{
    
    XKSSystemObj *systemObj = [XKSSystemObj shareXKSSystemObj];
    
    BOOL enable = systemObj.validateEnable;
    
    if (!enable) {
        return YES;
    }
    NSString *errorMsg;
    BOOL     flag = YES;
    
    if (!header  || ![header isKindOfClass:[NSDictionary class]]) {
        errorMsg = @"响应头里没有签名内容";
        flag = NO;
    }
    
    NSString *signType_S = header[@"signType"];
    if (![signType_S isEqualToString:signType]) {
        errorMsg = [NSString stringWithFormat:@"服务器使用的签名方法为 %@,当前使用的验签方法为 %@",signType,signType];
        flag = NO;
    }
    
    if (![aString isKindOfClass:[NSString class]] || aString.length == 0) {
        flag = NO;
        errorMsg = @"服务器没有返回或者所传参数不是一个标准的JSON格式字符串";
    }
    
    if (!flag) {
        *error = [NSError errorWithDomain:@"www.xkeshi.com" code:-1 userInfo:@{@"msg":errorMsg}];
        return NO;
    }
    
    NSString *sign = header[@"sign"];
    NSString *jsonString = [NSString stringWithFormat:@"data=%@",aString];
    return validateBlock(jsonString,sign);
}

@end
