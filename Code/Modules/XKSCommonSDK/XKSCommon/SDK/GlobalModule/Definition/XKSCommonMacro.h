//
//  XKSCommonMacro.h
//  XKSCommonSDK
//
//  Created by _Finder丶Tiwk on 16/1/12.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#ifndef XKSCommonMacro_h
#define XKSCommonMacro_h

//Readme :宏的变量尽量使用两个下划线开着 __这样比较容易看


#pragma mark - 自动提示宏

/**
 *  @author _Finder丶Tiwk, 16-01-27 17:01:13
 *
 *  @brief 可以将对象的属性转化为字符串,并且可以出现自动提示(用一下你就知道有多神奇了)
 *  @param __obj     NSObject对象
 *  @param __keyPath 对象的属性
 *  @return 对象属性对应的字符串
 *  @since v0.1.0
 */
#define keyPath(__obj,__keyPath)   @(((void)__obj.__keyPath,#__keyPath))

#pragma mark - 版本&API控制
/**
 *  @author _Finder丶Tiwk, 15-11-12 10:11:37
 *
 *  @brief  用于废弃过时的API
 *  @param __version 从某个版本开始废弃
 *  @param __message 提示信息
 *  @since v0.1.0
 */
#define XKS_DEPRECATE(__version,__message)    __attribute__((deprecated(__message)))
/**
 *  @author _Finder丶Tiwk, 15-11-12 10:11:02
 *
 *  @brief  用于禁用某API
 *  @param __verison 从某个版本开始禁用
 *  @param __message 提示信息
 *  @since v0.1.0
 */
#define XKS_UNAVAILABLE(__verison,__message)  __attribute__((unavailable(__message)))

#pragma mark - 单例
/**
 *  @author _Finder丶Tiwk, 16-01-12 19:01:30
 *
 *  @brief 单例声明
 *  @param __className 类名
 *  @return 单例
 *  @since v0.1.0
 */
#define singleton(__className) \
+ (__className *)share##__className;

/**
 *  @author _Finder丶Tiwk, 16-01-12 19:01:08
 *
 *  @brief 单例的实现
 *  @param __className 类名
 *  @return 单例
 *  @since v0.1.0
 */
#define singletonImpl(__className) \
static __className *_instance; \
+ (id)allocWithZone:(NSZone *)zone{\
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
+ (__className *)share##__className{\
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
}

#pragma mark - 颜色
/**
 *  @author _Finder丶Tiwk, 16-01-12 19:01:48
 *
 *  @brief UIColor初始化宏
 *  @param __r 红色
 *  @param __g 绿色
 *  @param __b 蓝色
 *  @param __a 透明度
 *  @return RGB颜色
 *  @since v0.1.0
 */
#define RGBACOLOR(__r,__g,__b,__a) \
[UIColor colorWithRed:(__r)/255.0f green:(__g)/255.0f blue:(__b)/255.0f alpha:(__a)]

#define RGBCOLOR(__r,__g,__b)  RGBACOLOR(__r,__g,__b,1)


#pragma mark - Block循环引用

/**
 *  @author _Finder丶Tiwk, 16-01-13 15:01:04
 *  这个宏灵感来源于ReactiveCocoa EXTScope.h
 *  使用方法如下,注意前面的@符号 :
        @xWeakify
        [obj block:^{
            @xStrongify
            [self doAnything];
            self.property = something;
        }];
 *  @since v0.1.0
 */
#ifndef    xWeakify
    #if __has_feature(objc_arc)
        #define xWeakify autoreleasepool{} __weak __typeof__(self) weakRef = self;
    #else
        #define xWeakify autoreleasepool{} __block __typeof__(self) blockRef = self;
    #endif
#endif

#ifndef     xStrongify
    #if __has_feature(objc_arc)
        #define xStrongify try{} @finally{} __strong __typeof__(weakRef) self = weakRef;
    #else
        #define xStrongify try{} @finally{} __typeof__(blockRef) self = blockRef;
    #endif
#endif

#endif /* XKSCommonMacro_h */
