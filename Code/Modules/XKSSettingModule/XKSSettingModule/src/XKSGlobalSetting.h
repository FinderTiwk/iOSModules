//
//  XKSGlobalSetting.h
//  XKSSettingModule
//
//  Created by _Finder丶Tiwk on 16/6/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XKSCommonSDK/XKSCommonMacro.h>

@interface XKSGlobalSetting : NSObject

singleton(XKSGlobalSetting)

/*! 是否开启商品货架*/ 
@property (nonatomic,assign) BOOL goodsShelf;
/*! IP地址*/ 
@property (nonatomic,copy) NSString *ipAdress;

@end
