//
//  BaseSignater.m
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/15.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "BaseSignater.h"

NSString *const XKSSignater_HEADER   = @"header";
NSString *const XKSSignater_SIGN     = @"sign";
NSString *const XKSSignater_SIGNTYPE = @"signType";
NSString *const XKSSignater_RESULT   = @"result";
NSString *const XKSSignater_DATA     = @"data";
NSString *const XKSSignater_URI      = @"uri";

@implementation BaseSignater

+ (NSDictionary *)signWithRequestParams:(NSDictionary *)params
                                    uri:(NSString *)uri
                               strategy:(XKSEncryptStrategy)strategy
                               signType:(NSString *)signType
                              signBlock:(NSString *(^)(NSString *))signBlock{
    
    if (![params isKindOfClass:[NSDictionary class]] || params.count == 0) {
        params = @{};
    }
    
    if (![uri isKindOfClass:[NSString class]] || uri.length == 0) {
        uri = @"";
    }
    
    XKSSystemObj *systemObj = [XKSSystemObj shareXKSSystemObj];
    
    BOOL enable = systemObj.signaterEnable;
    
    if (!enable) {
        NSDictionary *result = @{XKSSignater_HEADER: @{},
                                 XKSSignater_RESULT: @{XKSSignater_URI: uri,
                                                       XKSSignater_DATA: params}};
        return result;
    }
    
    NSString *appID = systemObj.appKey;
    if (!appID || appID.length==0) {
        NSAssert(NO, @"<XKSSystemObj> -- appKey没有设置");
    }
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSString *signatureString = @"";
    
    params = [self completionParamsWithParams:params];
    
    //Get/Delete规则...
    if (strategy == XKSEncryptStrategy_A) {
        NSMutableString *uriString;
        NSMutableString *paramsString = [NSMutableString string];
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [paramsString appendFormat:@"&%@=%@",key,obj];
        }];
        if (paramsString.length > 0) {
            [paramsString deleteCharactersInRange:NSMakeRange(0, 1)];
        }
        
        if ([uri rangeOfString:@"?"].location == NSNotFound) {
            uriString = [NSMutableString stringWithFormat:@"%@?%@",uri,paramsString];
        }else{
            if ([uri hasSuffix:@"&"]) {
                uriString = [NSMutableString stringWithFormat:@"%@%@",uri,paramsString];
            }else{
                uriString = [NSMutableString stringWithFormat:@"%@&%@",uri,paramsString];
            }
        }
        uri = uriString;
        params = @{};
        
        signatureString = [NSString stringWithFormat:@"%@", uri];
    }
    //POST/PUT规则...
    else if(strategy == XKSEncryptStrategy_B){
        NSString *dataString = collection2JsonString(params);
        params = @{@"data":dataString};
        signatureString = [NSString stringWithFormat:@"data=%@&path=%@", dataString, uri];
    }
    
    NSString *sign = signBlock(signatureString);
    result[XKSSignater_HEADER] = @{
                                   XKSSignater_SIGN:sign,
                                   XKSSignater_SIGNTYPE:signType
                                   };
    result[XKSSignater_RESULT] = @{XKSSignater_URI:uri,
                                   XKSSignater_DATA:params};
    return result;

}


+ (NSDictionary *)completionParamsWithParams:(NSDictionary *)params{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] * 1000.f;
    NSDictionary *specialParams = @{@"appId": [XKSSystemObj shareXKSSystemObj].appKey,
                                    @"timestamp": [NSNumber numberWithLongLong:(long long)time]};
    NSMutableDictionary *completionParams = [NSMutableDictionary dictionary];
    if (specialParams) {
        [completionParams addEntriesFromDictionary:specialParams];
    }
    if (params) {
        [completionParams addEntriesFromDictionary:params];
    }
    return [NSDictionary dictionaryWithDictionary:completionParams];
}
@end
