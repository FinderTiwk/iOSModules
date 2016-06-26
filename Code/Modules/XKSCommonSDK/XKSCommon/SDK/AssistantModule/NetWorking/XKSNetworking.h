//
//  XKSNetworking.h
//  XKSNetworking
//
//  Created by _Finder丶Tiwk on 16/4/11.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XKSRequestParameter.h"


#pragma mark - 请求失败返回的信息对应的Key值
UIKIT_EXTERN NSString *const kXKSNetworkingUserInfo_Code;
UIKIT_EXTERN NSString *const kXKSNetworkingUserInfo_Msg;
UIKIT_EXTERN NSString *const kXKSNetworkingUserInfo_Type;


/**
 *  @author _Finder丶Tiwk, 15-08-18 16:08:58
 *
 *  @brief  网络请求工具类
 *  @since v1.0.0
 */
@interface XKSNetworking : NSObject

/**
 *  @author _Finder丶Tiwk, 16-04-12 00:04:01
 *
 *  @brief 同步请求
 *  @param parameter    请求参数对象
 *  @param successBlock 请求成功回调
 *  @param failureBlock 请求失败回调
 *  @since v1.0.0
 */

+ (void)syncWithParameter:(XKSRequestParameter *)parameter
                  success:(void(^)(id collection))successBlock
                  failure:(void(^)(NSDictionary *userInfo))failureBlock;

/**
 *  @author _Finder丶Tiwk, 16-04-12 00:04:01
 *
 *  @brief 同步请求
 *  @param parameter    请求参数对象
 *  @param startBlock   请求开始回调
 *  @param successBlock 请求成功回调
 *  @param failureBlock 请求失败回调
 *  @since v1.0.0
 */
+ (void)syncWithParameter:(XKSRequestParameter *)parameter
                    start:(void(^)())startBlock
                  success:(void(^)(id collection))successBlock
                  failure:(void(^)(NSDictionary *userInfo))failureBlock;


/**
 *  @author _Finder丶Tiwk, 16-04-12 00:04:01
 *
 *  @brief 异步步请求
 *  @param parameter    请求参数对象
 *  @param successBlock 请求成功回调
 *  @param failureBlock 请求失败回调
 *  @since v1.0.0
 */

+ (void)asyncWithParameter:(XKSRequestParameter *)parameter
                   success:(void(^)(id collection))successBlock
                   failure:(void(^)(NSDictionary *userInfo))failureBlock;
/**
 *  @author _Finder丶Tiwk, 16-04-12 00:04:01
 *
 *  @brief 异步步请求
 *  @param parameter    请求参数对象
 *  @param startBlock   请求开始回调
 *  @param successBlock 请求成功回调
 *  @param failureBlock 请求失败回调
 *  @since v1.0.0
 */
+ (void)asyncWithParameter:(XKSRequestParameter *)parameter
                    start:(void(^)())startBlock
                  success:(void(^)(id collection))successBlock
                  failure:(void(^)(NSDictionary *userInfo))failureBlock;

@end
