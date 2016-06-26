//
//  XKSEncryptor.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/15.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "XKSCommonEnumeration.h"

#pragma mark 签名返回字符中的一些KEY的名字
UIKIT_EXTERN NSString *const XKSSignater_HEADER;
UIKIT_EXTERN NSString *const XKSSignater_SIGN;
UIKIT_EXTERN NSString *const XKSSignater_SIGNTYPE;
UIKIT_EXTERN NSString *const XKSSignater_RESULT;
UIKIT_EXTERN NSString *const XKSSignater_DATA;
UIKIT_EXTERN NSString *const XKSSignater_URI;


/**
 *  @author _Finder丶Tiwk, 16-01-21 00:01:04
 *
 *  @brief 爱客仕加密验签工具类
 *  @since v0.1.0
 */
@interface XKSEncryptor : NSObject

#pragma mark - 签名
/**
*  @author _Finder丶Tiwk, 16-01-21 00:01:18
*
*  @brief 根据请求参数字典和URI来进行签名
*  @param params   请求参数字典
*  @param uri      请求URI
*  @param strategy 加密策略
*  @return NSDictionary{
*    header: {       //这个直接放到请求头
*        sign:xxxxxx
*        signType: MD5/RSA....
*    },
*    result : {
*        uri: xxxxx //用Host拼接URI来请求
*        data: {}, //取这个字典作为请求参数字典 如果字典为空，则为GET请求,请求参数传nil
*    }
* }
*  @since v0.1.0
*/
+ (NSDictionary *)signWithRequestParams:(NSDictionary *)params
                                    uri:(NSString *)uri
                               strategy:(XKSEncryptStrategy)strategy;
/**
 *  @author _Finder丶Tiwk, 16-01-21 00:01:00
 *
 *  @brief 根据请求参数字典 和 URI来进行签名
 *  @param params 请求参数字典
 *  @param uri    请求URI
 *  @return NSDictionary
 *  @since v0.1.0
 */
+ (NSDictionary *)signWithRequestParams:(NSDictionary *)params
                                    uri:(NSString *)uri;

#pragma mark - 验签
/**
 *  @author _Finder丶Tiwk, 16-01-21 00:01:54
 *
 *  @brief 验证签名
 *  @param aString 服务器返回的JSON格式字符串(不要把响应当成字典再转成Json字符串) eg:(AFHTTPRequestOperation *)operation.responseString
 *  @param header  HTTP请求响应头
 *  @param error   错误对象地址
 *  @return 签名是否正确
 *  @since v0.1.0
 */
+ (BOOL)validateResponseString:(NSString *)aString
                        header:(NSDictionary *)header
                         error:(NSError *__autoreleasing *)error;


@end
