//
//  ViewController.h
//  XKSDeviceBindingViewController
//
//  Created by YrionPlus on 12/23/15.
//  Copyright © 2015 Xkeshi. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  @author _Finder丶Tiwk, 16-01-21 00:01:02
 *
 *  @brief 绑定设备控制器
 *  @since v0.1.0
 */
@interface XKSDeviceBindingViewController : UIViewController


/**
 *  @author _Finder丶Tiwk, 16-01-20 19:01:20
 *
 *  @brief 类构造方法
 *  @param controller 当前界面正在显示的控制器
 *  @return 实例对象
 *  @since v0.1.0
 */
+ (instancetype)controllerWithDisplayController:(UIViewController *)controller;

/**
 *  @author _Finder丶Tiwk, 16-01-21 00:01:38
 *
 *  @brief 绑定设备
 *  @param block 绑定回调,(如果绑定成功,resultDictionary里会返回相应的商户信息,kDeviceBindedShopID,kDeviceBindedShopName,kDeviceBindedMobile,kDeviceBindedShopAddress)
 *  @since v0.1.0
 */
- (void)bindingWithBlock:(void(^)(NSDictionary *resultDictionary))block;

/**
 *  @author _Finder丶Tiwk, 16-01-20 19:01:27
 *
 *  @brief 解除绑定
 *  @since v0.1.0
 */
- (void)reset;

/**
 *  @author _Finder丶Tiwk, 16-01-20 19:01:07
 *
 *  @brief 获取绑定过的商户信息
 *     {
 *       kDeviceBindedShopID : "商户唯一标识"
 *       kDeviceBindedShopName : "商户名称"
 *       kDeviceBindedMobile: "商户联系方式"
 *       kDeviceBindedShopAddress : "商户地址"
 *    }
 *  @since v0.1.0
 */
+ (NSDictionary *)getShopInfomation;

@end

/*! 商户ShopID*/
UIKIT_EXTERN NSString *const kDeviceBindedShopID;
/*! 商户名称*/
UIKIT_EXTERN NSString *const kDeviceBindedShopName;
/*! 商户手机号*/
UIKIT_EXTERN NSString *const kDeviceBindedMobile;
/*! 商户地址*/
UIKIT_EXTERN NSString *const kDeviceBindedShopAddress;
