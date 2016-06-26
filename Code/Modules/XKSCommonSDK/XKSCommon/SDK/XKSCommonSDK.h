//
//  XKSCommonSDK.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/13.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#ifndef XKSCommonSDK_h
#define XKSCommonSDK_h

// 凡是从我手里出来的代码，终身保修   - _Finder丶Tiwk


// |- SDK目录结构 ↓↓↓↓

// |--- PluginModule(插件模块)
// |------ Layer(一些自定义图层)
#import "XKSShapeLayer.h"
#import "XKSVideoPreviewLayer.h"
#import "QRMaskLayer.h"


// |--- AssistantModule(辅助模块)
// |------ Network(网络请求)
#import "XKSNetworking.h"
#import "XKSRequestParameter.h"
// |------ Categroy(分类扩展)
#import "UIView+Frame.h"
#import "UIView+Corner.h"
#import "UIImage+Xkeshi.h"
#import "NSString+Chinese.h"
// |------ Function(全局C函数)
#import "XKSCommonFunction.h"


// |--- FuntionModule(完整功能模块)
// |------ Binding(绑定功能)
#import "XKSDeviceBindingViewController.h"
// |------ AlertView(自定义Alert，推荐使用XKSAlertWindow,它的优先级为MAX)
#import "XKSAlertWindow.h"
// |------ Encrypt(加密签名验签,目前包含MD5,RSA)
#import "XKSEncryptor.h"
// |------ QRCode(扫码模块)
#import "QRCodeView.h"
// |------ PaperSwitch(带动效的Switch开关)
#import "PaperSwitch.h"
// |------ BluetoothList(蓝牙列表选择控件)
#import "BluetoothListViewcontroller.h"
// |------ Signature(电子签名页面)
#import "SignatureViewController.h"
// |------ XKSBillViewController(电子账单界面)
#import "XKSBillViewController.h"

// |--- GlobalModule(全局配置模块)
// |------ Configuration(所有其它完整功能模块所依赖的配置类)
#import "XKSSystemObj.h"
// |------ Definition(全局提示信息，宏，错误码，枚举定义模块)
#import "XKSCommonTips.h"
#import "XKSCommonMacro.h"
#import "XKSCommonErrorCode.h"
#import "XKSCommonEnumeration.h"


#endif /* XKSCommonSDK_h */
