//
//  XKSRequestParameter.m
//  XKSNetworking
//
//  Created by _Finder丶Tiwk on 16/4/12.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <UIKit/UIDevice.h>
#import "XKSRequestParameter.h"
#import "XKSSystemObj.h"
#import "XKSCommonFunction.h"

@implementation XKSRequestParameter{
    NSDictionary *__requestDic;
    NSString *__requestUrlString;
}

- (NSString *)requestMethodString{
    if (_requestMethod == XKSRequestMethod_GET) {
        return @"GET";
    }
    else if (_requestMethod == XKSRequestMethod_POST){
        return @"POST";
    }
    else if (_requestMethod == XKSRequestMethod_PUT){
        return @"PUT";
    }
    else if (_requestMethod == XKSRequestMethod_DELETE){
        return @"DELETE";
    }
    else if (_requestMethod == XKSRequestMethod_HEAD){
        return @"HEAD";
    }
    else if (_requestMethod == XKSRequestMethod_OPTIONS){
        return @"OPTIONS";
    }
    else if (_requestMethod == XKSRequestMethod_CONNECT){
        return @"CONNECT";
    }
    else if (_requestMethod == XKSRequestMethod_TRACE){
        return @"TRACE";
    }else{
        return @"GET";
    }
}


- (NSURLRequest *)urlRequest{
    // 1.为请求的参数添加系统参数
    XKSSystemObj *systemObj   = [XKSSystemObj shareXKSSystemObj];
    
    NSCParameterAssert(systemObj.shopId);
    NSCParameterAssert(systemObj.deviceNumber);
    if (systemObj.encryptType == XKSEncryptType_MD5) {
        NSCParameterAssert(systemObj.md5Secret);
    }
    
    else if (systemObj.encryptType == XKSEncryptType_RSA){
        NSCParameterAssert(systemObj.rsa_publicKey_S);
        NSCParameterAssert(systemObj.rsa_privateKey_C);
    }
    
    if (!_parameterDictionary) {
        _parameterDictionary = [NSMutableDictionary dictionaryWithCapacity:2];
    }
    if (![[_parameterDictionary allKeys] containsObject:@"shopId"]) {
        //商户号
        [_parameterDictionary setObject:systemObj.shopId forKey:@"shopId"];
        [_parameterDictionary setObject:systemObj.deviceNumber forKey:@"deviceNumber"];
    }
    
    // 2.对请求参数签名
    NSDictionary *signaterDictionary;
    if (_requestMethod == XKSRequestMethod_POST ||
        _requestMethod == XKSRequestMethod_PUT) {
        signaterDictionary = [XKSEncryptor signWithRequestParams:self.parameterDictionary uri:self.apiString strategy:XKSEncryptStrategy_B];
    }else{
        signaterDictionary = [XKSEncryptor signWithRequestParams:self.parameterDictionary uri:self.apiString];
    }
    
    NSDictionary *resultDic = signaterDictionary[XKSSignater_RESULT];

    // 3.根据签名字典拿到请求URI并拼接域名
    NSString *uriString = resultDic[XKSSignater_URI];
    NSString *domain    = systemObj.currentDomain;
    
    // 3.1 请求中如果有中文,一定要将请求URL转码
    NSString *urlString = [[NSString stringWithFormat:@"%@%@",domain,uriString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    __requestUrlString = urlString;
    
    // 4.根据请求urlString生成请求对象
    NSURL *requestUrl            = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    
    // 5. 配置请求对象
    {
        //设置请求传输数据类型
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

        // 设置自定义请求头
        if (systemObj.customRequestHeader) {
            [request setAllHTTPHeaderFields:systemObj.customRequestHeader];
        }
        
        //设置请求头
        [request setAllHTTPHeaderFields:signaterDictionary[XKSSignater_HEADER]];
        
        //设置请求超时时间
        request.timeoutInterval = 60;
        //设置请求方法
        request.HTTPMethod      = self.requestMethodString;
        
        //设置请求体参数
        NSDictionary *requestDic = resultDic[XKSSignater_DATA];
        if (systemObj.signaterEnable) {
            request.HTTPBody = [requestDic[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
            __requestDic = requestDic;
        }else{
            NSMutableDictionary *mDic = [requestDic mutableCopy];
            mDic[@"appId"] = systemObj.appKey;
            NSString *jsonString = collection2JsonString(mDic);
            request.HTTPBody = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            __requestDic = mDic;
        }    }
    return request;
}

#pragma mark - 用于调试的Log
- (NSString *)description{
    XKSSystemObj *systemObj = [XKSSystemObj shareXKSSystemObj];
    XKSLog(@"加密方式 ：%@",systemObj.encrypTypeString);
    XKSLog(@"=========================================");
    XKSLog(@"请求URL(%@): %@",self.requestMethodString,__requestUrlString);
    XKSLog(@"=============请求头=================");
    XKSLog(@"=========================================");
    XKSLog(@"\r\n");
    XKSLog(@"=============请求体参数列表=================");
    __block NSUInteger currentIndex=0;
    [self.parameterDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        XKSLog(@"#%zi %@ = %@",++currentIndex,key,obj);
    }];
    XKSLog(@"=========================================");
    XKSLog(@"\r\n");
    return @"";
}

@end
