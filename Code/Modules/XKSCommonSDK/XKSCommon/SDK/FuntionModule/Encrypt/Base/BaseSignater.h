//
//  BaseSignater.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/15.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "XKSCommonEnumeration.h"
#import "XKSCommonFunction.h"
#import "XKSSystemObj.h"
#import "XKSSignater.h"

/**
 *  @author _Finder丶Tiwk, 16-01-21 00:01:32
 *
 *  @brief 所有签名类的基类
 *  @since v0.1.0
 */
@interface BaseSignater : NSObject
/**
 *  @author _Finder丶Tiwk, 16-01-15 19:01:07
 *
 *  @brief 签名方法
 *  @param params    请求参数字典
 *  @param uri       请求URI
 *  @param strategy  加密策略
 *  @param signType  加密类型
 *  @param signBlock 加密回调
 *  @return 签名完成后的字典数据结果
 *  @since v0.1.0
 */
+ (NSDictionary *)signWithRequestParams:(NSDictionary *)params
                                    uri:(NSString *)uri
                               strategy:(XKSEncryptStrategy)strategy
                               signType:(NSString *)signType
                              signBlock:(NSString * (^)(NSString *))signBlock;

@end
