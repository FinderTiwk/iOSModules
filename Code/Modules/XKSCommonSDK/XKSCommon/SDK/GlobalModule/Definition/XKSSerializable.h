//
//  XKSSerializable.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/5/10.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @author _Finder丶Tiwk, 16-05-10 09:05:24
 *
 *  @brief 通用对象序列化协议
 *  @since v1.0.2
 */
@protocol XKSSerializable <NSObject>

/**
 *  @author _Finder丶Tiwk, 16-05-10 09:05:52
 *
 *  @brief 用于序列化网络请求参数
 *  @return 请求字典
 *  @since v1.0.2
 */
@optional
- (NSDictionary *)serializeRequestParameters;

/**
 *  @author _Finder丶Tiwk, 16-05-10 09:05:28
 *
 *  @brief 用于序列化数据库存储参数
 *  @return 数据库字段与值组成的字典
 *  @since v1.0.2
 */
@optional
- (NSDictionary *)serializeDBStoreKeyValue;

@end
