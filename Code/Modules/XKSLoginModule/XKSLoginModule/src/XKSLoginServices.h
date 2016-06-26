//
//  XKSLoginServices.h
//  XKSLoginModule
//
//  Created by _Finder丶Tiwk on 16/6/7.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XKSLoginViewController.h"
#import "XKSOperator.h"

UIKIT_EXTERN NSString *const XKSLoginModuleBundleName;

@interface XKSLoginServices : NSObject


- (instancetype)init XKS_UNAVAILABLE(1.1.0,"此模块的所有API请调用类方法");

#pragma mark - Getter
/**
 *  @author _Finder丶Tiwk, 16-06-07 15:06:55
 *
 *  @brief 返回登录控制器
 *  @since v1.1.0
 */
+ (XKSLoginViewController *)loginController;


/**
 *  @author _Finder丶Tiwk, 16-06-07 15:06:00
 *
 *  @brief 登录的用户
 *  @return 用户对象实例
 *  @since v1.1.0
 */
+ (XKSOperator *)LoginOperator;


#pragma mark - Setter


/******************** 必须调用的方法******************/

/**
 *  @author _Finder丶Tiwk, 16-06-07 15:06:39
 *
 *  @brief 登录成功结果回调
 *  @param success 成功回调
 *  @since v1.1.0
 */
+ (void)loginSuccess:(void (^)(NSString *message))success;

/**
 *  @author _Finder丶Tiwk, 16-06-07 18:06:24
 *
 *  @brief 退出登录回调
 *  @param block 回调
 *  @since v1.1.0
 */
+ (void)logout;



/**
 *  @author _Finder丶Tiwk, 16-06-08 00:06:08
 *
 *  @brief 显示设置界面
 *  @param block 具体实现回调
 *  @since v1.1.0
 */
+ (void)showSetting:(void (^)(UIViewController *parent))block;


/******************** 偏好设置调用的方法******************/

/**
 *  @author _Finder丶Tiwk, 16-06-08 00:06:18
 *
 *  @brief 是否加入转场过度动画(默认为YES)
 *  @param animation YES转场时有动画 NO转场时没有动画效果
 *  @since v1.1.0
 */
+ (void)excessiveAnimation:(BOOL)animation;




/**
 *  @author _Finder丶Tiwk, 16-06-08 00:06:05
 *
 *  @brief 用来演示要废弃的某个API
 *  @since v1.1.1
 */
+ (void)deprecateFunction XKS_DEPRECATE(1.0.0, "此方法已经被废弃，推荐使用xxxx方法");


@end
