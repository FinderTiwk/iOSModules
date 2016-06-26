//
//  XKSCommonEnumeration.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/13.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

//这里放所有SDK共用的枚举,和一些类型别名

#ifndef XKSCommonEnumeration_h
#define XKSCommonEnumeration_h

static NSString *const XKSCommonSDKBundleName = @"XKSCommonSDK.bundle";

/*! 最简单无返回值无参数的的Block*/
typedef void(^XKSEmptyBlock)();

typedef NSUInteger XKSRequiredUInt; /**< 必传无符号整数*/
typedef NSUInteger XKSOptionalUInt; /**< 可选无符号整数*/

typedef NSString* XKSRequiredStr;   /**< 必传字符串*/
typedef NSString* XKSOptionalStr;   /**< 可选字符串*/

typedef NSArray*  XKSRequiredArray; /**< 必传数组*/
typedef NSArray*  XKSOptionalArray; /**< 可选数组*/

typedef NSDictionary* XKSRequiredDictionary;    /**< 必传字典*/
typedef NSDictionary* XKSOptionalDictionary;    /**< 可选字典*/


#pragma mark  1.SDK环境枚举
/**
 *  @author _Finder丶Tiwk, 16-01-13 15:01:07
 *
 *  @brief SDK环境枚举
 *  @since v0.1.0
 */
typedef NS_ENUM(NSUInteger,XKSSDKEnvironment) {
    /*! 开发调试环境*/
    XKSSDKEnvironment_Debug,
    /*! 开发内测环境*/
    XKSSDKEnvironment_Beta,
    /*! 正式发布环境*/
    XKSSDKEnvironment_Release,
    /*! 自定义环境*/
    XKSSDKEnvironment_Custom,
    /*! 默认为开发调试环境,请在正式发布时修改为Release*/
    XKSSDKEnvironment_Default = XKSSDKEnvironment_Debug
};

/**
 *  @author _Finder丶Tiwk, 15-08-18 16:08:58
 *
 *  @brief  Http网络请求8种方式
 *  @since v1.0.2
 */
typedef NS_ENUM(NSUInteger, XKSRequestMethod){
    /*! GET方式*/
    XKSRequestMethod_GET       =  0,
    /*! POST方式*/
    XKSRequestMethod_POST      =  1,
    /*! PUT方式*/
    XKSRequestMethod_PUT       =  2,
    /*! DELETE方式*/
    XKSRequestMethod_DELETE    =  3,
    /*! HEAD方式*/
    XKSRequestMethod_HEAD      =  4,
    /*! OPTIONS方式*/
    XKSRequestMethod_OPTIONS   =  5,
    /*! CONNECT方式*/
    XKSRequestMethod_CONNECT   =  6,
    /*! TRACE方式*/
    XKSRequestMethod_TRACE     =  7
};



/**
 *  @author _Finder丶Tiwk, 15-07-23 00:07:27、
 *
 *  @brief  支付方式
 *  @since v1.0.2
 */
typedef NS_OPTIONS(NSInteger, XKSPaymentType){
    /*! 现金*/
    XKSPaymentTypeCash          = 1<<0,
    /*! 支付宝*/
    XKSPaymentTypeAlibaba       = 1<<1,
    /*! 微信*/
    XKSPaymentTypeWechat        = 1<<2,
    /*! 银联Pos刷卡*/
    XKSPaymentTypeUnionPay      = 1<<3,
    /*! 中行Pos刷卡*/
    XKSPaymentTypeBocDzPos      = 1<<4,
    /*! 盛大Pos刷卡*/
    XKSPaymentTypeSndaPos       = 1<<5,
    /*! 实体卡*/
    XKSPaymentTypeEntityCard    = 1<<6,
    /*! 预付卡*/
    XKSPaymentTypePrepaidCard   = 1<<7,
    /*! 闪惠支付*/
    XKSPaymentTypeLightningPay  = 1<<8,
    /*! 实体券,代金券支付*/
    XKSPaymentTypeVoucher       = 1<<9,
    /*! 其它支付*/
    XKSPaymentTypeOthers        = 1<<10,
};

#pragma mark - 弹出框样式
/**
 *  @author _Finder丶Tiwk, 16-01-20 01:01:02
 *
 *  @brief 弹框类型
 *  @since v0.1.0
 */
typedef NS_ENUM(NSUInteger,XKSAlertType) {
    /*! 成功弹窗*/
    XKSAlertType_SUCCESS,
    /*! 失败弹窗*/
    XKSAlertType_FAILURE,
    /*! 警告弱窗*/
    XKSAlertType_WARNING
};


#pragma mark  3.数据上传时机枚举
/**
 *  @author _Finder丶Tiwk, 16-01-13 15:01:27
 *
 *  @brief 数据上传时机
 *  @since v0.1.0
 */
typedef NS_ENUM(NSUInteger, XKSUploadTiming) {
    /*! 自动上传(每个上传周期开始时上传)*/
    XKSUploadTimingAutomatically,
    /*! 立即上传*/
    XKSUploadTimingImmediately,
    /*! 默认为自动上传*/
    XKSUploadTimingDefault = XKSUploadTimingAutomatically
};


#pragma mark  4.数据库数据删除方式枚举
/**
 *  @author _Finder丶Tiwk, 16-01-14 10:01:50
 *
 *  @brief 数据库数据删除方式
 *  @since v0.1.0
 */
typedef NS_ENUM(NSUInteger,XKSDeleteType) {
    /*! 逻辑删除*/
    XKSDeleteTypeLogic,
    /*! 物理删除*/
    XKSDeleteTypePhysical,
    /*! 默认逻辑删除*/
    XKSDeleteTypeDefault = XKSDeleteTypeLogic
};

#pragma mark - 5.加密方式枚举
/**
 *  @author _Finder丶Tiwk, 16-01-14 14:01:32
 *
 *  @brief 加密方式枚举
 *  @since v0.1.0
 */
typedef NS_ENUM(NSUInteger,XKSEncryptType) {
    /*! MD5加密*/
    XKSEncryptType_MD5,
    /*! RSA加密*/
    XKSEncryptType_RSA,
    /*! DSA加密*/
    XKSEncryptType_DSA
};

/**
 *  @author _Finder丶Tiwk, 16-01-15 18:01:39
 *
 *  @brief 加密策略
 *  @since v0.1.0
 */
typedef NS_ENUM(NSUInteger,XKSEncryptStrategy) {
    /*! Get/Delete规则...*/
    XKSEncryptStrategy_A,
    /*! POST/PUT规则...*/
    XKSEncryptStrategy_B
};


#pragma mark - 6.矩形中的位置枚举
/**
 *  @author _Finder丶Tiwk, 16-01-12 19:01:19
 *
 *  @brief 矩形中的位置枚举
 *  @since v0.1.0
 */
typedef NS_ENUM(NSUInteger, XKSRectPosition) {
    /*! 左上角*/
    XKSRectPositionTopLeft,
    /*! 右上角*/
    XKSRectPositionTopRight,
    /*! 正中*/
    XKSRectPositionCenter,
    /*! 左下角*/
    XKSRectPositionBottomLeft,
    /*! 右下角*/
    XKSRectPositionBottomRight,
    /*! 默认为右下角*/
    XKSRectPositionDefault = XKSRectPositionBottomRight
};

#endif /* XKSCommonEnumeration_h */
