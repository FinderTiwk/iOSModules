//
//  XKSCommonTips.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/12.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#ifndef XKSCommonTips_h
#define XKSCommonTips_h

//Readme :这里定义全局通用提示信息

#pragma mark - 网络相关提示
static NSString *const kXKSCommon_Tip_Hijack
= @"签名验证失败,请检查网络状况是否安全."; /**< 签名验证失败提示信息*/

static NSString *const kXKSCommon_Tip_Network
= @"初始化NSMutableURLRequest失败";  /**< 内部网络组件初始化失败*/


#pragma mark - 隐私权限相关提示
static NSString *const kXKSCommon_Tip_Bluetooth
= @"您的设备未连接蓝牙POS,您可以前往\"设置\"-->\"蓝牙\"当中连接POS机";  /**< 连接Pos机错误提示信息*/

static NSString *const kXKSCommon_Tip_Location
= @"定位失败，请开启定位:设置 > 隐私 > 位置 > 定位服务"; /**< 定位失败提示信息*/

static NSString *const kXKSCommon_Tip_Camera
= @"请在系统设置-隐私-相机里面把本应用程序对应的开关打开后才能使用扫描功能。"; /**< 照相机没打开*/

#pragma mark - 服务器相关提示
static NSString *const kXKSCommon_Tip_Server
= @"服务器返回数据异常";  /**< 服务器返回数据异常*/

static NSString *const kXKSCommon_Tip_Offile
= @"此操作不支持离线."; /**< 离线操作错误提示信息*/

#pragma mark - 设备绑定相关提示




#endif /* XKSCommonTips_h */
