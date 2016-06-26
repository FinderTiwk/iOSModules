//
//  XKSEncryptor.m
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/15.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSEncryptor.h"

#import "XKSSystemObj.h"

#import "MD5Signater.h"
#import "MD5Validater.h"

#import "RSASignater.h"
#import "RSAValidater.h"

#import "DSASignater.h"
#import "DSAValidater.h"

static NSString *const kSignType_MD5 = @"MD5";
static NSString *const kSignType_RSA = @"RSA";
static NSString *const kSignType_DSA = @"DSA";

@implementation XKSEncryptor

#pragma mark - 签名
+ (NSDictionary *)signWithRequestParams:(NSDictionary *)params uri:(NSString *)uri strategy:(XKSEncryptStrategy)strategy{
    
    
    XKSSystemObj *systemObj = [XKSSystemObj shareXKSSystemObj];
    
    id<XKSSignater> signater;
    NSString *signType;
    
    if (systemObj.encryptType == XKSEncryptType_MD5) {
        signType = kSignType_MD5;
        signater = [[MD5Signater alloc] init];
    }
    else if(systemObj.encryptType == XKSEncryptType_RSA){
        signType = kSignType_RSA;
        signater = [[RSASignater alloc] init];
    }
    
    else if (systemObj.encryptType == XKSEncryptType_DSA){
        signType = kSignType_DSA;
        signater = [[DSASignater alloc] init];
    }
    
    return [BaseSignater signWithRequestParams:params uri:uri strategy:strategy signType:signType signBlock:^NSString *(NSString *plainString) {
        return [signater signString:plainString];
    }];;
}

+ (NSDictionary *)signWithRequestParams:(NSDictionary *)params uri:(NSString *)uri{
    return [self signWithRequestParams:params uri:uri strategy:XKSEncryptStrategy_A];
}


#pragma mark - 验签
+ (BOOL)validateResponseString:(NSString *)aString
                        header:(NSDictionary *)header
                         error:(NSError *__autoreleasing *)error{
    
    XKSSystemObj *systemObj = [XKSSystemObj shareXKSSystemObj];
    
    id<XKSValidater> validater;
    NSString *signType;
    
    if (systemObj.encryptType == XKSEncryptType_MD5) {
        signType  = kSignType_MD5;
        validater = [[MD5Validater alloc] init];
    }
    else if(systemObj.encryptType == XKSEncryptType_RSA){
        signType  = kSignType_RSA;
        validater = [[RSAValidater alloc] init];
    }
    
    else if (systemObj.encryptType == XKSEncryptType_DSA){
        signType  = kSignType_DSA;
        validater = [[DSAValidater alloc] init];
    }
    
    return [BaseValidater validateResponseString:aString header:header signType:signType error:error validateBlock:^BOOL(NSString *plainString, NSString *sign) {
        return [validater validateString:plainString sign:sign];
    }];
}


@end
