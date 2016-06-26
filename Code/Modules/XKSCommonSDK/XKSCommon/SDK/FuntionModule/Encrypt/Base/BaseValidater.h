//
//  BaseValidater.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/15.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XKSCommonEnumeration.h"
#import "XKSCommonFunction.h"
#import "XKSSystemObj.h"
#import "XKSValidater.h"

/**
 *  @author _Finder丶Tiwk, 16-01-21 00:01:57
 *
 *  @brief 所有验签类的基类
 *  @since v0.1.0
 */
@interface BaseValidater : NSObject

/**
*  @author _Finder丶Tiwk, 16-01-15 17:01:39
*
*  @brief 验签
*  @param aString       服务器返回的JSON格式字符串
*  @param header        服务器响应头
*  @param signType      服务器数据加密类型
*  @param error         错误信息对象
*  @param validateBlock 验签回调
*  @return 是否验证成功
*  @since v0.1.0
*/
+ (BOOL)validateResponseString:(NSString *)aString
                        header:(NSDictionary *)header
                      signType:(NSString *)signType
                         error:(NSError *__autoreleasing *)error
                 validateBlock:(BOOL (^)(NSString *plainString,NSString *sign))validateBlock;

@end
