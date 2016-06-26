# 工程目录结构

## 1.AppleDoc(SDK目录下所有文件生成的帮助文档)

## 2.Resources(SDK使用到的所有资源,包括图片，音频等)

## 3.Vendor(SDK所依赖的第三方库)
| 第三方库 | 备注 |
|--------|--------|
|    OpenSSL       |      不解释  |


## 4.Script(一些编译脚本)

## 5.SDK(SDK源码目录)

- 5.1PluginModule(插件模块)

| 子模块 | 备注 |对应的类头文件|
|--------|--------|--------|
|    Layer   | 一些自定义图层  |XKSShapeLayer.h，XKSVideoPreviewLayer.h，QRMaskLayer.h|

- 5.2AssistantModule(辅助模块)

| 子模块 | 备注 |对应的类头文件|
|--------|--------|--------|
|    Network    |      网络请求  |XKSNetworking.h|
|    Categroy    |      分类扩展  |UIView+Frame.h，UIImage+Xkeshi.h|
|    Function    |      全局C函数  |XKSCommonFunction.h|

- 5.3FuntionModule(完整功能模块)

| 子模块 | 备注 |对应的类头文件|
|--------|--------|--------|
|    Binding    |      绑定功能  |XKSDeviceBindingViewController.h|
|    AlertView    |      自定义Alert，推荐使用XKSAlertWindow,它的优先级为MAX  |XKSAlertWindow.h|
|    Encrypt    |      加密签名验签,目前包含MD5,RSA  | "XKSEncryptor.h"|
|    QRCode    |      二维码扫描  | QRCodeView.h |

- 5.4GlobalModule(全局配置模块)

| 子模块 | 备注 |对应的类头文件|
|--------|--------|--------|
|    Configuration |      所有其它完整功能模块所依赖的配置类  |XKSSystemObj.h|
|    Definition    |      全局提示信息，宏，错误码，枚举定义模块  | XKSCommonTips.h，XKSCommonMacro.h，XKSCommonErrorCode.h，XKSCommonEnumeration.h|