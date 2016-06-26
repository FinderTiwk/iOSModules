//
//  XKSSystemObj.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/14.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKSCommonMacro.h"
#import "XKSCommonEnumeration.h"

/**
 *  @author _Finder丶Tiwk, 16-01-19 14:01:03
 *
 *  @brief 系统参数对象模型
 *  @since v0.1.0
 */
@interface XKSSystemObj : NSObject

singleton(XKSSystemObj)
- (instancetype)init XKS_UNAVAILABLE(0.1,"此方法已经废弃,请调用 [XKSSystemObj sharedXKSSystemObj]");

#pragma mark - 域名后台相关
/*! 商户ID*/
@property (nonatomic,copy) NSString *shopId;
/*! 设备唯一标识*/
@property (nonatomic,copy) NSString *deviceNumber;
/*! 操作员ID*/
@property (nonatomic,copy) NSString *operatorId;
/*! 操作员会员*/
@property (nonatomic,copy) NSString *operatorSessionCode;

/*! SDK Mode*/
@property (nonatomic,assign) XKSSDKEnvironment enviroment;
/*! 自定义域名*/
@property (nonatomic,copy) NSString *customDomain;
/*! 自定义请求头,用于后端兼容API*/
@property (nonatomic,strong) NSDictionary *customRequestHeader;

/*! 当前设置的域名,会根据XKSSDKEnvironment 的值来返回对应的域名,
    如果是XKSSDKEnvironment_Custom,但没有设置customDomain
    会返回XKSSDKEnvironment_Debug对应的域名*/
@property (nonatomic,readonly) NSString *currentDomain;


#pragma mark - 加密相关
/*! 应用唯一标识*/
@property (nonatomic,copy) NSString *appKey;
/*! 接口数据加密方式 根据所选加密方式设置以下几个加密要用到的参数*/
@property (nonatomic,assign) XKSEncryptType encryptType;
/*! 加密方式字符串*/ 
@property (nonatomic,readonly) NSString *encrypTypeString;
/*! MD5密钥*/
@property (nonatomic,copy) NSString *md5Secret;
/*! RSA客户端私钥*/
@property (nonatomic,copy) NSString *rsa_privateKey_C;
/*! RSA服务端公钥*/
@property (nonatomic,copy) NSString *rsa_publicKey_S;
/*! AES加密密钥*/
@property (nonatomic,copy) NSString *aes_Secret;
/*! 是否开启签名*/
@property (nonatomic,assign) BOOL signaterEnable;
/*! 是否开启验签*/
@property (nonatomic,assign) BOOL validateEnable;


extern void XKSLog (NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

@end
